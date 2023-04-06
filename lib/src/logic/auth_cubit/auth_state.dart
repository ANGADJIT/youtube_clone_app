part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoggedIn extends AuthState {
  final AuthLoginSession authLoginSession;

  const LoggedIn({
    required this.authLoginSession,
  });

  @override
  List<Object> get props => [authLoginSession];
}

class AuthRegistered extends AuthState {
  final AuthCreateSession authCreateSession;

  const AuthRegistered({
    required this.authCreateSession,
  });

  @override
  List<Object> get props => [authCreateSession];
}

class AuthError extends AuthState {
  final ServerException serverException;

  const AuthError({
    required this.serverException,
  });
}
