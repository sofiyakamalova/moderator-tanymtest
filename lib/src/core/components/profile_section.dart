import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class ProfileSection extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onTap;
  const ProfileSection(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.white_color,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 65,
        child: ListTile(
          leading: icon,
          title: CommonText(
            text: text,
            text_align: TextAlign.start,
            size: 18,
          ),
        ),
      ),
    );
  }
}
