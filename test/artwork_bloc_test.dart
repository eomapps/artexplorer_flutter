import 'package:artexplorer/blocs/artwork/artwork_bloc.dart';
import 'package:artexplorer/blocs/artwork/artwork_event.dart';
import 'package:artexplorer/blocs/artwork/artwork_state.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/repositories/art_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArtRepository extends Mock implements ArtRepository {}

void main() {
  late MockArtRepository artRepository;

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

  final pageOne = [
    Artwork(
      id: 1,
      title: 'A',
      artistDisplay: 'Test Artist',
      dateDisplay: '2020',
      imageId: 'abc-123',
      styleTitles: const [],
      placeOfOrigin: '',
    ),
  ];

  final pageTwo = [
    Artwork(
      id: 2,
      title: 'B',
      artistDisplay: 'Another Artist',
      dateDisplay: '2021',
      imageId: 'def-456',
      styleTitles: const [],
      placeOfOrigin: '',
    ),
  ];

  setUp(() {
    artRepository = MockArtRepository();
  });

  group('ArtworkBloc', () {
    blocTest<ArtworkBloc, ArtworkState>(
      'loads artworks when FetchArtworks is added',
      build: () {
        when(
          () => artRepository.fetchArtworksByPage(1),
        ).thenAnswer((_) async => testArtworks);
        return ArtworkBloc(artRepository);
      },
      act: (bloc) => bloc.add(FetchArtworks()),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        isA<ArtworkLoading>(),
        isA<ArtworkLoaded>().having(
          (state) => state.artworks.length,
          'number of artworks',
          1,
        ),
      ],
      verify: (_) {
        verify(() => artRepository.fetchArtworksByPage(1)).called(1);
      },
    );

    blocTest<ArtworkBloc, ArtworkState>(
      'appends the next page to the existing artworks',
      build: () {
        when(
          () => artRepository.fetchArtworksByPage(2),
        ).thenAnswer((_) async => pageTwo);
        return ArtworkBloc(artRepository);
      },
      seed: () {
        return ArtworkLoaded(artworks: pageOne, page: 1);
      },
      act: (bloc) => bloc.add(LoadNextPage()),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        isA<ArtworkLoaded>()
            .having((state) => state.artworks.length, 'number of artworks', 2)
            .having((state) => state.page, 'current page', 2),
      ],
      verify: (_) {
        verify(() => artRepository.fetchArtworksByPage(2)).called(1);
      },
    );
  });
}
