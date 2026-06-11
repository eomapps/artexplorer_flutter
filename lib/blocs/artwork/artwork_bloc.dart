import 'package:artexplorer/blocs/artwork/artwork_event.dart';
import 'package:artexplorer/blocs/artwork/artwork_state.dart';
import 'package:artexplorer/repositories/art_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  final ArtRepository _repository;
  int _page = 1;

  ArtworkBloc(this._repository) : super(ArtworkLoading()) {
    on<FetchArtworks>((event, emit) async {
      _page = 1;
      emit(ArtworkLoading());
      try {
        final artworks = await _repository.fetchArtworksByPage(_page);
        emit(ArtworkLoaded(artworks: artworks, page: _page));
      } catch (e) {
        emit(ArtworkError(error: e.toString()));
      }
    });
    on<FilterByStyle>((event, emit) async {
      _page = 1;
      emit(ArtworkLoading());
      try {
        final artworks = await _repository.fetchArtworksByStyleTitle(
          event.styleTitle,
        );
        emit(ArtworkLoaded(artworks: artworks, page: _page));
      } catch (e) {
        emit(ArtworkError(error: e.toString()));
      }
    });
    on<SearchArtworks>((event, emit) async {
      _page = 1;
      emit(ArtworkLoading());
      try {
        final artworks = await _repository.fetchArtworksByQuery(event.query);
        emit(ArtworkLoaded(artworks: artworks, page: _page));
      } catch (e) {
        emit(ArtworkError(error: e.toString()));
      }
    });
    on<LoadNextPage>((event, emit) async {
      final current = state as ArtworkLoaded;
      emit(ArtworkLoading());
      try {
        final artworks = await _repository.fetchArtworksByPage(_page);
        final completeList = [...current.artworks, ...artworks];
        emit(ArtworkLoaded(artworks: completeList, page: _page));
        _page++;
      } catch (e) {
        emit(ArtworkError(error: e.toString()));
      }
    });
  }
}
