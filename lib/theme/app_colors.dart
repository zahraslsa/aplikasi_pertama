import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color sageGreen = Color(0xFF8ED8B5);
  static const Color forestGreen = Color(0xFF2382F6);
  static const Color softCream = Color(0xFFF4F7FC);
  static const Color warmBeige = Color(0xFFDCE6F3);
  static const Color darkText = Color(0xFF17253B);
  static const Color softWhite = Color(0xFFFFFFFF);
  static const Color peach = Color(0xFFFF9D66);
  static const Color butterYellow = Color(0xFFFFD35E);
  static const Color dustyRose = Color(0xFFE77E98);
  static const Color dustyBlue = Color(0xFF70A9F5);
  static const Color softLilac = Color(0xFFA993EC);
  static const Color skyBlue = Color(0xFF67B8F8);
  static const Color deepBlue = Color(0xFF1E63CD);

  static const List<Color> learningAccents = [
    dustyBlue,
    peach,
    butterYellow,
    dustyRose,
    softLilac,
    sageGreen,
  ];

  // Deep green keeps success states distinct from the blue primary.
  static const Color sageForest = Color(0xFF287A58);

  static const Color primary = forestGreen;
  static const Color primaryLight = warmBeige;
  static const Color primaryDark = Color(0xFF17376B);

  static const Color background = softCream;
  static const Color surface = softWhite;

  static const Color textPrimary = darkText;
  static const Color textSecondary = Color(0xFF68788F);

  static const Color success = Color(0xFF2E936D);
  static const Color warning = Color(0xFFAD6A24);
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
