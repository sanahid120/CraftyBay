import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });
  final List<String> colors;
  final Function(String) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String? _selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Select Colour",
          style: TextTheme.of(
            context,
          ).titleMedium?.copyWith(color: AppColors.themeColor),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: widget.colors.isEmpty ? Text("No Color available for this Product!") : ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onColorSelected(widget.colors[index]);
                  setState(() {});
                  _selectedColor = widget.colors[index];
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedColor == widget.colors[index]
                        ? AppColors.themeColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedColor == widget.colors[index]
                          ? Colors.transparent
                          : AppColors.themeColor,
                      width: 1.5,
                    ),
                  ),
                  child: Text(widget.colors[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: widget.colors.length,
          ),
        ),
      ],
    );
  }
}
