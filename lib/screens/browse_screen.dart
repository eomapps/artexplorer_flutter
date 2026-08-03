import 'package:artexplorer/blocs/artwork/artwork_bloc.dart';
import 'package:artexplorer/blocs/artwork/artwork_event.dart';
import 'package:artexplorer/blocs/artwork/artwork_state.dart';
import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/screens/collection_screen.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/artwork_card.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int index = 0;
  @override
  void initState() {
    context.read<ArtworkBloc>().add(FetchArtworks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtworkBloc, ArtworkState>(
      builder: (context, state) {
        switch (state) {
          case ArtworkError():
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
                          context.read<ArtworkBloc>().add(FetchArtworks());
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
          case ArtworkLoading():
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  strokeWidth: 8.0,
                ),
              ),
            );
          case ArtworkLoaded():
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CollectionScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.list),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOut());
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
                title: Text(state.artworks[index].placeOfOrigin),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ArtworkCard(
                      imageUrl: state.artworks[index].imageUrl!,
                    ),
                  ),
                  LinenPanel(
                    child: buildInformationWidget(
                      state.artworks[index],
                      state.artworks.length,
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget buildInformationWidget(Artwork artwork, int length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(artwork.primaryStyleTitle),
        Text(artwork.title),
        Text(artwork.artistDisplay),
        Table(
          children: [
            TableRow(
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (index > 0) {
                      setState(() {
                        index--;
                      });
                    }
                  },
                  child: Text(AppStrings.buttonPrevious),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (index < length - 1) {
                      setState(() {
                        index++;
                      });
                    }
                  },
                  child: Text(AppStrings.buttonNext),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
