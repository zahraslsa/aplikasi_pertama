import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color sageGreen = Color(0xFF58B5FF);
  static const Color forestGreen = Color(0xFF1877F2);
  static const Color softCream = Color(0xFFF4F8FF);
  static const Color warmBeige = Color(0xFFD9E6F8);
  static const Color darkText = Color(0xFF142640);
  static const Color softWhite = Color(0xFFFFFFFF);
  static const Color peach = Color(0xFFFF8757);
  static const Color butterYellow = Color(0xFFFFC92F);
  static const Color dustyRose = Color(0xFFF06F93);
  static const Color dustyBlue = Color(0xFF4C8FF2);
  static const Color softLilac = Color(0xFF9B72F2);
  static const Color skyBlue = Color(0xFF36B7F7);
  static const Color deepBlue = Color(0xFF1559C7);

  static const List<Color> learningAccents = [
    dustyBlue,
    peach,
    butterYellow,
    dustyRose,
    softLilac,
    sageGreen,
  ];

  // Deep blue keeps success states distinct from the colorful lesson accents.
  static const Color sageForest = Color(0xFF244E86);

  static const Color primary = forestGreen;
  static const Color primaryLight = warmBeige;
  static const Color primaryDark = Color(0xFF123366);

  static const Color background = softCream;
  static const Color surface = softWhite;

  static const Color textPrimary = darkText;
  static const Color textSecondary = Color(0xFF5A6E8C);

  static const Color success = Color(0xFF278FE3);
  static const Color warning = Color(0xFFE08A1E);
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
