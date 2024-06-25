import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static final appLightTheme = ThemeData().copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThemeData().textTheme.copyWith(
            headlineLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightBlue700,
            ),
            headlineMedium: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: AppPallete.lightBlue300,
            ),
            labelMedium: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightBlue700,
            ),
            labelLarge: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppPallete.blueGray50),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppPallete.cyan100),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: AppPallete.lightBlue700,
        ),
      ));
}
