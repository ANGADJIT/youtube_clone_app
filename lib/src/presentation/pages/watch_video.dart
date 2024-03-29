import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/presentation/pages/recommendations_videos_page.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_video_player.dart';
import 'package:youtube_clone_app/src/presentation/widgets/video_details.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';

class WatchVideo extends StatefulWidget {
  const WatchVideo({super.key, required this.video});
  final Video video;

  @override
  State<WatchVideo> createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar()
          .call(context, title: widget.video.videoName, isHome: false),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: VStack([
          // playable video
          CustomVideoPlayer(video: widget.video),

          // details
          VideoDetails(video: widget.video),

          RecommendationsVideosPage(videoType: widget.video.videoType)
        ]),
      ),
    );
  }
}
