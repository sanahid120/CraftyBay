import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/localization_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.name,
    required this.onTapSeeAll,
  });
  final String name;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          name,
          style: TextTheme.of(
            context,
          ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: Text(
            context.localization.seeAll,
            style: TextTheme.of(context).bodyMedium?.copyWith(
              decoration: .underline,
              color: AppColors.themeColor,
            ),
          ),
        ),
      ],
    );
  }
}
