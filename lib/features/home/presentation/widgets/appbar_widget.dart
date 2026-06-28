import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/app_paths.dart';

class AppbarIconButton extends StatelessWidget implements PreferredSizeWidget {
  const AppbarIconButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.withAlpha(50),
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
