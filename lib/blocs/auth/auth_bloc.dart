import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthUnauthenticated()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.signInWithGoogle();
        emit(AuthAuthenticated(user: user));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      } on GoogleSignInException catch (e) {
        if (e.code == GoogleSignInExceptionCode.canceled) {
          emit(AuthUnauthenticated());
        } else {
          emit(
            AuthError(
              error: FirebaseAuthException(
                code: 'google-sign-in-failed',
                message: e.description,
              ),
            ),
          );
        }
      }
    });
    on<SignInWithEmail>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.signInWithEmail(
          event.email,
          event.password,
        );
        emit(AuthAuthenticated(user: user));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      }
    });
    on<CreateLoginWithEmail>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.createLoginWithEmail(
          event.email,
          event.password,
        );
        emit(AuthAuthenticated(user: user));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      }
    });
    on<CheckAuth>((event, emit) async {
      emit(AuthSessionChecking());
      try {
        final user = await _repository.checkAuth();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnauthenticated());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      }
    });
    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        await _repository.signOut();
        emit(AuthUnauthenticated());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      }
    });
    on<ResetPassword>((event, emit) async {
      emit(AuthLoading());
      try {
        await _repository.requestPasswordResetEmail(event.email);
        emit(AuthPasswordReset());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(error: e));
      }
    });
  }
}
