import 'package:dartz/dartz.dart';
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

      body = response.data;

      if (response.statusCode == created) {
        body = response.data;
      } else if (response.statusCode == forbidden) {
        throw ServerException('Invalid username or password');
      } else if (response.statusCode == internalServer) {
        throw ServerException('Server is down');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }

    return body;
  }
}
