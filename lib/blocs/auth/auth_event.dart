sealed class AuthEvent {}

final class SignInWithGoogle extends AuthEvent {}

final class SignInWithEmail extends AuthEvent {
  final String email;
  final String password;
  SignInWithEmail({required this.email, required this.password});
}

final class CheckAuth extends AuthEvent {}

final class SignOut extends AuthEvent {}
