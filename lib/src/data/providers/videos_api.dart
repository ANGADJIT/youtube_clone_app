import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:youtube_clone_app/src/utils/base_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class VideosApi extends BaseApi {
  final String majorRoute = 'videos';

  Future<String> getProfileUrl() async {
    String url = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
          route: '$majorRoute/user_profile_photo',
          headers: headers,
          isDepended: true);

      if (response.statusCode == 200) {
        url = response.data['profile_url'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return url;
  }

  Future<String> getThumbnail(String uri) async {
    String url = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    final Map<String, dynamic> data = {'object_uri': uri, 'for_video': false};

    try {
      final Response response = await post(
          route: '/link', headers: headers, isDepended: true, data: data);

      if (response.statusCode == 200) {
        url = response.data['url'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return url;
  }

  Future<String> getChannelProfile(String userId) async {
    String url = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
        route: '$majorRoute/channel_profile/$userId',
        headers: headers,
        isDepended: true,
      );

      if (response.statusCode == 200) {
        url = response.data['profile_url'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return url;
  }

  Future<String> getAllVideos() async {
    String body = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
          route: '$majorRoute/all', headers: headers, isDepended: true);

      if (response.statusCode == 200) {
        body = jsonEncode(response.data);
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return body;
  }
}
