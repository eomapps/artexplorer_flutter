import 'package:artexplorer/models/artwork.dart';

sealed class CollectionState {
  final List<Artwork> artworks;

  CollectionState({required this.artworks});

  bool isArtworkSaved(int id) => artworks.any((a) => a.id == id);
}

final class CollectionLoading extends CollectionState {
  CollectionLoading({required super.artworks});
}

final class CollectionLoaded extends CollectionState {
  CollectionLoaded({required super.artworks});
}

final class CollectionError extends CollectionState {
  final String error;

  CollectionError({required this.error, required super.artworks});
}
