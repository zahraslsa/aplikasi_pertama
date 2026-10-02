import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CodifyLogo extends StatelessWidget {
  final double size;
  final bool showTitle;

  const CodifyLogo({super.key, this.size = 64, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.28),
          ),
          child: Icon(
            Icons.code_rounded,
            color: Colors.white,
            size: size * 0.58,
          ),
        ),
        if (showTitle) ...[
          const SizedBox(height: 12),
          Text(
            'CODIFY',
            style: TextStyle(
              fontSize: size * 0.34,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Learn to Code, One Step at a Time',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}
