import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/logic/auth_cubit/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/presentation/widgets/video_tile_widget.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final AllVideosCubit _allVideosCubit = AllVideosCubit();

  @override
  void initState() {
    super.initState();

    _allVideosCubit.getAllVideo();
  }

  @override
  void dispose() {
    _allVideosCubit.close();

    super.dispose();
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
          ).centered();
        }

        if (state is AllVideosLoaded) {
          return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return VideoTileWidget(
                    uri: state.videos[index].thumbnailS3Uri,
                    isFirstTile: index == 0 ? true : false,
                    userId: state.videos[index].userId,
                    title: state.videos[index].videoName,
                    channelName: 'New Channel');
              });
        }

        return 'Opps 🙀'.text.color(white).headline6(context).makeCentered();
      },
    );
  }
}
