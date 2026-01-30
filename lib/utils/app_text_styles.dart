import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // App Name / Logo Text
  static TextStyle appName({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textBlack,
      );
      
  // Headline / page titles (prominent)
  static TextStyle headline({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textBlack);

  // Section titles
  static TextStyle title({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textBlack);

  // Subtitles and row headers
  static TextStyle subtitle({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textGray);

  // Body / paragraph text
  static TextStyle body({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 14, 
        fontWeight: FontWeight.w400, 
        color: color ?? AppColors.textBlack);

  // Small informative text / meta
  static TextStyle caption({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textGray);

  // Buttons (primary)
  static TextStyle button({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textWhite);

  // Compact / dense labels
  static TextStyle small({Color? color}) =>
      GoogleFonts.roboto(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textGray);
}