import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'codify_mascot.dart';

class CodifyProgressMap extends StatelessWidget {
  final double progress;
  final int completedCount;
  final int totalMaterials;

  const CodifyProgressMap({
    super.key,
    required this.progress,
    required this.completedCount,
    required this.totalMaterials,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedProgress = progress.clamp(0.0, 1.0).toDouble();

    return Semantics(
      label:
          'Peta progres belajar: $completedCount dari $totalMaterials materi selesai.',
      child: SizedBox(
        height: 126,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, 126);
            final path = _learningPath(size);
            final metrics = path.computeMetrics().toList();
            if (metrics.isEmpty) {
              return const SizedBox.shrink();
            }

            final metric = metrics.first;
            final distance = normalizedProgress >= 1
                ? metric.length - 0.01
                : metric.length * normalizedProgress;
            final point =
                metric.getTangentForOffset(distance)?.position ?? Offset.zero;
            final markerLeft = (point.dx - 42)
                .clamp(0.0, size.width - 52)
                .toDouble();
            final markerTop = (point.dy - 41)
                .clamp(0.0, size.height - 40)
                .toDouble();

            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _DottedLearningPathPainter(
                      progress: normalizedProgress,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeInOutCubic,
                  left: markerLeft,
                  top: markerTop,
                  child: SizedBox(
                    width: 52,
                    height: 40,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 0,
                          top: 0,
                          child: CodifyMascot(
                            size: 32,
                            character: CodifyCharacter.codi,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.softWhite,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.butterYellow,
                                width: 1.8,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryDark.withValues(
                                    alpha: 0.16,
                                  ),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.flag_rounded,
                              size: 13,
                              color: AppColors.dustyRose,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 2,
                  child: _MapCaption(
                    icon: Icons.play_arrow_rounded,
                    label: 'MULAI',
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 2,
                  child: _MapCaption(
                    icon: Icons.emoji_events_rounded,
                    label: 'TUNTAS',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static Path _learningPath(Size size) {
    final anchors = [
      Offset(size.width * 0.14, size.height * 0.68),
      Offset(size.width * 0.23, size.height * 0.51),
      Offset(size.width * 0.32, size.height * 0.72),
      Offset(size.width * 0.41, size.height * 0.55),
      Offset(size.width * 0.50, size.height * 0.66),
      Offset(size.width * 0.59, size.height * 0.43),
      Offset(size.width * 0.68, size.height * 0.60),
      Offset(size.width * 0.86, size.height * 0.48),
    ];
    final path = Path()..moveTo(anchors.first.dx, anchors.first.dy);

    for (var index = 0; index < anchors.length - 1; index++) {
      final start = anchors[index];
      final end = anchors[index + 1];
      final segmentWidth = end.dx - start.dx;
      path.cubicTo(
        start.dx + segmentWidth * 0.4,
        start.dy,
        start.dx + segmentWidth * 0.6,
        end.dy,
        end.dx,
        end.dy,
      );
    }

    return path;
  }
}

class _MapCaption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MapCaption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class _DottedLearningPathPainter extends CustomPainter {
  final double progress;

  const _DottedLearningPathPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = CodifyProgressMap._learningPath(size);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) {
      return;
    }

    final metric = metrics.first;
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.dustyBlue.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    const gaps = [10.0, 12.0, 9.0, 13.0, 10.0, 11.0];
    const radii = [2.3, 2.8, 2.0, 2.6, 1.9];
    final completedDistance = metric.length * progress;
    var distance = 0.0;
    var dotIndex = 0;
    while (distance <= metric.length) {
      final point = metric.getTangentForOffset(distance)?.position;
      if (point != null) {
        final isReached = distance <= completedDistance;
        final radius = radii[dotIndex % radii.length];
        canvas.drawCircle(
          point,
          radius,
          Paint()
            ..color = isReached
                ? AppColors.primary
                : AppColors.dustyBlue.withValues(alpha: 0.56)
            ..style = PaintingStyle.fill,
        );
        if (dotIndex % 9 == 0) {
          canvas.drawCircle(
            point,
            radius + 1.6,
            Paint()
              ..color = AppColors.butterYellow.withValues(alpha: 0.86)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.1,
          );
        }
      }
      distance += gaps[dotIndex % gaps.length];
      dotIndex++;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLearningPathPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
