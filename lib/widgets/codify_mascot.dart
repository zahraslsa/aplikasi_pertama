import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum CodifyCharacter { codi, zippy, byte, pip }

extension CodifyCharacterLabel on CodifyCharacter {
  String get label => switch (this) {
    CodifyCharacter.codi => 'Codi si tunas coding',
    CodifyCharacter.zippy => 'Zippy si rubah lincah',
    CodifyCharacter.byte => 'Byte si burung hantu pintar',
    CodifyCharacter.pip => 'Pip si robot ceria',
  };

  String get shortName => switch (this) {
    CodifyCharacter.codi => 'Codi',
    CodifyCharacter.zippy => 'Zippy',
    CodifyCharacter.byte => 'Byte',
    CodifyCharacter.pip => 'Pip',
  };
}

CodifyCharacter codifyCharacterFor(int number) =>
    CodifyCharacter.values[(number.abs() - 1) % CodifyCharacter.values.length];

class CodifyMascot extends StatelessWidget {
  final double size;
  final CodifyCharacter character;

  const CodifyMascot({
    super.key,
    this.size = 96,
    this.character = CodifyCharacter.codi,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Maskot ${character.label}, teman belajar CODIFY',
      image: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _CodifyMascotPainter(character)),
      ),
    );
  }
}

class _CodifyMascotPainter extends CustomPainter {
  final CodifyCharacter character;

  _CodifyMascotPainter(this.character);

  Color get _bodyColor => switch (character) {
    CodifyCharacter.codi => AppColors.dustyBlue,
    CodifyCharacter.zippy => AppColors.peach,
    CodifyCharacter.byte => AppColors.softLilac,
    CodifyCharacter.pip => AppColors.butterYellow,
  };

  Color get _shadowColor =>
      Color.lerp(_bodyColor, AppColors.primaryDark, 0.26)!;

  final Paint _fill = Paint()..style = PaintingStyle.fill;
  final Paint _stroke = Paint()
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
      ..strokeWidth = 3.4
      ..color = AppColors.primaryDark;

    canvas.drawOval(
      const Rect.fromLTRB(37, 132, 124, 147),
      Paint()..color = AppColors.primaryDark.withValues(alpha: 0.12),
    );
    _drawTail(canvas, outline);
    _drawHeadwear(canvas, outline);
    _drawFeet(canvas, outline);
    _drawArms(canvas, outline);
    _drawBody(canvas, outline);
    _drawFace(canvas);
    _drawCodeBadge(canvas);
    _drawCharacterDetails(canvas);

