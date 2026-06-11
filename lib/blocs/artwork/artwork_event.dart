sealed class ArtworkEvent {}

final class FetchArtworks extends ArtworkEvent {}

final class FilterByStyle extends ArtworkEvent {
  final String styleTitle;

  FilterByStyle({required this.styleTitle});
}

final class SearchArtworks extends ArtworkEvent {
  final String query;

  SearchArtworks({required this.query});
}

final class LoadNextPage extends ArtworkEvent {}
