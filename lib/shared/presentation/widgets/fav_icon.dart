import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class FavIcon extends StatelessWidget {
  const FavIcon({
    super.key, required this.onTap
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: .all(2),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: .circular(4),
        ),
        child: Icon(Icons.favorite, color: Colors.white, size: 16),
      ),
    );
  }
}
