import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle logo = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle paragraph = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.logo
  );

  static TextStyle title = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle subTitle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle button = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle clue = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText
  );

  static TextStyle highlightedClue = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static TextStyle todo = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.logo,
    decoration: TextDecoration.underline,
  );

  static TextStyle mini = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
  );
}