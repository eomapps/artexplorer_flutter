import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthState {}

final class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({required this.user});
}

final class AuthLoading extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}
