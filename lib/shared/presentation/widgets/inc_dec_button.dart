import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({super.key, required this.onChange});
  final Function (int) onChange;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, () {
          if (quantity > 1) {
            quantity--;
          }
          widget.onChange(quantity);
          setState(() {});
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$quantity',
            style: TextTheme.of(
              context,
            ).titleLarge?.copyWith(color: AppColors.themeColor),
          ),
        ),
        _buildButton(Icons.add, () {
          quantity++;
          widget.onChange(quantity);
          setState(() {});
        }),
      ],
    );
  }
}

Widget _buildButton(IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    ),
  );
}
