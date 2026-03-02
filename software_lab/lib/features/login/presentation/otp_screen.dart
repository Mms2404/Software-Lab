import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE6E4),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              AppLogo(),

              SizedBox(height: 50.h),

              Text("Verify OTP", style: AppTextStyles.title),

              SizedBox(height: 10.h),

              RichText(
                text: TextSpan(
                  text: "Remember your password? ",
                  style: AppTextStyles.paragraph,
                  children: [
                    TextSpan(
                      text: "Login",
                      style: AppTextStyles.highlightedClue,
                    )
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightText.withValues(alpha :0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              AppButtons.full(
                text: "Submit",
                onPressed: () {},
              ),

              SizedBox(height: 20.h),

              Center(
                child: Text(
                  "Resend Code",
                  style: AppTextStyles.highlightedClue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}