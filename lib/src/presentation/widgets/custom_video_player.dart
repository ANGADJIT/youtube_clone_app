import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone_app/src/data/providers/videos_api.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.videoUri});
  final String videoUri;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  final VideosApi _videosApi = VideosApi();

  ChewieController? _chewieController;

  Future<void> _loadVideo() async {
    final String videoUrl = await _videosApi.getVideo(widget.videoUri);
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
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _loadVideo(),
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
                  onPressed: (){},
                ).p2(),
              )
            ],
          );
        });
  }

  Widget _resolutionButton(String resolution) {
    return resolution.text.color(white).light.makeCentered().onTap(() {});
  }

  
}
