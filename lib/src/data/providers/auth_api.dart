import 'dart:convert';
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
      }
    }

    return body;
  }
}
