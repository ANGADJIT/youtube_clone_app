import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/data/providers/videos_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class VideosRepository {
  final VideosApi _videosApi = VideosApi();

  Future<Either<ServerException, List<Video>>> getAllVideos() async {
    List<Video> videos = [];

    try {
      final String body = await _videosApi.getAllVideos();
      final rawVideos = jsonDecode(body);

      for (var video in rawVideos) {
        videos.add(Video.fromMap(video));
      }
    } catch (e) {
      return left(ServerException(e.toString()));
    }

    return right(videos);
  }
}
