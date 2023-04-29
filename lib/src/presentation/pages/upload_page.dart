import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:web_socket_channel/io.dart';
import 'package:youtube_clone_app/src/data/providers/raw_video_api.dart';
import 'package:youtube_clone_app/src/presentation/widgets/upload_details_form.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/common_widgets.dart';
import 'package:youtube_clone_app/src/utils/custom_loading.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/media_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone_app/src/utils/uppercase_textinputfromatter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _videoType = TextEditingController();

  final RawVideoApi _rawVideoApi = RawVideoApi();

  //
  bool _isVideoLoaded = false;

  String? _videoPath;

  // media manager
  final MediaManager _mediaManager = MediaManager();

  ChewieController? _chewieController;

  final List<String> _videoTypes = [
    'MUSIC',
    'DANCE',
    'COMEDY',
    'INFORMATIONAL',
    'EDUCATIONAL',
    'HEALTH_CARE'
  ];
  WebSocketChannel? _uploadSocket;

  @override
  void dispose() {
    super.dispose();

    if (_chewieController != null) {
      _chewieController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: VStack([
        HStack([
          // video box
          VxBox(
                  child: _isVideoLoaded == false
                      ? FaIcon(
                          FontAwesomeIcons.video,
                          color: gray,
                          size: CustomMediaQuery.makeSize(context, .45),
                        ).centered()
                      : Stack(children: [
                          Chewie(controller: _chewieController!),

                          //
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FaIcon(
                              FontAwesomeIcons.play,
                              color: white,
                              size: CustomMediaQuery.makeSize(context, .2),
                            ).pSymmetric(h: 10, v: 5).onTap(
                                  () => _chewieController!.isPlaying
                                      ? _chewieController!.pause()
                                      : _chewieController!.play(),
                                ),
                          )
                        ]))
              .size(CustomMediaQuery.makeWidth(context, .3),
                  CustomMediaQuery.makeHeight(context, .2))
              .rounded
              .border(color: white)
              .make()
              .onTap(_loadVideo),

          // details box
          UploadDetailsForm(
              formKey: _formKey, title: _title, description: _description),
        ]),

        // video type drop down
        CustomMediaQuery.makeHeight(context, .07).heightBox,

        VxTextField(
          borderColor: white,
          hint: 'Video Type',
          cursorColor: white,
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          style: TextStyle(color: white),
          hintStyle: TextStyle(color: gray),
          controller: _videoType,
          borderType: VxTextFieldBorderType.roundLine,
        ),

        // upload button
        CustomMediaQuery.makeHeight(context, .44).heightBox,
        MaterialButton(
          onPressed: _uploadVideo,
          child: VxBox(
                  child: 'Upload Video'
                      .text
                      .color(black)
                      .bold
                      .size(CustomMediaQuery.makeTextSize(context, .4))
                      .make()
                      .centered())
              .width(CustomMediaQuery.makeWidth(context, .86))
              .color(blue)
              .withRounded(value: CustomMediaQuery.makeRadius(context, .7))
              .height(CustomMediaQuery.makeHeight(context, .05))
              .makeCentered(),
        )
      ])
          .px(CustomMediaQuery.makeWidth(context, .04))
          .py(CustomMediaQuery.makeHeight(context, .02)),
    );
  }

  void _loadVideo() async {
    CustomLoading.showLoading(context);

    _videoPath = await _mediaManager.getVideo();

    if (_videoPath != null) {
      _isVideoLoaded = true;

      // load video
      VideoPlayerController controller =
          VideoPlayerController.file(File(_videoPath!));
      await controller.initialize();

      _chewieController = ChewieController(
          showControls: false,
          videoPlayerController: controller,
          autoPlay: true,
          looping: true);
    }

    CustomLoading.dismiss();

    if (mounted) {
      setState(() {});
    }
  }

  bool _validate() {
    _formKey.currentState!.validate();

    final String type = _videoType.text;

    if (!_videoTypes.contains(type)) {
      CommonWidgets.showSnackbar(context, message: 'Video type is invalid');

      return false;
    }

    if (_videoPath == null) {
      CommonWidgets.showSnackbar(context, message: 'Choose A Video');

      return false;
    }

    return true;
  }

  void _connectToSocket() async {
    final Uri uri =
        Uri.parse('ws://${CacheManager.apiHost}:8000/videos/upload');
    _uploadSocket = IOWebSocketChannel.connect(uri,
        headers: {'Authorization': CacheManager.token});
  }

  Future<Uint8List> _getThumbnail() async {
    final Uint8List? thumbnail = await VideoThumbnail.thumbnailData(
        video: _videoPath!, imageFormat: ImageFormat.PNG, quality: 100);

    return thumbnail!;
  }

  Future<Map<String, String>> _uploadMedia() async {
    // create a check
    final resolustion = _chewieController!.videoPlayerController.value.size;

    if (resolustion.height > 1080 || resolustion.width > 1080) {
      CommonWidgets.showSnackbar(context,
          message: 'Max Resolution can be 1080P');
      return {};
    }

    CustomLoading.showLoading(context);

    final Uint8List thumbnail = await _getThumbnail();
    final String thumbnailUploadKey =
        await _rawVideoApi.uploadRawImage(thumbnail);
    final String videoUploadKey =
        await _rawVideoApi.uploadRawVideo(_videoPath!);

    CustomLoading.dismiss();

    return {
      'thumbnail_upload_key': thumbnailUploadKey,
      'video_upload_key': videoUploadKey
    };
  }

  Future<void> _uploadVideo() async {
    final bool check = _validate();

    if (check) {
      final Map<String, String> data = await _uploadMedia();

      if (data.isEmpty) {
        return;
      }

      // add more data to it
      data['video_name'] = _title.text;
      data['video_type'] = _videoType.text;
      data['description'] = _description.text;

      final String jsonString = jsonEncode(data);

      _connectToSocket();

      _uploadSocket!.sink.add(jsonString);

      // ignore: use_build_context_synchronously
      CustomLoading.showLoading(context);
      _uploadSocket!.stream
          .listen((event) {}, onDone: () => CustomLoading.dismiss());
    }
  }
}
