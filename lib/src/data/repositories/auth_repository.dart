import 'package:dartz/dartz.dart';
import 'package:youtube_clone_app/src/data/models/auth_create_session.dart';
import 'package:youtube_clone_app/src/data/models/auth_login_session.dart';
import 'package:youtube_clone_app/src/data/providers/auth_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();

  Future<Either<ServerException, AuthLoginSession>> login(
      {required String email, required String password}) async {
    AuthLoginSession authLoginSession;

    try {
      final String body =
          await _authApi.login(email: email, password: password);
      authLoginSession = AuthLoginSession.fromJson(body);
    } catch (e) {
      return left(ServerException(e.toString()));
    }

    return right(authLoginSession);
  }

  Future<Either<ServerException, AuthCreateSession>> register(
      {required String email,
      required String password,
      required String channelName,
      required String channelPhotoPath}) async {
    AuthCreateSession authCreateSession;

    try {
      final String body = await _authApi.register(
          email: email,
          password: password,
          channelName: channelName,
          channelPhotoPath: channelPhotoPath);

      authCreateSession = AuthCreateSession.fromJson(body);
    } catch (e) {
      return left(ServerException(e.toString()));
    }

    return right(authCreateSession);
  }
}
