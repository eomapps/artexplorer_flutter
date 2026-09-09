import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/repositories/collection_repository.dart';
import 'package:artexplorer/repositories/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCollectionRepository extends Mock implements CollectionRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRepository authRepository;
  late MockCollectionRepository collectionRepository;
  late AuthBloc authBloc;
  late MockUser user;

  final testArtworks = [
    Artwork(
      id: 1,
      title: 'Test Artwork',
      artistDisplay: 'Test Artist',
      dateDisplay: '2020',
      imageId: 'abc-123',
      styleTitles: const [],
      placeOfOrigin: '',
    ),
  ];

  setUp(() {
    authRepository = MockAuthRepository();
    collectionRepository = MockCollectionRepository();
    authBloc = AuthBloc(authRepository);
    user = MockUser();
    when(() => user.uid).thenReturn('test-uid');
  });

  tearDown(() {
    authBloc.close();
  });

  group('CollectionBloc', () {
    blocTest<CollectionBloc, CollectionState>(
      'loads the collection when AuthBloc emits AuthAuthenticated',
      build: () {
        when(
          () => collectionRepository.loadCollection('test-uid'),
        ).thenAnswer((_) async => testArtworks);
        when(
          () => authRepository.signInWithEmail('a@b.com', 'pw'),
        ).thenAnswer((_) async => user);
        return CollectionBloc(authBloc, collectionRepository);
      },
      act: (bloc) =>
          authBloc.add(SignInWithEmail(email: 'a@b.com', password: 'pw')),
      wait: const Duration(milliseconds: 50),
      expect: () => [isA<CollectionLoading>(), isA<CollectionLoaded>()],
    );
  });
}
