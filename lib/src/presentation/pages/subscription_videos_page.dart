import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/presentation/widgets/video_tile_widget.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';

class SubscriptionVideos extends StatefulWidget {
  const SubscriptionVideos({super.key});

  @override
  State<SubscriptionVideos> createState() => SubscriptionVideosState();
}

class SubscriptionVideosState extends State<SubscriptionVideos> {
  @override
  void initState() {
    super.initState();

    context.read<AllVideosCubit>().getSubscriptionVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllVideosCubit, AllVideosState>(
      bloc: context.read<AllVideosCubit>(),
      builder: (context, state) {
        if (state is AllVideosLoading) {
          return CircularProgressIndicator(
            strokeWidth: 3.4,
            color: red,
          ).centered();
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
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return VideoTileWidget(
                    uri: state.videos[index].thumbnailS3Uri,
                    isFirstTile: index == 0 ? true : false,
                    userId: state.videos[index].userId,
                    title: state.videos[index].videoName);
              });
        }

        return 'Oops 🙀'.text.color(white).headline6(context).makeCentered();
      },
    );
  }
}
