import 'package:flutter/material.dart';
import 'package:lumiere/app/core/styles/app_colors.dart';
import 'package:lumiere/app/core/styles/app_text_style.dart';
import 'package:lumiere/app/core/styles/color_schemes.g.dart';

class DarkTheme {
  static final darkTheme = ThemeData(
      fontFamily: 'NotoSans',
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      backgroundColor: darkColorScheme.background,
      primaryTextTheme: const TextTheme().apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.secundary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:AppTextStyles.textMediumH14.apply(color: AppColors.textSecundary),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        //   borderRadius: BorderRadius.circular(28),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   // borderSide: BorderSide(color: AppColors.roude, width: 1.0),
        // ),
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: AppColors.tertiary),
      cardTheme: const CardTheme());
}
