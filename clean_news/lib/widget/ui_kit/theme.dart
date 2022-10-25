import 'package:clean_news/widget/ui_kit/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.success),
    scaffoldBackgroundColor: AppColors.black,
    fontFamily: 'Poppins',
    highlightColor: AppColors.white,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.success),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.success,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black, elevation: 0, centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      accentColor: AppColors.success,
    ),
    primaryColor: AppColors.success,
  );
}
