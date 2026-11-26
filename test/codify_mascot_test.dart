import 'package:aplikasi_pertama/widgets/codify_mascot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Codify mascot paints cleanly at different sizes', (
    tester,
  ) async {
    for (final size in [48.0, 180.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(child: CodifyMascot(size: size)),
        ),
      );

      expect(tester.getSize(find.byType(CodifyMascot)), Size(size, size));
      expect(tester.takeException(), isNull);
    }
  });
}
