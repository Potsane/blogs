import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static final appLightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: ThemeData().textTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppPallete.mandy,
          ),
          headlineMedium: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: AppPallete.sweetPink,
          ),
          labelMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppPallete.mandy,
          ),
        ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppPallete.citron),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppPallete.citron),
      ),
    ),
  );
}
