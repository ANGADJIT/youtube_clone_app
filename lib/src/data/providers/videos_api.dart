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

  Future<String> getVideo(String uri) async {
    String url = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    final Map<String, dynamic> data = {'object_uri': uri, 'for_video': true};

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

  Future<String> getChannelName(String userId) async {
    String channelName = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
        route: '$majorRoute/channel_name/$userId',
        headers: headers,
        isDepended: true,
      );

      if (response.statusCode == 200) {
        channelName = response.data['channel_name'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return channelName;
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

  Future<String> getSubscriptionVideos() async {
    String body = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
          route: '$majorRoute/subscription_videos',
          headers: headers,
          isDepended: true);

      if (response.statusCode == 200) {
        body = jsonEncode(response.data);
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return body;
  }

  Future<String> searchVideos(String searchPattern) async {
    String body = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      if (searchPattern.isNotEmpty) {
        final Response response = await get(
            route: '$majorRoute/search',
            headers: headers,
            isDepended: true,
            queryParameters: {'search_pattern': searchPattern});

        if (response.statusCode == 200) {
          body = jsonEncode(response.data);
        }
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return body;
  }

  Future<void> subscribe(String userId) async {
    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      await post(
          route: '$majorRoute/subscribe/$userId',
          headers: headers,
          data: {},
          isDepended: true);
    } on DioError catch (e) {
      if (e.response!.statusCode == conflict) {
        throw ServerException('Already subscribed');
      }
    }
  }

  Future<bool> checkSubscribtion(String userId) async {
    final Map<String, dynamic> headers = {'accept': 'application/json'};

    bool isSubscribed = false;

    try {
      final Response response = await get(
          route: '$majorRoute/check_subscription/$userId', headers: headers);

      if (response.statusCode == 200) {
        isSubscribed = response.data['is_subscribed'];
      }
    } on DioError catch (e) {
      throw ServerException(e.toString());
    }

    return isSubscribed;
  }

  Future<int> getSubscribtionCount(String userId) async {
    final Map<String, dynamic> headers = {'accept': 'application/json'};

    int count = 0;

    try {
      final Response response = await get(
          route: '$majorRoute/get_subscription_count/$userId',
          headers: headers);

      if (response.statusCode == 200) {
        count = response.data['count'];
      }
    } on DioError catch (e) {
      throw ServerException(e.toString());
    }

    return count;
  }

  Future<void> like(String videoId) async {
    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      await post(
          route: '$majorRoute/like/$videoId',
          headers: headers,
          data: {},
          isDepended: true);
    } on DioError catch (e) {
      if (e.response!.statusCode == conflict) {
        throw ServerException('Already liked the video');
      }
    }
  }

  Future<int> getLikesCount(String videoId) async {
    final Map<String, dynamic> headers = {'accept': 'application/json'};

    int count = 0;

    try {
      final Response response =
          await get(route: '$majorRoute/likes/$videoId', headers: headers);

      if (response.statusCode == 200) {
        count = response.data['likes'];
      }
    } on DioError catch (e) {
      throw ServerException(e.toString());
    }

    return count;
  }

  Future<String> recommendations(String videoType) async {
    String body = '';

    final Map<String, dynamic> headers = {'accept': 'application/json'};

    try {
      final Response response = await get(
        route: '$majorRoute/recommendations/$videoType',
        headers: headers,
        isDepended: true,
      );

      if (response.statusCode == 200) {
        body = jsonEncode(response.data);
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return body;
  }
}
