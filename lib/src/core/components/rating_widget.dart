import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final double starSize;
  final int starCount;
  final Color starColor;
  final Color emptyStarColor;

  const RatingWidget({
    Key? key,
    required this.rating,
    this.starSize = 25,
    this.starCount = 5,
    this.starColor = Colors.amber,
    this.emptyStarColor = AppColors.grey_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star,
          size: starSize,
          color: index < rating.floor() ? starColor : emptyStarColor,
        );
      }),
    );
  }
}
