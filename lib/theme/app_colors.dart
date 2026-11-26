import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color sageGreen = Color(0xFFA8BFA3);
  static const Color forestGreen = Color(0xFF426B50);
  static const Color softCream = Color(0xFFF7F4E9);
  static const Color warmBeige = Color(0xFFE8DDC8);
  static const Color darkText = Color(0xFF30352F);
  static const Color softWhite = Color(0xFFFFFDF7);

  // Darkened sage stop keeps white text legible on the progress gradient.
  static const Color sageForest = Color(0xFF577A60);

  static const Color primary = forestGreen;
  static const Color primaryLight = warmBeige;
  static const Color primaryDark = Color(0xFF355640);

  static const Color background = softCream;
  static const Color surface = softWhite;

  static const Color textPrimary = darkText;
  static const Color textSecondary = Color(0xFF62685F);

  static const Color success = forestGreen;
  static const Color warning = Color(0xFF9A5E2A);
  static const Color error = Color(0xFFB23E45);

  static const Color border = warmBeige;
}
