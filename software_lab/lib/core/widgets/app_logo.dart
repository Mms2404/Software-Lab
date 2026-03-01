import 'package:flutter/material.dart';
import 'package:software_lab/core/constants/app_strings.dart';
import '../theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.appName,
      style: AppTextStyles.logo,
    );
  }
}