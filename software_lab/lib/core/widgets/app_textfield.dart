import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final String? suffixText;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType type;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixText,
    this.onSuffixTap,
    this.validator,
    this.obscureText = false,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: type,
        validator: validator,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: AppTextStyles.clue,


          filled: true,
          fillColor: AppColors.lightText.withValues(alpha: 0.08),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColors.primary,
          ),

          prefixIcon: prefixIcon != null
              ? Padding(
                  padding:EdgeInsets.all(18.w),
                  child: Image.asset(prefixIcon!,height: 15.h,width: 15.w,)
                )
              : null,

          suffixIcon: suffixText != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Padding(
                    padding: EdgeInsets.all(18.w),
                    child: Text(
                      suffixText!,
                      style: AppTextStyles.highlightedClue,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}


class ZipcodeField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const ZipcodeField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 188,
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.lightText,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.lightText
          ),
          filled: true,
          fillColor: AppColors.primary.withValues(alpha: 0.08),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}