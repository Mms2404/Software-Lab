import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';

class AppButtons {
  AppButtons._();

  static Widget full({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 330.w,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(117.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.button,
        ),
      ),
    );
  }

  static Widget half({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return SizedBox(
      width: 236.w,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(117.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.button,
        ),
      ),
    );
  }


static Widget choose({
  required String text,
  required bool isSelected,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: 160.w,
    height: 48.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            isSelected ? AppColors.secondary : Colors.transparent,
        foregroundColor:
            isSelected ? Colors.white : AppColors.primary,
        side: BorderSide(
          color: AppColors.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color:
              isSelected ? Colors.white : AppColors.primary,
        ),
      ),
    ),
  );
}



static Widget chooseDay({
  required String text,
  required DaySelectionState state,
  required VoidCallback onPressed,
}) {
  Color backgroundColor;
  Color textColor;

  switch (state) {
    case DaySelectionState.active:
      backgroundColor = AppColors.primary;
      textColor = Colors.white;
      break;

    case DaySelectionState.completed:
      backgroundColor = AppColors.lightText;
      textColor = AppColors.logo;
      break;

    case DaySelectionState.defaultState:
      backgroundColor = Colors.white;
      textColor = AppColors.logo;
      break;
      
  }
  return SizedBox(
    width: 36.w,
    height: 36.h,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}

}




enum DaySelectionState {
  defaultState,
  active,
  completed,
}