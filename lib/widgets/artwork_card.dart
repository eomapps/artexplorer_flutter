import 'package:artexplorer/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtworkCard extends StatelessWidget {
  final String imageUrl;

  const ArtworkCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          color: AppColors.surface,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
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
    );
  }
}
