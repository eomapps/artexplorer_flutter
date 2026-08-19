import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/screens/detail_screen.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtworkThumbnail extends StatelessWidget {
  final Artwork artwork;
  const ArtworkThumbnail({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => DetailScreen(artwork: artwork),
                ),
              );
            },
            child: Container(
              color: AppColors.surface,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.04,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/textures/noise.png'),
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CachedNetworkImage(
                      httpHeaders: AppStrings.aicHeaders,
                      fit: BoxFit.contain,
                      imageUrl: artwork.imageUrl!,
                      placeholder: (context, url) => Container(
                        color: AppColors.surface,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.divider,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.accent,
                            ),
                            strokeWidth: 8.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surface,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.saveRemove,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(artwork.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        Text(
          artwork.artistDisplay,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
