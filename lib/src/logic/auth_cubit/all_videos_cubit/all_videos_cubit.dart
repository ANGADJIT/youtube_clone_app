import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/data/repositories/videos_repository.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

part 'all_videos_state.dart';

class AllVideosCubit extends Cubit<AllVideosState> {
  AllVideosCubit() : super(AllVideosLoading());

  final VideosRepository _videosRepository = VideosRepository();

  void getAllVideo() async {
    final result = await _videosRepository.getAllVideos();

    result.fold((e) => emit(AllVideosError(serverException: e)),
        (videos) => emit(AllVideosLoaded(videos: videos)));
  }
}
