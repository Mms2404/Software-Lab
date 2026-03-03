import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.beVietnamProTextTheme(),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,

  );
}