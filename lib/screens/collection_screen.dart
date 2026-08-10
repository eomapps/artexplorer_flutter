import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/artwork_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/collection/collection_bloc.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        switch (state) {
          case CollectionError():
            debugPrint(state.error);
            return Scaffold(
              appBar: AppBar(title: Text(AppStrings.myCollection)),
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
            if (state.artworks.isEmpty) {
              return Scaffold(
                appBar: AppBar(title: Text(AppStrings.myCollection)),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.divider,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            color: AppColors.inkFaint,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.noSavedWorks,
                          style: AppTextStyles.serifItalicMuted,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppStrings.emptyCollectionPrompt,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.inkFaint,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(title: Text(AppStrings.myCollection)),
                body: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio:
                        0.8, // tune to taste once you see it render
                  ),
                  itemCount: state.artworks.length,
                  itemBuilder: (context, i) {
                    final artwork = state.artworks[i];
                    return ArtworkThumbnail(artwork: artwork);
                  },
                ),
              );
            }
        }
      },
    );
  }
}
