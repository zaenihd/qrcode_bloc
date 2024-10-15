part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
final  String error;

  AuthStateError(this.error);
}
