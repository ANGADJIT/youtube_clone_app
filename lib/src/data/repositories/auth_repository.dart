import 'package:dartz/dartz.dart';
import 'package:youtube_clone_app/src/data/models/auth_login_session.dart';
import 'package:youtube_clone_app/src/data/providers/auth_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();

  Future<Either<ServerException, AuthLoginSession>> login(
      {required String email, required String password}) async {
    AuthLoginSession authCreateSession;

    try {
      final String body =
          await _authApi.login(email: email, password: password);
      authCreateSession = AuthLoginSession.fromJson(body);
    } catch (e) {
      return left(ServerException(e.toString()));
    }

    return right(authCreateSession);
  }
}
