import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/constants/app_strings.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Color> bgColors = [
    AppColors.tertiary,
    AppColors.primary,
    AppColors.secondary,
  ];

  final List<String> titles = [
    "Quality",
    "Convenient",
    "Local",
  ];

  final List<String> descriptions = [
    AppStrings.quality,
    AppStrings.convenient,
    AppStrings.local,
  ];

  final List<String> images = [
    "assets/images/quality.png",
    "assets/images/convenient.png",
    "assets/images/local.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    color: bgColors[currentIndex],
    child: Column(
      children: [

        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  images[index],
                  height: 500.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),

        Container(
          height: 391.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h,right: 25.w, left: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                Text(
                  titles[currentIndex],
                  style: AppTextStyles.subTitle,
                ),
        
                SizedBox(height: 30.h),
        
                Text(
                  descriptions[currentIndex],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.paragraph,
                ),
        
                SizedBox(height: 30.h),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: currentIndex == index ? 16.w : 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 50.h),
        
                AppButtons.half(
                  text: "Join the movement!",
                  backgroundColor: bgColors[currentIndex],
                  onPressed: () {},
                ),
        
                SizedBox(height: 10.h),
        
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "Login",
                    style: AppTextStyles.highlightedClue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}