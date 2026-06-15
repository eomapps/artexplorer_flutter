import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthUnauthenticated()) {
    on<SignInWithGoogle>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.signInWithGoogle();
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        emit(AuthError(error: e.toString()));
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
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
    on<CheckAuth>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.checkAuth();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        await _repository.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
