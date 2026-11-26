import 'dart:math' as math;

import 'package:flutter/material.dart';

enum CodifyCardSilhouette { foldedNote, speechBubble, sticker, ticket }

class CodifyCardBorder extends ShapeBorder {
  final CodifyCardSilhouette silhouette;
  final BorderSide side;

  const CodifyCardBorder({
    required this.silhouette,
    this.side = BorderSide.none,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _pathFor(rect, silhouette);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _pathFor(rect.deflate(side.width), silhouette);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width == 0) {
      return;
    }
    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, side.toPaint());

    if (silhouette == CodifyCardSilhouette.foldedNote) {
      final fold = math.min(
        25.0,
        math.min(rect.width * 0.14, rect.height * 0.3),
      );
      final crease = Path()
        ..moveTo(rect.right - fold, rect.top + side.width)
        ..lineTo(rect.right - fold, rect.top + fold)
        ..lineTo(rect.right - side.width, rect.top + fold);
      canvas.drawPath(
        crease,
        Paint()
          ..color = side.color.withValues(alpha: 0.54)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.0, side.width * 0.75)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    canvas.drawPath(
      path.shift(const Offset(0.8, 0.8)),
      Paint()
        ..color = side.color.withValues(alpha: 0.24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.75
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  static Path _pathFor(Rect rect, CodifyCardSilhouette silhouette) {
    final left = rect.left;
    final top = rect.top;
    final right = rect.right;
    final bottom = rect.bottom;
    final width = rect.width;
    final height = rect.height;

    switch (silhouette) {
      case CodifyCardSilhouette.foldedNote:
        final fold = math.min(25.0, math.min(width * 0.14, height * 0.3));
        return Path()
          ..moveTo(left + 22, top)
          ..lineTo(right - fold, top)
          ..lineTo(right, top + fold)
          ..lineTo(right, bottom - 24)
          ..quadraticBezierTo(right, bottom, right - 24, bottom)
          ..lineTo(left + 24, bottom)
          ..quadraticBezierTo(left, bottom, left, bottom - 24)
          ..lineTo(left, top + 22)
          ..quadraticBezierTo(left, top, left + 22, top)
          ..close();
      case CodifyCardSilhouette.speechBubble:
        final tailHeight = math.min(14.0, height * 0.1);
        final tailWidth = math.min(32.0, width * 0.14);
        final bodyBottom = bottom - tailHeight;
        return Path()
          ..moveTo(left + 22, top)
          ..lineTo(right - 22, top)
          ..quadraticBezierTo(right, top, right, top + 22)
          ..lineTo(right, bodyBottom - 22)
          ..quadraticBezierTo(right, bodyBottom, right - 22, bodyBottom)
          ..lineTo(right - tailWidth, bodyBottom)
          ..lineTo(right - tailWidth * 0.72, bottom)
          ..lineTo(right - tailWidth * 1.8, bodyBottom)
          ..lineTo(left + 22, bodyBottom)
          ..quadraticBezierTo(left, bodyBottom, left, bodyBottom - 22)
          ..lineTo(left, top + 22)
          ..quadraticBezierTo(left, top, left + 22, top)
          ..close();
      case CodifyCardSilhouette.sticker:
        return Path()
          ..moveTo(left + width * 0.16, top)
          ..cubicTo(
            left + width * 0.04,
            top,
            left,
            top + height * 0.1,
            left + width * 0.02,
            top + height * 0.23,
          )
          ..cubicTo(
            left + width * 0.08,
            top + height * 0.4,
            left,
            top + height * 0.61,
            left + width * 0.03,
            bottom - height * 0.16,
          )
          ..cubicTo(
            left + width * 0.04,
            bottom,
            left + width * 0.16,
            bottom,
            left + width * 0.28,
            bottom - height * 0.02,
          )
          ..cubicTo(
            left + width * 0.46,
            bottom - height * 0.08,
            left + width * 0.57,
            bottom,
            left + width * 0.74,
            bottom,
          )
          ..cubicTo(
            right - width * 0.04,
            bottom,
            right,
            bottom - height * 0.12,
            right - width * 0.02,
            bottom - height * 0.3,
          )
          ..cubicTo(
            right - width * 0.06,
            top + height * 0.54,
            right,
            top + height * 0.37,
            right - width * 0.03,
            top + height * 0.22,
          )
          ..cubicTo(
            right,
            top + height * 0.08,
            right - width * 0.11,
            top,
            right - width * 0.24,
            top,
          )
          ..close();
      case CodifyCardSilhouette.ticket:
        final notch = math.min(15.0, math.min(width * 0.08, height * 0.15));
        final upperNotch = top + height * 0.36;
        final lowerNotch = top + height * 0.64;
        return Path()
          ..moveTo(left + 20, top)
          ..lineTo(right - 20, top)
          ..quadraticBezierTo(right, top, right, top + 20)
          ..lineTo(right, upperNotch)
          ..cubicTo(
            right - notch,
            upperNotch + notch * 0.42,
            right - notch,
            lowerNotch - notch * 0.42,
            right,
            lowerNotch,
          )
          ..lineTo(right, bottom - 20)
          ..quadraticBezierTo(right, bottom, right - 20, bottom)
          ..lineTo(left + 20, bottom)
          ..quadraticBezierTo(left, bottom, left, bottom - 20)
          ..lineTo(left, lowerNotch)
          ..cubicTo(
            left + notch,
            lowerNotch - notch * 0.42,
            left + notch,
            upperNotch + notch * 0.42,
            left,
            upperNotch,
          )
          ..lineTo(left, top + 20)
          ..quadraticBezierTo(left, top, left + 20, top)
          ..close();
    }
  }

  @override
  ShapeBorder scale(double t) =>
      CodifyCardBorder(silhouette: silhouette, side: side.scale(t));
}

class CodifyCardSurface extends StatelessWidget {
  final CodifyCardSilhouette silhouette;
  final Widget child;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? width;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const CodifyCardSurface({
    super.key,
    required this.silhouette,
    required this.child,
    required this.color,
    required this.borderColor,
    this.borderWidth = 1.4,
    this.elevation = 3,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.width,
    this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final border = CodifyCardBorder(
      silhouette: silhouette,
      side: BorderSide(color: borderColor, width: borderWidth),
    );
    return Container(
      width: width,
      margin: margin,
      child: PhysicalShape(
        clipper: _CodifyCardClipper(border),
        color: gradient == null ? color : Colors.transparent,
        shadowColor: borderColor.withValues(alpha: 0.2),
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          foregroundPainter: _CodifyCardOutlinePainter(border),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              if (gradient != null)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: gradient),
                  ),
                ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  customBorder: border,
                  onTap: onTap,
                  child: Padding(padding: padding, child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CodifyCardClipper extends CustomClipper<Path> {
  final CodifyCardBorder border;

  const _CodifyCardClipper(this.border);

  @override
  Path getClip(Size size) => border.getOuterPath(Offset.zero & size);

  @override
  bool shouldReclip(covariant _CodifyCardClipper oldClipper) =>
      oldClipper.border.silhouette != border.silhouette ||
      oldClipper.border.side.width != border.side.width;
}

class _CodifyCardOutlinePainter extends CustomPainter {
  final CodifyCardBorder border;

  const _CodifyCardOutlinePainter(this.border);

  @override
  void paint(Canvas canvas, Size size) {
    border.paint(canvas, Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant _CodifyCardOutlinePainter oldDelegate) =>
      oldDelegate.border.silhouette != border.silhouette ||
      oldDelegate.border.side != border.side;
}
