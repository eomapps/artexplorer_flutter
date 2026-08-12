import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtworkCard extends StatelessWidget {
  final String imageUrl;

  const ArtworkCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
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
              fit: BoxFit.contain,
              imageUrl: imageUrl,
              httpHeaders: AppStrings.aicHeaders,
              placeholder: (context, url) => Container(
                color: AppColors.background,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                    strokeWidth: 8.0,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.background,
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
    );
  }
}
