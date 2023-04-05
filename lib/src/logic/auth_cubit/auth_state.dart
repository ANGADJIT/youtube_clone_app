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

class AuthError extends AuthState {
  final ServerException serverException;

  const AuthError({
    required this.serverException,
  });
}
