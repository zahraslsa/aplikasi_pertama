import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CodifyMascot extends StatelessWidget {
  final double size;

  const CodifyMascot({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Maskot Codify, makhluk tunas kecil yang suka coding',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _CodifyMascotPainter()),
      ),
    );
  }
}

class _CodifyMascotPainter extends CustomPainter {
  static const _forest = AppColors.primaryDark;
  static const _sage = AppColors.primary;
  static const _sageLight = AppColors.skyBlue;
  static const _sageDark = AppColors.deepBlue;
  static const _cream = AppColors.softWhite;
  static const _orange = AppColors.peach;

  final Paint _fill = Paint()..style = PaintingStyle.fill;
  final Paint _detailStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    const designSize = 160.0;
    final scale = size.shortestSide / designSize;
    canvas.save();
    canvas.translate(
      (size.width - designSize * scale) / 2,
      (size.height - designSize * scale) / 2,
    );
    canvas.scale(scale);

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.2
      ..color = _forest;

    _drawTail(canvas, outline);
    _drawFeet(canvas, outline);
    _drawArms(canvas, outline);
    _drawSprout(canvas, outline);
    _drawBody(canvas, outline);
    _drawFace(canvas);
    _drawCodeMark(canvas);
    _drawSketchAccents(canvas);

