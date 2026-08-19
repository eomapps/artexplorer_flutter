import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/artwork_card.dart';
import 'package:artexplorer/widgets/auth_bottom_sheet.dart';
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
        if (artwork.styleTitles.isNotEmpty) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: buildStylePill(artwork.primaryStyleTitle),
          ),
          const SizedBox(height: 14),
        ],
        Text(
          artwork.title,
          style: AppTextStyles.screenTitle.copyWith(color: AppColors.ink),
        ),
        const SizedBox(height: 6),
        Text(
          artwork.artistDisplay,
          style: AppTextStyles.caption.copyWith(color: AppColors.inkMuted),
        ),
        const SizedBox(height: 20),
        Table(
          children: [
            buildMetadataLabelRow(AppStrings.date, AppStrings.origin),
            buildMetadataValueRow(artwork.dateDisplay, artwork.placeOfOrigin),
            buildMetadataLabelRow(AppStrings.movement, AppStrings.collection),
            buildMetadataValueRow(artwork.primaryStyleTitle, AppStrings.source),
          ],
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            if (context.read<AuthBloc>().state is AuthAuthenticated) {
              if (isSaved) {
                context.read<CollectionBloc>().add(
                  RemoveArtwork(id: artwork.id!),
                );
              } else {
                context.read<CollectionBloc>().add(
                  SaveArtwork(artwork: artwork),
                );
              }
            } else {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Wrap(children: [AuthBottomSheet(artwork: artwork)]);
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSaved ? AppColors.saveRemove : AppColors.accent,
            foregroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: AppTextStyles.buttonLabel,
          ),
          icon: Icon(
            isSaved ? Icons.favorite : Icons.favorite_border,
            size: 16,
          ),
          label: Text(
            (isSaved
                    ? AppStrings.removeFromCollection
                    : AppStrings.saveToCollection)
                .toUpperCase(),
          ),
        ),
      ],
    );
  }

  Widget buildStylePill(String style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        style.toUpperCase(),
        style: AppTextStyles.chipLabel.copyWith(color: AppColors.accent),
      ),
    );
  }

  TableRow buildMetadataLabelRow(String left, String right) {
    return TableRow(
      children: [left, right]
          .map(
            (label) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                label.toUpperCase(),
                style: AppTextStyles.chipLabel.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.5,
                  color: AppColors.inkFaint,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow buildMetadataValueRow(String left, String right) {
    return TableRow(
      children: [left, right]
          .map(
            (value) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                value,
                style: AppTextStyles.serifBody.copyWith(
                  fontSize: 14,
                  color: AppColors.ink,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
