part of 'all_videos_cubit.dart';

abstract class AllVideosState extends Equatable {
  const AllVideosState();

  @override
  List<Object> get props => [];
}

class AllVideosLoading extends AllVideosState {}

class AllVideosLoaded extends AllVideosState {
  final List<Video> videos;

  const AllVideosLoaded({
    required this.videos,
  });

  @override
  List<Object> get props => [videos];
}

class AllVideosError extends AllVideosState {
  final ServerException serverException;

  const AllVideosError({
    required this.serverException,
  });

  @override
  List<Object> get props => [serverException];
}
