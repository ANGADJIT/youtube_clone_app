import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:youtube_clone_app/src/utils/base_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class AuthApi extends BaseApi {
  final String baseRoute = 'auth';

  Future<String> login(
      {required String email, required String password}) async {
    String body = '';

    // make data and headers
    final Map<String, dynamic> data = {
      'grant_type': '',
      'username': email,
      'password': password,
      'scope': '',
      'client_id': '',
      'client_secret': '',
    };

    final Map<String, dynamic> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    // now post this data to route
    try {
      final response = await post(
          route: '$baseRoute/login',
          headers: headers,
          data: data,
          isDepended: false);

      if (response.statusCode == created) {
        body = jsonEncode(response.data);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == forbidden) {
        throw ServerException('Invalid username or password');
      } else if (e.response?.statusCode == internalServer) {
        throw ServerException('Server is down');
      } else {
        throw ServerException(e.toString());
      }
    }

    return body;
  }

  Future<String> register(
      {required String email,
      required String password,
      required String channelName,
      required String channelPhotoPath}) async {
    String body = '';

    try {
      final Map<String, dynamic> params = {
        'email': email,
        'password': password,
        'channel_name': channelName
      };

      final Map<String, dynamic> headers = {
        'accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };

      final response = await post(
          route: '$baseRoute/register',
          headers: headers,
          data: {},
          params: params,
          isForm: true,
          isDepended: false,
          file: File(channelPhotoPath));

      if (response.statusCode == 200) {
        body = jsonEncode(response.data);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == conflict) {
        throw ServerException('User already exists with this email');
      } else if (e.response?.statusCode == internalServer) {
        throw ServerException('Server is down');
      }
    }

    return body;
  }
}
