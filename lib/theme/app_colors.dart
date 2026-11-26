import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color sageGreen = Color(0xFFD7E9FF);
  static const Color forestGreen = Color(0xFF3189EF);
  static const Color softCream = Color(0xFFF3F8FF);
  static const Color warmBeige = Color(0xFFDCE9F7);
  static const Color darkText = Color(0xFF17253B);
  static const Color softWhite = Color(0xFFFFFFFF);
  static const Color peach = Color(0xFF55A2F5);
  static const Color butterYellow = Color(0xFF79B8FF);
  static const Color dustyRose = Color(0xFF84B6F5);
  static const Color dustyBlue = Color(0xFF9BCBFF);
  static const Color softLilac = Color(0xFFB1C7FF);
  static const Color skyBlue = Color(0xFF76B7FF);
  static const Color deepBlue = Color(0xFF1D70CF);

  static const List<Color> learningAccents = [
    dustyBlue,
    peach,
    butterYellow,
    dustyRose,
    softLilac,
    sageGreen,
  ];

  // Darkened sage stop keeps white text legible on the progress gradient.
  static const Color sageForest = Color(0xFF286FC5);

  static const Color primary = forestGreen;
  static const Color primaryLight = warmBeige;
  static const Color primaryDark = Color(0xFF102B51);

  static const Color background = softCream;
  static const Color surface = softWhite;

  static const Color textPrimary = darkText;
  static const Color textSecondary = Color(0xFF62748A);

  static const Color success = forestGreen;
  static const Color warning = Color(0xFF9A5E2A);
  static const Color error = Color(0xFFB23E45);

  static const Color border = warmBeige;

  static Color learningAccentFor(String materialNumber) {
    final number = int.tryParse(materialNumber);
    if (number == null || number < 1) {
      return sageGreen;
    }
    return learningAccents[(number - 1) % learningAccents.length];
  }

  static Color softTint(Color color, {double opacity = 0.12}) {
    return Color.alphaBlend(color.withValues(alpha: opacity), softWhite);
  }
}
