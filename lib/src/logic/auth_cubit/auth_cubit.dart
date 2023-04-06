import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_clone_app/src/data/models/auth_create_session.dart';
import 'package:youtube_clone_app/src/data/models/auth_login_session.dart';
import 'package:youtube_clone_app/src/data/repositories/auth_repository.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // auth repo
  final AuthRepository _authRepository = AuthRepository();

  Future<void> login({required String email, required String password}) async {
    final result =
        await _authRepository.login(email: email, password: password);

    result.fold((e) => emit(AuthError(serverException: e)),
        (r) => emit(LoggedIn(authLoginSession: r)));
  }

  Future<void> register(
      {required String email,
      required String password,
      required String channelName,
      required String channelPhotoPath}) async {
    final result = await _authRepository.register(
        email: email,
        password: password,
        channelName: channelName,
        channelPhotoPath: channelPhotoPath);

    result.fold((e) => AuthError(serverException: e),
        (r) => AuthRegistered(authCreateSession: r));
  }
}