    canvas.restore();
  }

  void _drawTail(Canvas canvas, Paint outline) {
    final tail = switch (character) {
      CodifyCharacter.codi =>
        Path()
          ..moveTo(43, 101)
          ..cubicTo(28, 93, 16, 101, 20, 114)
          ..cubicTo(24, 127, 40, 126, 48, 114)
          ..cubicTo(52, 109, 49, 103, 43, 101)
          ..close(),
      CodifyCharacter.zippy =>
        Path()
          ..moveTo(115, 103)
          ..cubicTo(131, 99, 144, 87, 142, 76)
          ..cubicTo(140, 66, 130, 67, 128, 78)
          ..cubicTo(126, 87, 119, 91, 111, 91)
          ..close(),
      CodifyCharacter.byte =>
        Path()
          ..moveTo(45, 104)
          ..cubicTo(30, 100, 24, 110, 31, 121)
          ..cubicTo(37, 128, 45, 124, 50, 116)
          ..close(),
      CodifyCharacter.pip =>
        Path()
          ..moveTo(42, 99)
          ..cubicTo(29, 97, 23, 107, 29, 117)
          ..cubicTo(35, 124, 43, 120, 48, 111)
          ..close(),
    };
    canvas.drawPath(tail, _fill..color = _shadowColor);
    canvas.drawPath(tail, outline);

    if (character == CodifyCharacter.codi) {
      canvas.drawPath(
        Path()
          ..moveTo(31, 109)
          ..cubicTo(32, 102, 41, 102, 43, 108)
          ..cubicTo(44, 113, 39, 117, 35, 115),
        _stroke
          ..color = AppColors.softWhite
          ..strokeWidth = 2.3,
      );
    } else if (character == CodifyCharacter.zippy) {
      final tip = Path()
        ..moveTo(128, 77)
        ..cubicTo(133, 72, 138, 75, 137, 81)
        ..cubicTo(136, 86, 132, 90, 127, 92)
        ..cubicTo(130, 86, 130, 82, 128, 77)
        ..close();
      canvas.drawPath(tip, _fill..color = AppColors.softWhite);
    }
  }

  void _drawHeadwear(Canvas canvas, Paint outline) {
    if (character == CodifyCharacter.codi) {
      final leftLeaf = Path()
        ..moveTo(76, 44)
        ..cubicTo(66, 35, 54, 25, 59, 15)
        ..cubicTo(72, 13, 82, 26, 84, 39)
        ..close();
      final rightLeaf = Path()
        ..moveTo(84, 41)
        ..cubicTo(86, 27, 97, 16, 109, 19)
        ..cubicTo(111, 31, 101, 40, 91, 46)
        ..close();
      _outlined(canvas, leftLeaf, AppColors.skyBlue, outline);
      _outlined(canvas, rightLeaf, AppColors.dustyBlue, outline);
      canvas.drawPath(
        Path()
          ..moveTo(80, 39)
          ..cubicTo(74, 30, 68, 24, 63, 20),
        _stroke
          ..color = AppColors.primaryDark.withValues(alpha: 0.55)
          ..strokeWidth = 1.8,
      );
      canvas.drawPath(
        Path()
          ..moveTo(87, 41)
          ..cubicTo(93, 32, 101, 25, 107, 22),
        _stroke
          ..color = AppColors.primaryDark.withValues(alpha: 0.55)
          ..strokeWidth = 1.8,
      );
      return;
    }

    if (character == CodifyCharacter.zippy) {
      final leftEar = Path()
        ..moveTo(48, 58)
        ..lineTo(44, 18)
        ..cubicTo(57, 20, 68, 29, 75, 43)
        ..close();
      final rightEar = Path()
        ..moveTo(100, 43)
        ..cubicTo(106, 29, 119, 21, 130, 22)
        ..lineTo(125, 61)
        ..close();
      _outlined(canvas, leftEar, _bodyColor, outline);
      _outlined(canvas, rightEar, _bodyColor, outline);
      for (final inner in [
        Path()
          ..moveTo(53, 48)
          ..lineTo(51, 30)
          ..cubicTo(59, 33, 64, 38, 67, 45)
          ..close(),
        Path()
          ..moveTo(107, 45)
          ..cubicTo(111, 38, 117, 33, 123, 31)
          ..lineTo(121, 49)
          ..close(),
      ]) {
        canvas.drawPath(inner, _fill..color = AppColors.butterYellow);
      }
      return;
    }

    if (character == CodifyCharacter.byte) {
      final leftTuft = Path()
        ..moveTo(54, 50)
        ..cubicTo(49, 34, 56, 23, 69, 19)
        ..cubicTo(72, 31, 75, 39, 82, 43)
        ..close();
      final rightTuft = Path()
        ..moveTo(83, 43)
        ..cubicTo(91, 38, 97, 29, 99, 18)
        ..cubicTo(114, 23, 119, 36, 112, 51)
        ..close();
      _outlined(canvas, leftTuft, AppColors.softLilac, outline);
      _outlined(canvas, rightTuft, AppColors.softLilac, outline);
      return;
    }

    canvas.drawLine(
      const Offset(81, 45),
      const Offset(82, 25),
      _stroke
        ..color = AppColors.primaryDark
        ..strokeWidth = 4,
    );
    canvas.drawCircle(const Offset(82, 22), 8, _fill..color = AppColors.peach);
    canvas.drawCircle(const Offset(82, 22), 8, outline);
    canvas.drawCircle(const Offset(40, 72), 10, _fill..color = AppColors.peach);
    canvas.drawCircle(const Offset(40, 72), 10, outline);
    canvas.drawCircle(
      const Offset(126, 72),
      10,
      _fill..color = AppColors.peach,
    );
    canvas.drawCircle(const Offset(126, 72), 10, outline);
  }

  void _drawFeet(Canvas canvas, Paint outline) {
    for (final foot in [
      Path()
        ..moveTo(59, 118)
        ..cubicTo(57, 128, 50, 134, 52, 138)
        ..cubicTo(55, 143, 68, 141, 74, 137)
        ..cubicTo(77, 134, 72, 128, 74, 120)
        ..close(),
      Path()
        ..moveTo(96, 120)
        ..cubicTo(97, 129, 93, 134, 97, 138)
        ..cubicTo(102, 143, 115, 141, 117, 136)
        ..cubicTo(118, 132, 109, 128, 109, 119)
        ..close(),
    ]) {
      canvas.drawPath(foot, _fill..color = _shadowColor);
      canvas.drawPath(foot, outline);
      canvas.drawLine(
        Offset(foot.getBounds().center.dx - 2, 136),
        Offset(foot.getBounds().center.dx + 3, 136),
        _stroke
          ..color = AppColors.softWhite.withValues(alpha: 0.7)
          ..strokeWidth = 1.5,
      );
    }
  }

  void _drawArms(Canvas canvas, Paint outline) {
    final leftArm = Path()
      ..moveTo(42, 76)
      ..cubicTo(32, 74, 25, 79, 27, 87)
      ..cubicTo(29, 94, 37, 94, 45, 87);
    final rightArm = Path()
      ..moveTo(119, 76)
      ..cubicTo(130, 74, 138, 79, 136, 87)
      ..cubicTo(134, 94, 126, 94, 118, 87);

    for (final arm in [leftArm, rightArm]) {
      canvas.drawPath(
        arm,
        _stroke
          ..color = _shadowColor
          ..strokeWidth = character == CodifyCharacter.byte ? 13 : 11,
      );
      canvas.drawPath(arm, outline);
    }
    if (character == CodifyCharacter.byte) {
      canvas.drawLine(
        const Offset(32, 83),
        const Offset(38, 86),
        _stroke
          ..color = AppColors.softWhite
          ..strokeWidth = 1.8,
      );
      canvas.drawLine(
        const Offset(135, 83),
        const Offset(129, 86),
        _stroke
          ..color = AppColors.softWhite
          ..strokeWidth = 1.8,
      );
    }
  }

  void _drawBody(Canvas canvas, Paint outline) {
    final body = Path()
      ..moveTo(49, 49)
      ..cubicTo(56, 39, 69, 36, 80, 42)
      ..cubicTo(92, 34, 106, 38, 113, 47)
      ..cubicTo(127, 44, 138, 55, 136, 70)
      ..cubicTo(146, 81, 142, 97, 131, 106)
      ..cubicTo(136, 120, 122, 132, 106, 132)
      ..cubicTo(91, 142, 71, 139, 61, 130)
      ..cubicTo(45, 132, 34, 120, 37, 105)
      ..cubicTo(26, 94, 29, 77, 39, 67)
      ..cubicTo(36, 58, 41, 52, 49, 49)
      ..close();

    canvas.drawPath(body, _fill..color = _bodyColor);
    canvas.drawPath(body, outline);
    canvas.drawPath(
      Path()
        ..moveTo(49, 68)
        ..cubicTo(51, 58, 59, 53, 67, 52),
      Paint()
        ..color = AppColors.softWhite.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2
        ..strokeCap = StrokeCap.round,
    );

    final belly = Path()
      ..moveTo(54, 99)
      ..cubicTo(66, 92, 102, 92, 116, 100)
      ..cubicTo(126, 107, 120, 124, 106, 129)
      ..cubicTo(91, 135, 69, 131, 57, 124)
      ..cubicTo(47, 118, 47, 105, 54, 99)
      ..close();
    canvas.drawPath(belly, _fill..color = AppColors.softWhite);
    canvas.drawPath(
      belly,
      _stroke
        ..color = AppColors.primaryDark
        ..strokeWidth = 2.2,
    );
  }

  void _drawFace(Canvas canvas) {
    final eyeSize = character == CodifyCharacter.byte
        ? const Size(19, 23)
        : character == CodifyCharacter.pip
        ? const Size(13, 16)
        : const Size(15, 19);
    final pupilRadius = character == CodifyCharacter.byte ? 5.2 : 4.1;
    for (final center in [const Offset(63, 70), const Offset(101, 69)]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: eyeSize.width,
          height: eyeSize.height,
        ),
        _fill..color = AppColors.softWhite,
      );
      final pupil = Offset(center.dx + 1.4, center.dy + 1.5);
      canvas.drawCircle(
        pupil,
        pupilRadius,
        _fill..color = AppColors.primaryDark,
      );
      canvas.drawCircle(
        Offset(pupil.dx - 1.2, pupil.dy - 1.8),
        1.7,
        _fill..color = AppColors.softWhite,
      );
    }

    final muzzle = Path()
      ..moveTo(69, 82)
      ..cubicTo(74, 76, 88, 76, 94, 82)
      ..cubicTo(98, 87, 92, 94, 81, 94)
      ..cubicTo(71, 94, 65, 88, 69, 82)
      ..close();
    canvas.drawPath(muzzle, _fill..color = AppColors.softWhite);
    canvas.drawCircle(
      const Offset(81, 83),
      2.1,
      _fill..color = AppColors.primaryDark,
    );
    canvas.drawPath(
      Path()
        ..moveTo(77, 88)
        ..cubicTo(81, 93, 86, 92, 89, 87),
      _stroke
        ..color = AppColors.primaryDark
        ..strokeWidth = 2,
    );

    final cheekColor = character == CodifyCharacter.zippy
        ? AppColors.butterYellow
        : AppColors.dustyRose;
    for (final center in [const Offset(51, 86), const Offset(112, 84)]) {
      canvas.drawOval(
        Rect.fromCenter(center: center, width: 11, height: 6),
        _fill..color = cheekColor.withValues(alpha: 0.85),
      );
    }
  }

  void _drawCodeBadge(Canvas canvas) {
    final code = _stroke
      ..color = AppColors.primaryDark
      ..strokeWidth = 2.8;
    canvas.drawPath(
      Path()
        ..moveTo(75, 108)
        ..lineTo(69, 113)
        ..lineTo(75, 118),
      code,
    );
    canvas.drawLine(const Offset(84, 107), const Offset(80, 119), code);
    canvas.drawPath(
      Path()
        ..moveTo(89, 108)
        ..lineTo(95, 113)
        ..lineTo(89, 118),
      code,
    );
    if (character == CodifyCharacter.pip) {
      canvas.drawCircle(
        const Offset(104, 110),
        2.4,
        _fill..color = AppColors.peach,
      );
    }
  }

  void _drawCharacterDetails(Canvas canvas) {
    if (character == CodifyCharacter.byte) {
      for (final x in [70.0, 80.0, 90.0]) {
        canvas.drawPath(
          Path()
            ..moveTo(x, 42)
            ..lineTo(x - 3, 48)
            ..lineTo(x + 2, 47),
          _stroke
            ..color = AppColors.dustyRose
            ..strokeWidth = 1.8,
        );
      }
    }
    if (character == CodifyCharacter.pip) {
      for (final center in [
        const Offset(68, 126),
        const Offset(81, 128),
        const Offset(94, 126),
      ]) {
        canvas.drawCircle(center, 2.1, _fill..color = AppColors.peach);
      }
    }
    canvas.drawCircle(
      const Offset(125, 60),
      2.8,
      _fill..color = AppColors.softWhite.withValues(alpha: 0.8),
    );
    canvas.drawCircle(
      const Offset(40, 60),
      2,
      _fill..color = AppColors.softWhite.withValues(alpha: 0.8),
    );
  }

  void _outlined(Canvas canvas, Path path, Color color, Paint outline) {
    canvas.drawPath(path, _fill..color = color);
    canvas.drawPath(path, outline);
  }

  @override
  bool shouldRepaint(covariant _CodifyMascotPainter oldDelegate) =>
      oldDelegate.character != character;
}