    canvas.restore();
  }

  void _drawTail(Canvas canvas, Paint outline) {
    final tail = Path()
      ..moveTo(43, 99)
      ..cubicTo(28, 93, 17, 100, 19, 112)
      ..cubicTo(21, 124, 37, 127, 46, 115)
      ..cubicTo(51, 109, 49, 103, 43, 99)
      ..close();
    canvas.drawPath(tail, _fill..color = _sageDark);
    canvas.drawPath(tail, outline);

    final curl = Path()
      ..moveTo(31, 108)
      ..cubicTo(31, 102, 39, 101, 42, 106)
      ..cubicTo(45, 111, 40, 116, 35, 115);
    canvas.drawPath(
      curl,
      _detailStroke
        ..color = _sageLight
        ..strokeWidth = 2.2,
    );
  }

  void _drawFeet(Canvas canvas, Paint outline) {
    final leftFoot = Path()
      ..moveTo(59, 119)
      ..cubicTo(58, 128, 51, 132, 51, 137)
      ..cubicTo(52, 141, 65, 142, 72, 138)
      ..cubicTo(75, 135, 71, 130, 73, 121)
      ..close();
    final rightFoot = Path()
      ..moveTo(96, 120)
      ..cubicTo(97, 129, 94, 134, 97, 138)
      ..cubicTo(102, 142, 115, 140, 116, 136)
      ..cubicTo(116, 132, 108, 128, 108, 119)
      ..close();

    for (final foot in [leftFoot, rightFoot]) {
      canvas.drawPath(foot, _fill..color = _sageDark);
      canvas.drawPath(foot, outline);
    }
  }

  void _drawArms(Canvas canvas, Paint outline) {
    final leftArm = Path()
      ..moveTo(40, 76)
      ..cubicTo(32, 75, 26, 79, 27, 85)
      ..cubicTo(28, 91, 36, 92, 43, 86);
    final rightArm = Path()
      ..moveTo(126, 76)
      ..cubicTo(134, 74, 140, 78, 138, 84)
      ..cubicTo(137, 90, 130, 91, 124, 85);

    for (final arm in [leftArm, rightArm]) {
      canvas.drawPath(
        arm,
        _detailStroke
          ..color = _sageDark
          ..strokeWidth = 10,
      );
      canvas.drawPath(arm, outline);
    }
  }

  void _drawSprout(Canvas canvas, Paint outline) {
    final leftLeaf = Path()
      ..moveTo(76, 43)
      ..cubicTo(67, 33, 54, 25, 59, 15)
      ..cubicTo(72, 13, 82, 25, 84, 37)
      ..close();
    final rightLeaf = Path()
      ..moveTo(84, 40)
      ..cubicTo(85, 26, 96, 16, 108, 19)
      ..cubicTo(111, 30, 101, 39, 91, 45)
      ..close();

    canvas.drawPath(leftLeaf, _fill..color = _sageLight);
    canvas.drawPath(leftLeaf, outline);
    canvas.drawPath(rightLeaf, _fill..color = _sage);
    canvas.drawPath(rightLeaf, outline);

    final veins = _detailStroke
      ..color = _forest.withValues(alpha: 0.6)
      ..strokeWidth = 1.7;
    canvas.drawPath(
      Path()
        ..moveTo(80, 40)
        ..cubicTo(76, 31, 69, 24, 63, 19),
      veins,
    );
    canvas.drawPath(
      Path()
        ..moveTo(86, 41)
        ..cubicTo(90, 32, 99, 25, 106, 22),
      veins,
    );
  }

  void _drawBody(Canvas canvas, Paint outline) {
    final body = Path()
      ..moveTo(50, 49)
      ..cubicTo(55, 39, 68, 36, 79, 41)
      ..cubicTo(90, 33, 105, 37, 112, 46)
      ..cubicTo(126, 44, 138, 55, 136, 69)
      ..cubicTo(146, 81, 141, 97, 131, 105)
      ..cubicTo(136, 119, 122, 132, 106, 132)
      ..cubicTo(91, 143, 71, 139, 61, 130)
      ..cubicTo(45, 132, 34, 120, 37, 105)
      ..cubicTo(26, 94, 29, 77, 39, 67)
      ..cubicTo(36, 58, 41, 52, 50, 49)
      ..close();

    canvas.drawPath(body, _fill..color = _sage);
    canvas.drawPath(body, outline);

    final belly = Path()
      ..moveTo(55, 100)
      ..cubicTo(66, 94, 101, 94, 114, 102)
      ..cubicTo(123, 108, 118, 124, 106, 128)
      ..cubicTo(92, 133, 69, 130, 58, 124)
      ..cubicTo(49, 119, 47, 106, 55, 100)
      ..close();
    canvas.drawPath(belly, _fill..color = _cream);
    canvas.drawPath(
      belly,
      _detailStroke
        ..color = _forest
        ..strokeWidth = 2.2,
    );
  }

  void _drawFace(Canvas canvas) {
    final eyePaint = Paint()..color = _forest;
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(63, 70), width: 9, height: 12),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(99, 68), width: 8, height: 11),
      eyePaint,
    );
    canvas.drawCircle(const Offset(64, 68), 1.7, _fill..color = _cream);
    canvas.drawCircle(const Offset(100, 66), 1.5, _fill..color = _cream);

    final muzzle = Path()
      ..moveTo(68, 79)
      ..cubicTo(73, 74, 85, 74, 91, 79)
      ..cubicTo(96, 83, 91, 91, 82, 92)
      ..cubicTo(73, 92, 65, 86, 68, 79)
      ..close();
    canvas.drawPath(muzzle, _fill..color = _cream);
    canvas.drawCircle(const Offset(80, 81), 2.1, _fill..color = _forest);

    final smile = Path()
      ..moveTo(76, 86)
      ..cubicTo(80, 90, 85, 90, 88, 85);
    canvas.drawPath(
      smile,
      _detailStroke
        ..color = _forest
        ..strokeWidth = 2,
    );

    final cheekPaint = Paint()..color = _orange.withValues(alpha: 0.75);
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(52, 84), width: 9, height: 5),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(111, 82), width: 9, height: 5),
      cheekPaint,
    );
  }

  void _drawCodeMark(Canvas canvas) {
    final code = _detailStroke
      ..color = _forest
      ..strokeWidth = 2.8;
    canvas.drawPath(
      Path()
        ..moveTo(75, 107)
        ..lineTo(69, 112)
        ..lineTo(75, 117),
      code,
    );
    canvas.drawLine(const Offset(84, 106), const Offset(80, 118), code);
    canvas.drawPath(
      Path()
        ..moveTo(89, 107)
        ..lineTo(95, 112)
        ..lineTo(89, 117),
      code,
    );
  }

  void _drawSketchAccents(Canvas canvas) {
    final sketch = _detailStroke
      ..color = _forest.withValues(alpha: 0.45)
      ..strokeWidth = 1.2;
    canvas.drawPath(
      Path()
        ..moveTo(43, 57)
        ..cubicTo(40, 60, 39, 63, 39, 66),
      sketch,
    );
    canvas.drawPath(
      Path()
        ..moveTo(127, 57)
        ..cubicTo(131, 61, 132, 65, 131, 68),
      sketch,
    );
    canvas.drawLine(const Offset(67, 126), const Offset(71, 127), sketch);
  }

  @override
  bool shouldRepaint(covariant _CodifyMascotPainter oldDelegate) => false;
}
