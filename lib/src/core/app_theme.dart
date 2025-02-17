import 'package:flutter/material.dart';

class AppColors {
  // Light color scheme remains unchanged.
  static final kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

  // Define a dark color scheme using the same seed.
  static final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
    brightness: Brightness.dark,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
    ).copyWith(
      colorScheme: AppColors.kColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: AppColors.kColorScheme.inverseSurface,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: AppColors.kColorScheme.inverseSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kColorScheme.inverseSurface,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).copyWith(
      colorScheme: AppColors.kDarkColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: AppColors.kDarkColorScheme.onPrimary,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: AppColors.kDarkColorScheme.onPrimary,
        margin: EdgeInsets.only(top: 20),
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(
        color: Colors.white,
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kDarkColorScheme.inverseSurface,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData().copyWith(
        backgroundColor: AppColors.kDarkColorScheme.onPrimaryFixedVariant,
        contentTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
