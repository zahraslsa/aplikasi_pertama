import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasi_pertama/main.dart';

void main() {
  testWidgets('CODIFY login page test', (WidgetTester tester) async {
    await tester.pumpWidget(const CodifyApp());

    expect(find.text('CODIFY'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}
