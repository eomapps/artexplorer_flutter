import 'package:artexplorer/models/artwork.dart';

sealed class ArtworkState {}

final class ArtworkLoading extends ArtworkState {}

final class ArtworkLoaded extends ArtworkState {
  final List<Artwork> artworks;
  final int page;

  ArtworkLoaded({required this.artworks, required this.page});
}

final class ArtworkError extends ArtworkState {
  final String error;

  ArtworkError({required this.error});
}
