import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class SheetButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const SheetButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,
        width: double.maxFinite,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.light_grey_color),
          color: AppColors.white_color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              color: AppColors.low_primary_color,
              fontWeight: FontWeight.w400,
              size: 15,
              text: text,
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.dark_grey_color,
            )
          ],
        ),
      ),
    );
  }
}
