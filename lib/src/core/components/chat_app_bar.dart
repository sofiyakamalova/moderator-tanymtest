import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const ChatAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary_color,
      height: 120,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white_color,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/images/teacher.png',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 10),
              CommonTitle(
                text: text,
                color: AppColors.white_color,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: AppColors.white_color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 120);
}
