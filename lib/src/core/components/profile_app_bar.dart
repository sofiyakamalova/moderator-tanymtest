import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class ProfileAppBar extends StatelessWidget {
  final String? link;

  const ProfileAppBar({super.key, this.link});

  @override
  Widget build(BuildContext context) {
    const double coverHeight = 180;
    const double profileHeight = 140;
    const top = coverHeight - profileHeight / 2;
    const bottom = profileHeight / 2;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: bottom),
          color: AppColors.primary_color,
          width: double.infinity,
          height: coverHeight,
        ),
        Positioned(
          top: top,
          child: CircleAvatar(
            radius: profileHeight / 2,
            backgroundImage: NetworkImage(
              link!,
            ),
          ),
        ),
      ],
    );
  }
}
