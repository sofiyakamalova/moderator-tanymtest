import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final double? height;
  final TextInputType keyboardType;
  final TextInputAction? txtInpAct;
  final Widget? suffixIcon;
  final Color? suffixColor;
  final Widget? icon;
  const CommonTextField({
    super.key,
    required this.keyboardType,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onTap,
    this.txtInpAct,
    this.focusNode,
    this.icon,
    this.suffixIcon,
    this.suffixColor,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: TextField(
        onTap: onTap,
        controller: controller,
        obscureText: obscureText,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: txtInpAct,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: AppColors.primary_color,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixColor,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.low_primary_color,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          fillColor: AppColors.white_color,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.light_grey_color),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary_color),
            borderRadius: BorderRadius.circular(5),
          ),
          //  errorText: errorMsg,
        ),
      ),
    );
  }
}
