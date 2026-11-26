import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color sageGreen = Color(0xFF9BC9B0);
  static const Color forestGreen = Color(0xFF376FAB);
  static const Color softCream = Color(0xFFF7F5F0);
  static const Color warmBeige = Color(0xFFE8E3D8);
  static const Color darkText = Color(0xFF27384C);
  static const Color softWhite = Color(0xFFFFFEFB);
  static const Color peach = Color(0xFFED9B78);
  static const Color butterYellow = Color(0xFFF2CD69);
  static const Color dustyRose = Color(0xFFD98997);
  static const Color dustyBlue = Color(0xFF7EA5CF);
  static const Color softLilac = Color(0xFFA999D0);
  static const Color skyBlue = Color(0xFF8DBFE2);
  static const Color deepBlue = Color(0xFF2F5E90);

  static const List<Color> learningAccents = [
    dustyBlue,
    peach,
    butterYellow,
    dustyRose,
    softLilac,
    sageGreen,
  ];

  // Green remains reserved for successful progress states.
  static const Color sageForest = Color(0xFF32785B);

  static const Color primary = forestGreen;
  static const Color primaryLight = warmBeige;
  static const Color primaryDark = Color(0xFF254365);

  static const Color background = softCream;
  static const Color surface = softWhite;

  static const Color textPrimary = darkText;
  static const Color textSecondary = Color(0xFF697887);

  static const Color success = Color(0xFF39896A);
  static const Color warning = Color(0xFFAD6A2C);
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
