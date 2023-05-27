import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/styles/app_colors.dart';
import 'package:lumiere/app/shared/core/styles/app_text_style.dart';
import 'package:lumiere/app/shared/core/styles/color_schemes.g.dart';

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
    cardColor: darkColorScheme.background,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle:
          AppTextStyles.textMediumH14.apply(color: AppColors.textSecundary),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      filled: true,
      fillColor: darkColorScheme.onSurfaceVariant,
      hintStyle: AppTextStyles.textMediumH14
          .apply(color: darkColorScheme.onSurface.withOpacity(.5)),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(28),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(28),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1, style: BorderStyle.solid, color: darkColorScheme.primary),
        borderRadius: BorderRadius.circular(28),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(28),
        // borderSide: BorderSide(color: AppColors.roude, width: 1.0),
      ),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: AppColors.tertiary),
    cardTheme: const CardTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: darkColorScheme.primaryContainer,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
  );
}
