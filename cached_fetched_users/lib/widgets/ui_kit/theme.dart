import 'package:cached_fetched_users/widgets/widgets.dart';
import 'package:flutter/material.dart';


class AppTheme {
  static AppColors colors = AppColors();

  static ThemeData theme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.blueColor),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    fontFamily: "Core Sans",
    highlightColor: AppColors.blueColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.blueColor,
    ),
    primaryColor: AppColors.blueColor,
  );
}
