import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/repositories/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRepository authRepository;
  late AuthBloc authBloc;
  late MockUser user;

  setUp(() {
    authRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository);
    user = MockUser();
    when(() => user.uid).thenReturn('test-uid');
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'loads User when AuthBloc emits AuthAuthenticated',
      build: () {
        when(
          () => authRepository.signInWithEmail('a@b.com', 'pw'),
        ).thenAnswer((_) async => user);
        return AuthBloc(authRepository);
      },
      act: (bloc) =>
          bloc.add(SignInWithEmail(email: 'a@b.com', password: 'pw')),
      wait: const Duration(milliseconds: 50),
      expect: () => [isA<AuthLoading>(), isA<AuthAuthenticated>()],
    );

    blocTest<AuthBloc, AuthState>(
      'loads error when AuthBloc emits AuthError',
      build: () {
        when(
          () => authRepository.signInWithEmail('a@b.com', 'wrong-pw'),
        ).thenThrow(
          FirebaseAuthException(
            code: 'wrong-password',
            message: 'Wrong password',
          ),
        );
        return AuthBloc(authRepository);
      },
      act: (bloc) =>
          bloc.add(SignInWithEmail(email: 'a@b.com', password: 'wrong-pw')),
      wait: const Duration(milliseconds: 50),
      expect: () => [isA<AuthLoading>(), isA<AuthError>()],
    );
  });
}
