import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.primaryOrange,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgGrey,
      textTheme: ThemeData.light().textTheme,
    );
  }
}
