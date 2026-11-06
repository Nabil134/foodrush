import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class AppTheme {
  AppTheme._();

  /* ================= DARK THEME ================= */

  static final ThemeData darkTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    brightness: Brightness.dark,
    useMaterial3: true,

    /* ---------- Global Colors ---------- */

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,

    /* ---------- Color Scheme ---------- */

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.cardDark,
    ),

    /* ---------- Icon Theme ---------- */

    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),

    /* ---------- AppBar ---------- */

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,

      iconTheme: IconThemeData(
        color: AppColors.white,
      ),

      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    /* ---------- Text Theme ---------- */

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        color: AppColors.textLight,
      ),

      titleLarge: TextStyle(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: AppColors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),

    /* ---------- Bottom Navigation ---------- */

    bottomNavigationBarTheme:
    const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.cardDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      elevation: 0,
    ),

    /* ---------- Floating Action Button ---------- */

    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 4,
    ),


    /* ---------- Input Fields ---------- */

  );

  /* ================= LIGHT THEME ================= */

  static final ThemeData lightTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    brightness: Brightness.light,
    useMaterial3: true,

    /* ---------- Global Colors ---------- */

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,

    /* ---------- Color Scheme ---------- */

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.card,
    ),

    /* ---------- Icon Theme ---------- */

    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),

    /* ---------- AppBar ---------- */

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.card,
      foregroundColor: AppColors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,

      iconTheme: IconThemeData(
        color: AppColors.black,
      ),

      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    /* ---------- Text Theme ---------- */

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        color: AppColors.textSecondary,
      ),

      titleLarge: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),

    /* ---------- Bottom Navigation ---------- */

    bottomNavigationBarTheme:
    const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.card,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      elevation: 0,
    ),

    /* ---------- Floating Action Button ---------- */

    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 4,
    ),



  );
}