import 'package:auth_app/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static AppColors colors = AppColors();

  static ThemeData lightTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(cursorColor: colors.orange),
    scaffoldBackgroundColor: colors.lightGray,
    fontFamily: "Avenir",
    highlightColor: colors.orange,
    
    colorScheme: ColorScheme.fromSwatch(
      accentColor: colors.orange,
    ),
    primaryColor: colors.orange,
  );
}