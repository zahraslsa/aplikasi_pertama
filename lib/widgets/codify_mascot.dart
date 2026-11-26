import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CodifyMascot extends StatelessWidget {
  final double size;

  const CodifyMascot({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Maskot Codify, kura-kura kecil belajar coding',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _CodifyMascotPainter()),
      ),
    );
  }
}

class _CodifyMascotPainter extends CustomPainter {
  static const _outline = AppColors.textPrimary;
  static const _shell = AppColors.success;
  static const _shellLight = Color(0xFF75C49D);
  static const _cream = Color(0xFFFFF3D8);
  static const _cheek = Color(0xFFF29B75);
  static const _pencil = AppColors.warning;

  final Paint _fill = Paint()..style = PaintingStyle.fill;
  final Paint _stroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 3.2;

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
      ..color = _outline;

    _drawPencil(canvas, outline);
    _drawTail(canvas, outline);
    _drawFeet(canvas, outline);
    _drawShell(canvas, outline);
    _drawHead(canvas, outline);
    _drawFace(canvas);
    _drawShellCode(canvas);

    canvas.restore();
  }

  void _drawPencil(Canvas canvas, Paint outline) {
    final pencil = Path()
      ..moveTo(37, 51)
      ..lineTo(27, 24)
      ..quadraticBezierTo(26, 21, 29, 22)
      ..lineTo(38, 27)
      ..lineTo(47, 49)
      ..close();
    canvas.drawPath(pencil, _fill..color = _pencil);
    canvas.drawPath(pencil, outline);
    canvas.drawLine(const Offset(29, 27), const Offset(39, 48), outline);
    canvas.drawPath(
      Path()
        ..moveTo(27, 24)
        ..lineTo(25, 16)
        ..lineTo(31, 22),
      outline,
    );
    canvas.drawLine(const Offset(31, 35), const Offset(35, 33), outline);
  }

  void _drawTail(Canvas canvas, Paint outline) {
    final tail = Path()
      ..moveTo(42, 105)
      ..quadraticBezierTo(20, 100, 17, 114)
      ..quadraticBezierTo(26, 124, 44, 115);
    canvas.drawPath(tail, _stroke..color = _shell);
    canvas.drawPath(tail, outline);
  }

  void _drawFeet(Canvas canvas, Paint outline) {
    final leftFoot = Path()
      ..moveTo(52, 119)
      ..quadraticBezierTo(48, 132, 43, 139)
      ..quadraticBezierTo(41, 145, 51, 145)
      ..lineTo(66, 144)
      ..quadraticBezierTo(70, 141, 65, 137)
      ..lineTo(65, 120)
      ..close();
    final rightFoot = Path()
      ..moveTo(91, 119)
      ..lineTo(91, 137)
      ..quadraticBezierTo(87, 141, 91, 144)
      ..lineTo(108, 145)
      ..quadraticBezierTo(117, 143, 111, 138)
      ..lineTo(103, 119)
      ..close();
    for (final foot in [leftFoot, rightFoot]) {
      canvas.drawPath(foot, _fill..color = _shellLight);
      canvas.drawPath(foot, outline);
    }
  }

  void _drawShell(Canvas canvas, Paint outline) {
    final shell = Path()
      ..moveTo(41, 87)
      ..quadraticBezierTo(44, 68, 66, 67)
      ..lineTo(94, 70)
      ..quadraticBezierTo(111, 77, 108, 102)
      ..quadraticBezierTo(104, 120, 83, 124)
      ..lineTo(53, 121)
      ..quadraticBezierTo(36, 114, 41, 87)
      ..close();
    canvas.drawPath(shell, _fill..color = _shell);
    canvas.drawPath(shell, outline);

    final panel = Path()
      ..moveTo(47, 88)
      ..quadraticBezierTo(68, 75, 96, 83)
      ..quadraticBezierTo(103, 91, 96, 108)
      ..quadraticBezierTo(73, 117, 48, 105)
      ..quadraticBezierTo(44, 97, 47, 88)
      ..close();
    canvas.drawPath(panel, _stroke..color = _shellLight);
    canvas.drawPath(panel, outline);
    canvas.drawLine(const Offset(70, 81), const Offset(68, 112), outline);
    canvas.drawLine(const Offset(48, 95), const Offset(98, 97), outline);
  }

  void _drawHead(Canvas canvas, Paint outline) {
    final head = Path()
      ..moveTo(83, 58)
      ..quadraticBezierTo(84, 37, 105, 34)
      ..quadraticBezierTo(129, 31, 140, 50)
      ..quadraticBezierTo(151, 68, 139, 85)
      ..quadraticBezierTo(130, 99, 110, 93)
      ..lineTo(92, 82)
      ..quadraticBezierTo(81, 75, 83, 58)
      ..close();
    canvas.drawPath(head, _fill..color = _cream);
    canvas.drawPath(head, outline);

    final fringe = Path()
      ..moveTo(91, 44)
      ..quadraticBezierTo(105, 29, 122, 39)
      ..quadraticBezierTo(112, 40, 108, 47)
      ..quadraticBezierTo(103, 42, 97, 49);
    canvas.drawPath(fringe, _stroke..color = _shell);
    canvas.drawPath(fringe, outline);
  }

  void _drawFace(Canvas canvas) {
    canvas.drawCircle(const Offset(109, 61), 3.4, _fill..color = _outline);
    canvas.drawCircle(const Offset(132, 60), 3.4, _fill..color = _outline);
    canvas.drawCircle(const Offset(110, 60), 0.9, _fill..color = Colors.white);
    canvas.drawCircle(const Offset(133, 59), 0.9, _fill..color = Colors.white);
    canvas.drawCircle(const Offset(100, 72), 4, _fill..color = _cheek);
    canvas.drawCircle(const Offset(137, 71), 4, _fill..color = _cheek);

    final smile = Path()
      ..moveTo(116, 72)
      ..quadraticBezierTo(123, 80, 131, 71);
    final smilePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.4
      ..color = _outline;
    canvas.drawPath(smile, smilePaint);
  }

  void _drawShellCode(Canvas canvas) {
    final code = _stroke
      ..color = _cream
      ..strokeWidth = 3.4;
    canvas.drawPath(
      Path()
        ..moveTo(61, 91)
        ..lineTo(54, 97)
        ..lineTo(61, 103),
      code,
    );
    canvas.drawLine(const Offset(74, 90), const Offset(68, 104), code);
    canvas.drawPath(
      Path()
        ..moveTo(80, 91)
        ..lineTo(87, 97)
        ..lineTo(80, 103),
      code,
    );
  }

  @override
  bool shouldRepaint(covariant _CodifyMascotPainter oldDelegate) => false;
}
