import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'codify_mascot.dart';

class CodifyProgressMap extends StatefulWidget {
  final double progress;
  final int completedCount;
  final int totalMaterials;
  final VoidCallback onMascotTap;

  const CodifyProgressMap({
    super.key,
    required this.progress,
    required this.completedCount,
    required this.totalMaterials,
    required this.onMascotTap,
  });

  @override
  State<CodifyProgressMap> createState() => _CodifyProgressMapState();
}

class _CodifyProgressMapState extends State<CodifyProgressMap> {
  static const _mapHeight = 174.0;
  static const _markerWidth = 98.0;
  static const _markerHeight = 74.0;

  final ScrollController _scrollController = ScrollController();
  String? _revealedProgress;
  String? _pendingProgress;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _revealCurrentPosition({
    required String progressKey,
    required double markerX,
    required double viewportWidth,
  }) {
    if (_revealedProgress == progressKey || _pendingProgress == progressKey) {
      return;
    }

    _pendingProgress = progressKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pendingProgress = null;
      if (!mounted || !_scrollController.hasClients) {
        return;
      }

      _revealedProgress = progressKey;
      final position = _scrollController.position;
      final target = (markerX - viewportWidth * 0.48)
          .clamp(0.0, position.maxScrollExtent)
          .toDouble();
      if ((position.pixels - target).abs() > 18) {
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.progress.clamp(0.0, 1.0).toDouble();
    final totalSteps = widget.totalMaterials > 0 ? widget.totalMaterials : 1;
    final reachedSteps = widget.completedCount.clamp(0, totalSteps).toInt();

    return Semantics(
      label:
          'Peta progres belajar: ${widget.completedCount} dari ${widget.totalMaterials} materi selesai.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.swipe_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  'GESER JALURNYA',
                  style: TextStyle(
                    color: AppColors.primaryDark.withValues(alpha: 0.78),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: _mapHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final viewportWidth = constraints.maxWidth;
                final contentWidth = math
                    .max(viewportWidth, totalSteps * 92.0 + 188)
                    .toDouble();
                final routeInset = math.min(94.0, contentWidth * 0.2);
                final mapSize = Size(contentWidth, _mapHeight);
                final path = _CodifyProgressMapState._learningPath(
                  mapSize,
                  totalSteps,
                );
                final metrics = path.computeMetrics().toList();
                if (metrics.isEmpty) {
                  return const SizedBox.shrink();
                }

                final metric = metrics.first;
                final distance = progress >= 1
                    ? metric.length - 0.01
                    : metric.length * progress;
                final point =
                    metric.getTangentForOffset(distance)?.position ??
                    Offset.zero;
                final markerLeft = (point.dx - 84)
                    .clamp(0.0, contentWidth - _markerWidth)
                    .toDouble();
                final markerTop = (point.dy - 72)
                    .clamp(0.0, _mapHeight - _markerHeight)
                    .toDouble();

                _revealCurrentPosition(
                  progressKey: '${widget.completedCount}/$totalSteps',
                  markerX: point.dx,
                  viewportWidth: viewportWidth,
                );

                return Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    key: const ValueKey('home-progress-scroll'),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: SizedBox(
                      width: contentWidth,
                      height: _mapHeight,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _DottedLearningPathPainter(
                                progress: progress,
                                completedCount: reachedSteps,
                                totalSteps: totalSteps,
                              ),
                            ),
                          ),
                          Positioned(
                            left: routeInset - 28,
                            bottom: 5,
                            child: const _MapCaption(
                              icon: Icons.play_arrow_rounded,
                              label: 'MULAI',
                            ),
                          ),
                          Positioned(
                            right: routeInset - 32,
                            bottom: 5,
                            child: const _MapCaption(
                              icon: Icons.emoji_events_rounded,
                              label: 'TUNTAS',
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 850),
                            curve: Curves.easeInOutCubic,
                            left: markerLeft,
                            top: markerTop,
                            child: SizedBox(
                              width: _markerWidth,
                              height: _markerHeight,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Semantics(
                                      button: true,
                                      label: 'Buka materi terakhir dipelajari, atau mulai dari materi pertama.',
                                      child: InkWell(
                                        key: const ValueKey(
                                          'home-progress-mascot',
                                        ),
                                        onTap: widget.onMascotTap,
                                        borderRadius: BorderRadius.circular(36),
                                        child: const CodifyMascot(
                                          size: 68,
                                          character: CodifyCharacter.codi,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: AppColors.softWhite,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.butterYellow,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryDark
                                                .withValues(alpha: 0.18),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.flag_rounded,
                                        size: 18,
                                        color: AppColors.dustyRose,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Path _learningPath(Size size, int totalSteps) {
    const verticalOffsets = [
      0.0,
      -30.0,
      20.0,
      -23.0,
      28.0,
      -14.0,
      22.0,
      -27.0,
      17.0,
      -20.0,
      25.0,
      -12.0,
      0.0,
    ];
    final inset = math.min(94.0, size.width * 0.2);
    final routeWidth = math.max(0.0, size.width - inset * 2);
    final baseY = size.height * 0.66;
    final anchors = List.generate(totalSteps + 1, (index) {
      final progress = index / totalSteps;
      final y = (baseY + verticalOffsets[index % verticalOffsets.length])
          .clamp(60.0, size.height - 34)
          .toDouble();
      return Offset(inset + routeWidth * progress, y);
    });
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
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.9,
          ),
        ),
      ],
    );
  }
}

class _DottedLearningPathPainter extends CustomPainter {
  final double progress;
  final int completedCount;
  final int totalSteps;

  const _DottedLearningPathPainter({
    required this.progress,
    required this.completedCount,
    required this.totalSteps,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _CodifyProgressMapState._learningPath(size, totalSteps);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) {
      return;
    }

    final metric = metrics.first;
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.dustyBlue.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    final completedDistance = metric.length * progress;
    if (completedDistance > 0) {
      canvas.drawPath(
        metric.extractPath(0, completedDistance),
        Paint()
          ..color = AppColors.skyBlue.withValues(alpha: 0.34)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    const gaps = [12.0, 15.0, 10.0, 14.0, 11.0, 13.0];
    const radii = [2.8, 3.3, 2.4, 3.0, 2.2];
    var distance = 0.0;
    var dotIndex = 0;
    while (distance < metric.length) {
      final point = metric.getTangentForOffset(distance)?.position;
      if (point != null) {
        final reached = distance <= completedDistance;
        final radius = radii[dotIndex % radii.length];
        canvas.drawCircle(
          point,
          radius,
          Paint()
            ..color = reached
                ? AppColors.primary
                : AppColors.dustyBlue.withValues(alpha: 0.62)
            ..style = PaintingStyle.fill,
        );
        if (dotIndex % 8 == 0) {
          canvas.drawCircle(
            point,
            radius + 1.8,
            Paint()
              ..color = AppColors.butterYellow.withValues(alpha: 0.9)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.3,
          );
        }
      }
      distance += gaps[dotIndex % gaps.length];
      dotIndex++;
    }

    for (var step = 1; step <= totalSteps; step++) {
      final nodeDistance = metric.length * step / totalSteps;
      final point = metric.getTangentForOffset(nodeDistance)?.position;
      if (point == null) {
        continue;
      }

      final isCompleted = step <= completedCount;
      final fillColor = isCompleted ? AppColors.primary : AppColors.softWhite;
      canvas.drawCircle(
        point,
        13,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        point,
        13,
        Paint()
          ..color = isCompleted
              ? AppColors.primaryDark
              : AppColors.dustyBlue.withValues(alpha: 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8,
      );
      _paintNodeNumber(
        canvas,
        point,
        step.toString().padLeft(2, '0'),
        isCompleted ? AppColors.softWhite : AppColors.primaryDark,
      );
    }
  }

  static void _paintNodeNumber(
    Canvas canvas,
    Offset center,
    String number,
    Color color,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: number,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _DottedLearningPathPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.completedCount != completedCount ||
      oldDelegate.totalSteps != totalSteps;
}
