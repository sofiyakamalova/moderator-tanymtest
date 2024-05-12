import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonCustomBtn extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color border_color;
  final Color background_color;
  final Color text_color;
  final double pad_size;
  final double? fntSize;
  final FontWeight? fntWeight;
  final double? vert;
  final double? hor;

  const CommonCustomBtn({
    super.key,
    required this.onTap,
    required this.text,
    this.border_color = AppColors.primary_color,
    this.background_color = AppColors.primary_color,
    this.text_color = AppColors.white_color,
    this.pad_size = 0,
    this.fntSize,
    this.fntWeight = FontWeight.bold,
    this.hor,
    this.vert,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: pad_size),
        padding: EdgeInsets.symmetric(vertical: vert!, horizontal: hor!),
        decoration: BoxDecoration(
          color: background_color,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: border_color,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fntSize,
              color: text_color,
              fontWeight: fntWeight,
            ),
          ),
        ),
      ),
    );
  }
}
