import 'package:flutter/material.dart';
import 'utils/app_colors.dart';
import 'utils/app_text_styles.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const GlucoMateApp());
}

class GlucoMateApp extends StatelessWidget {
  const GlucoMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _appTheme(),
      home: DashboardScreen(), 
    );
  }
}

ThemeData _appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,

    // 🌈 Primary color (removes purple)
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.buttonCyan,
      primary: AppColors.buttonCyan,
    ),

    // ✍️ Global font (Roboto)
    textTheme: TextTheme(
      headlineSmall: AppTextStyles.headline(),
      titleMedium: AppTextStyles.title(),
      bodyMedium: AppTextStyles.body(),
      labelLarge: AppTextStyles.button(),
    ),

    // 🧾 TextField theme
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: AppTextStyles.caption(),
      hintStyle: AppTextStyles.caption(),
      floatingLabelStyle: AppTextStyles.caption(color: AppColors.textGray),

      filled: true,
      fillColor: AppColors.white,

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(8),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.buttonCyan, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),

      suffixIconColor: AppColors.iconBlack,
    ),

    // 🔘 Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonCyan,
        foregroundColor: AppColors.textWhite,
        textStyle: AppTextStyles.button(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // ⬇️ Dropdown
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyles.body(),
    ),

    // ⌚ Cursor color
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.buttonCyan,
      selectionColor: AppColors.lightCyan,
      selectionHandleColor: AppColors.buttonCyan,
    ),

    // 📅 Date & Time picker
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.white,
      headerBackgroundColor: AppColors.buttonCyan,
      headerForegroundColor: AppColors.textWhite,
      dayForegroundColor:
          MaterialStateProperty.all(AppColors.textBlack),
      todayBorder:
          BorderSide(color: AppColors.buttonCyan),
    ),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.white,
      dialHandColor: AppColors.buttonCyan,
      hourMinuteColor: AppColors.lightCyan,
      hourMinuteTextColor: AppColors.textBlack,
    ),
  );
}
