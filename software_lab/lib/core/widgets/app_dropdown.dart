import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final ValueChanged<T?> onChanged;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126.w,
      height: 52.h,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items,
        onChanged: onChanged,
        icon: Padding(
          padding: EdgeInsets.all(5.w),
          child: Image.asset(  
            'assets/icons/dropdown.png',
            width: 8.w,
            height: 8.h,
          ),
        ),
        style: AppTextStyles.paragraph,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.clue,
          filled: true,
          fillColor: AppColors.lightText.withValues(alpha: 0.08),

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),

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
        ),
        dropdownColor: Colors.white,
      ),
    );
  }
}