import 'package:artexplorer/models/artwork.dart';

sealed class CollectionEvent {}

final class LoadCollection extends CollectionEvent {}

final class SaveArtwork extends CollectionEvent {
  final Artwork artwork;

  SaveArtwork({required this.artwork});
}

final class RemoveArtwork extends CollectionEvent {
  final int id;

  RemoveArtwork({required this.id});
}

final class ClearCollection extends CollectionEvent {}
