import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });
  final List<String> sizes;
  final Function(String) onSizeSelected;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Select Size",
          style: TextTheme.of(
            context,
          ).titleMedium?.copyWith(color: AppColors.themeColor),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 35,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onSizeSelected(widget.sizes[index]);
                  setState(() {});
                  _selectedSize = widget.sizes[index];
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  height: 30,

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedSize == widget.sizes[index]
                        ? AppColors.themeColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedSize == widget.sizes[index]
                          ? Colors.transparent
                          : AppColors.themeColor,
                      width: 1.5,
                    ),
                  ),
                  child: Text(widget.sizes[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: widget.sizes.length,
          ),
        ),
      ],
    );
  }
}
