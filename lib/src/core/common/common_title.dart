import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final TextAlign? text_align;
  final double? size;
  final int? maxLines;

  const CommonTitle({
    super.key,
    required this.text,
    this.color = AppColors.primary_color,
    this.fontWeight = FontWeight.bold,
    this.textStyle,
    this.text_align = TextAlign.center,
    this.size = 22.0,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: text_align,
      softWrap: true,
    );
  }
}
