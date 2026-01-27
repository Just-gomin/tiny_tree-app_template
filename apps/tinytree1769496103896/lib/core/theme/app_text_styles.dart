import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle headline = GoogleFonts.notoSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle body = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static TextStyle caption = GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGray,
  );
}
