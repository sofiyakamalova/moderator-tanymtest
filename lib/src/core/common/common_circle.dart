import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonCircle extends StatelessWidget {
  final double size;
  final Color? color;
  final Widget child;
  final bool? boxsh;

  const CommonCircle({
    super.key,
    required this.size,
    this.color = AppColors.bg_for_circle,
    required this.child,
    this.boxsh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: boxsh ?? false
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
