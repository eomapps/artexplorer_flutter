import 'package:artexplorer/models/artwork.dart';

sealed class CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionLoaded extends CollectionState {
  final List<Artwork> artworks;

  CollectionLoaded({required this.artworks});
}

final class CollectionError extends CollectionState {
  final String error;

  CollectionError({required this.error});
}
