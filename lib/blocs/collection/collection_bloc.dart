import 'dart:async';

import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/repositories/collection_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final AuthBloc _authBloc;
  final CollectionRepository _repository;
  late final StreamSubscription _streamSubscription;

  CollectionBloc(this._authBloc, this._repository)
    : super(CollectionLoaded(artworks: [])) {
    _streamSubscription = _authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(LoadCollection());
      } else if (authState is AuthUnauthenticated || authState is AuthError) {
        add(ClearCollection());
      }
    });
    on<LoadCollection>((event, emit) async {
      emit(CollectionLoading());
      try {
        final uid = (_authBloc.state as AuthAuthenticated).user.uid;
        final artworks = await _repository.loadCollection(uid);
        emit(CollectionLoaded(artworks: artworks));
      } catch (e) {
        emit(CollectionError(error: e.toString()));
      }
    });
    on<SaveArtwork>((event, emit) async {
      final uid = (_authBloc.state as AuthAuthenticated).user.uid;
      try {
        if (state is! CollectionLoaded) return;
        final current = state as CollectionLoaded;
        await _repository.saveArtwork(uid, event.artwork);
        final completeList = [...current.artworks];
        completeList.add(event.artwork);
        emit(CollectionLoaded(artworks: completeList));
      } catch (e) {
        emit(CollectionError(error: e.toString()));
      }
    });
    on<RemoveArtwork>((event, emit) async {
      final uid = (_authBloc.state as AuthAuthenticated).user.uid;
      try {
        if (state is! CollectionLoaded) return;
        final current = state as CollectionLoaded;
        await _repository.removeArtwork(uid, event.id);
        final completeList = [...current.artworks];
        completeList.removeWhere((artwork) => artwork.id == event.id);
        emit(CollectionLoaded(artworks: completeList));
      } catch (e) {
        emit(CollectionError(error: e.toString()));
      }
    });
    on<ClearCollection>((event, emit) async {
      emit(CollectionLoaded(artworks: []));
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    await super.close();
  }
}
