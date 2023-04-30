import 'package:chat_app/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor _kToDark = MaterialColor(
    0xffb74c3a,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffb74c3a),
      100: Color(0xffb74c3a),
      200: Color(0xffb74c3a),
      300: Color(0xffb74c3a),
      400: Color(0xffb74c3a),
      500: Color(0xffb74c3a),
      600: Color(0xffb74c3a),
      700: Color(0xffb74c3a),
      800: Color(0xffb74c3a),
      900: Color(0xffb74c3a),
    },
  );

  static ThemeData mainTheme() => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
      );
}
