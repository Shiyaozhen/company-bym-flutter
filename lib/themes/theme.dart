import 'package:BYM/themes/colors.dart';
import 'package:flutter/material.dart';

class ByTheme {
  static ThemeData defaultTheme = ThemeData(
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ByColors.bottomNavigationBarColor,
      indicatorColor: ByColors.primaryColor,
    ),
  );
}