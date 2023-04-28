import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/data/providers/videos_api.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.video});
  final Video video;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  final VideosApi _videosApi = VideosApi();

  ChewieController? _chewieController;

  final Map<String, String> actualResolutions = {};
  final List<String> pixcels = [];

  String? _uri;

  Future<void> _loadVideo(String uri) async {
    final String videoUrl = await _videosApi.getVideo(uri);
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network(videoUrl);

    await videoPlayerController.initialize();

    final ChewieController chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        zoomAndPan: true,
        materialProgressColors: ChewieProgressColors(
          handleColor: red,
          bufferedColor: white,
        ));

    _chewieController = chewieController;
  }

  @override
  void dispose() {
    if (_chewieController != null) {
      if (_chewieController!.isPlaying) {
        _chewieController!.pause();
      }

      _chewieController!.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _processUrls();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _loadVideo(_uri!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              strokeWidth: 3.4,
              color: red,
            )
                .centered()
                .box
                .size(CustomMediaQuery.makeWidth(context, 1.0),
                    CustomMediaQuery.makeHeight(context, .234))
                .make();
          }

          return Stack(
            children: [
              Chewie(controller: _chewieController!)
                  .box
                  .size(CustomMediaQuery.makeWidth(context, 1.0),
                      CustomMediaQuery.makeHeight(context, .3))
                  .makeCentered(),

              // resolution bar
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: FaIcon(
                    Icons.settings,
                    color: white,
                  ),
                  onPressed: _openResolutionSettingsSheet,
                ).p2(),
              )
            ],
          );
        });
  }

  Widget _resolutionButton(String resolution, String uri) {
    return resolution.text
        .color(white)
        .light
        .headline6(context)
        .makeCentered()
        .onTap(() {
          _uri = uri;

          setState(() {});

          context.pop();
        })
        .box
        .rounded
        .width(CustomMediaQuery.makeWidth(context, 1.0))
        .border(color: white)
        .height(CustomMediaQuery.makeHeight(context, .03))
        .makeCentered()
        .p8();
  }

  void _processUrls() {
    final Video video = widget.video;
    final resolutions = [
      video.video1080pS3Uri,
      video.video720pS3Uri,
      video.video480pS3Uri,
      video.video360pS3Uri,
      video.video240pS3Uri,
      video.video144pS3Uri,
    ];

    for (String? resolution in resolutions) {
      if (resolution != null) {
        final String pixcel = resolution.split('/').last.replaceAll('.mp4', '');
        pixcels.add(pixcel);

        actualResolutions[pixcel] = resolution;
      }
    }

    _uri = actualResolutions.values.first;
  }

  void _openResolutionSettingsSheet() async {
    await showModalBottomSheet(
        backgroundColor: black,
        context: context,
        builder: (context) {
          return VxBox(
                  child: ListView.builder(
                      itemCount: pixcels.length,
                      itemBuilder: ((context, index) {
                        return _resolutionButton(
                            pixcels[index], actualResolutions[pixcels[index]]!);
                      })))
              .color(black)
              .border(color: white)
              .width(CustomMediaQuery.makeWidth(context, 1.0))
              .topRounded(value: CustomMediaQuery.makeRadius(context, .5))
              .make();
        });
  }
}
