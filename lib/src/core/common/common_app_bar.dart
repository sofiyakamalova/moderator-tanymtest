import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Color background_color;
  final Color text_color;
  final void Function()? onTap;
  final Icon? icon;
  const CommonAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.height = 90,
    this.text_color = AppColors.white_color,
    this.background_color = AppColors.primary_color,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (icon != null) {
      // Если boolean равен false, добавляем иконку слева

      children.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
          ),
          child: IconButton(
            onPressed: onTap,
            icon: icon!,
            iconSize: 32,
          ),
        ),
      );
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: text_color,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      );

      children.add(
        const SizedBox(width: 40),
      );
    } else {
      children.add(
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: text_color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      height: 108,
      color: background_color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, height);
}
