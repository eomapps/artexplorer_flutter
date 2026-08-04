import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/artwork_card.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final Artwork artwork;

  const DetailScreen({super.key, required this.artwork});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        switch (state) {
          case CollectionError():
            debugPrint(state.error);
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.saveRemove,
                        size: 40,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.errorMessage,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.serifBody.copyWith(
                          color: AppColors.inkMuted,
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          context.read<CollectionBloc>().add(LoadCollection());
                        },
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            AppTextStyles.buttonLabel.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          foregroundColor: const WidgetStatePropertyAll(
                            AppColors.inkMuted,
                          ),
                          side: WidgetStatePropertyAll(
                            BorderSide(color: AppColors.divider),
                          ),
                        ),
                        child: Text(AppStrings.buttonRetry.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case CollectionLoading():
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  strokeWidth: 8.0,
                ),
              ),
            );
          case CollectionLoaded():
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ArtworkCard(imageUrl: widget.artwork.imageUrl!),
                  ),
                  LinenPanel(
                    child: buildDetailWidget(
                      context,
                      state.isArtworkSaved(widget.artwork.id!),
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget buildDetailWidget(BuildContext context, bool isSaved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [Text(widget.artwork.primaryStyleTitle)]),
        Text(widget.artwork.title),
        Text(widget.artwork.artistDisplay),
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
                Text(widget.artwork.dateDisplay),
                Text(widget.artwork.placeOfOrigin),
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
                Text(widget.artwork.primaryStyleTitle),
                Text(AppStrings.source),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            if (isSaved) {
              context.read<CollectionBloc>().add(
                RemoveArtwork(id: widget.artwork.id!),
              );
            } else {
              context.read<CollectionBloc>().add(
                SaveArtwork(artwork: widget.artwork),
              );
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
