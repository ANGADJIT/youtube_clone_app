import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/presentation/pages/watch_video.dart';
import 'package:youtube_clone_app/src/presentation/widgets/video_tile_widget.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class RecommendationsVideosPage extends StatefulWidget {
  const RecommendationsVideosPage({super.key, required this.videoType});
  final String videoType;

  @override
  State<RecommendationsVideosPage> createState() =>
      _RecommendationsVideosPageState();
}

class _RecommendationsVideosPageState extends State<RecommendationsVideosPage> {
  final AllVideosCubit _allVideosCubit = AllVideosCubit();

  @override
  void initState() {
    super.initState();

    _allVideosCubit.getRecommendations(widget.videoType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllVideosCubit, AllVideosState>(
      bloc: _allVideosCubit,
      builder: (context, state) {
        if (state is AllVideosLoading) {
          return CircularProgressIndicator(
            strokeWidth: 3.4,
            color: red,
          ).centered().py(CustomMediaQuery.makeHeight(context, .02));
        }

        if (state is AllVideosLoaded) {
          if (state.videos.isEmpty) {
            return 'Not Found 🔍'
                .text
                .color(white)
                .headline6(context)
                .makeCentered();
          }

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return VideoTileWidget(
                        uri: state.videos[index].thumbnailS3Uri,
                        isFirstTile: index == 0 ? true : false,
                        userId: state.videos[index].userId,
                        title: state.videos[index].videoName)
                    .onTap(() {
                  context.nextPage(WatchVideo(video: state.videos[index]));
                });
              });
        }

        return 'Oops 🙀'.text.color(white).headline6(context).makeCentered();
      },
    );
  }
}
