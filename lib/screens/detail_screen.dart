import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/artwork_card.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  final Artwork artwork;

  const DetailScreen({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionBloc, CollectionState>(
      listener: (context, state) {
        if (state is CollectionError) {
          debugPrint(state.error);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(AppStrings.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ArtworkCard(imageUrl: artwork.imageUrl!)),
              LinenPanel(
                child: buildDetailWidget(
                  context,
                  state.isArtworkSaved(artwork.id!),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDetailWidget(BuildContext context, bool isSaved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [Text(artwork.primaryStyleTitle)]),
        Text(artwork.title),
        Text(artwork.artistDisplay),
        Table(
          children: [
            TableRow(
              children: [
                Text(AppStrings.date.toUpperCase()),
                Text(AppStrings.origin.toUpperCase()),
              ],
            ),
            TableRow(
              children: [
                Text(artwork.dateDisplay),
                Text(artwork.placeOfOrigin),
              ],
            ),
            TableRow(
              children: [
                Text(AppStrings.movement.toUpperCase()),
                Text(AppStrings.collection.toUpperCase()),
              ],
            ),
            TableRow(
              children: [
                Text(artwork.primaryStyleTitle),
                Text(AppStrings.source),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            if (isSaved) {
              context.read<CollectionBloc>().add(
                RemoveArtwork(id: artwork.id!),
              );
            } else {
              context.read<CollectionBloc>().add(SaveArtwork(artwork: artwork));
            }
          },
          child: Text(
            isSaved
                ? AppStrings.removeFromCollection
                : AppStrings.saveToCollection,
          ),
        ),
      ],
    );
  }
}
