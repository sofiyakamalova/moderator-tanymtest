import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonButton extends StatefulWidget {
  final Future<void> Function()? onTap;
  final String text;
  final Color border_color;
  final Color background_color;
  final Color text_color;
  final double pad_size;
  final double? fntSize;
  final FontWeight? fntWeight;
  final double? padding;
  final bool? isCustom;
  final double? vert;
  final double? hor;
  final double? borderRad;
  final double? borderWidth;
  final bool? itMustbe;

  const CommonButton({
    super.key,
    required this.onTap,
    required this.text,
    this.border_color = AppColors.primary_color,
    this.background_color = AppColors.primary_color,
    this.text_color = AppColors.white_color,
    this.pad_size = 20,
    this.fntSize,
    this.fntWeight = FontWeight.bold,
    this.padding = 15,
    this.isCustom = false,
    this.hor,
    this.vert,
    this.borderRad = 5,
    this.borderWidth = 1,
    this.itMustbe = false,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.itMustbe == true) {
          setState(() {
            _isLoading = true;
          });

          await Future.delayed(Duration(milliseconds: 500));

          await widget.onTap?.call();

          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading == false;
          });
          await widget.onTap?.call();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: widget.pad_size),
        padding: EdgeInsets.all(widget.padding!),
        decoration: BoxDecoration(
          color: widget.background_color,
          borderRadius: BorderRadius.circular(widget.borderRad!),
          border: Border.all(
            color: widget.border_color,
            width: widget.borderWidth!,
          ),
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: const CircularProgressIndicator(
                    color: AppColors.white_color,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: widget.fntSize,
                    color: widget.text_color,
                    fontWeight: widget.fntWeight,
                  ),
                ),
        ),
      ),
    );
  }
}
