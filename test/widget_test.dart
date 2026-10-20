import 'package:aplikasi_pertama/data/learning_store.dart';
import 'package:aplikasi_pertama/main.dart';
import 'package:aplikasi_pertama/screens/diagnostic_question_screen.dart';
import 'package:aplikasi_pertama/screens/diagnostic_result_screen.dart';
import 'package:aplikasi_pertama/screens/history_screen.dart';
import 'package:aplikasi_pertama/screens/material_detail_screen.dart';
import 'package:aplikasi_pertama/screens/material_practice_screen.dart';
import 'package:aplikasi_pertama/screens/material_screen.dart';
import 'package:aplikasi_pertama/screens/profile_screen.dart';
import 'package:aplikasi_pertama/screens/progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('home connects to material list and interactive practice', (
    tester,
  ) async {
    await tester.pumpWidget(const CodifyApp());
    await tester.pumpAndSettle();

    expect(find.text('CODIFY'), findsOneWidget);
    expect(find.text('Mulai Tes'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Materi Pembelajaran'), findsOneWidget);

    await tester.tap(find.text('Algoritma & Flowchart').first);
    await tester.pumpAndSettle();
    expect(find.text('Pengantar Materi'), findsOneWidget);

    await tester.ensureVisible(find.text('Mulai Latihan Interaktif'));
    await tester.tap(find.text('Mulai Latihan Interaktif'));
    await tester.pumpAndSettle();
    expect(find.text('Soal 1 dari 2'), findsOneWidget);

    await tester.tap(find.text('Menyusun langkah penyelesaian masalah'));
    await tester.tap(find.text('Periksa Jawaban'));
    await tester.pumpAndSettle();
    expect(find.text('Jawaban benar!'), findsOneWidget);
    expect(
      find.text(
        'Algoritma menyusun langkah yang jelas dan berurutan untuk menyelesaikan masalah.',
      ),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Soal Berikutnya'));
    await tester.tap(find.text('Soal Berikutnya'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Belah ketupat'));
    await tester.tap(find.text('Periksa Jawaban'));
    await tester.pumpAndSettle();
    expect(find.text('Nilai latihan: 100/100'), findsOneWidget);

    await tester.ensureVisible(find.text('Simpan Hasil Latihan'));
    await tester.tap(find.text('Simpan Hasil Latihan'));
    await tester.pumpAndSettle();

    expect(find.text('Materi ditandai selesai.'), findsNothing);
    expect(find.text('Kembali ke Materi'), findsOneWidget);
    expect(await LearningStore.getCompletedMaterials(), contains('01'));
    expect(await LearningStore.getPracticeHistory(), hasLength(1));
  });

  testWidgets('diagnostic recommendation opens matching material', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DiagnosticResultScreen(
          overallScore: 60,
          topicScores: const {
            'Algoritma & Flowchart': 100,
            'Variabel & Tipe Data': 100,
            'Operator': 0,
            'Percabangan': 100,
            'Perulangan': 100,
          },
        ),
      ),
    );

    await tester.ensureVisible(find.text('Pelajari Operator'));
    await tester.tap(find.text('Pelajari Operator'));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialDetailScreen), findsOneWidget);
    expect(find.text('Materi 03'), findsOneWidget);
  });

  testWidgets('diagnostic saves results after all 25 questions', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: DiagnosticQuestionScreen()),
    );
    await tester.pumpAndSettle();

    for (var index = 0; index < 25; index++) {
      await tester.tap(find.text('A').first);
      await tester.tap(find.text(index == 24 ? 'Selesai' : 'Berikutnya'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Tes Diagnostik Selesai'), findsOneWidget);
    expect(await LearningStore.getDiagnosticHistory(), hasLength(1));
  });

  testWidgets('progress shows stored learning data and opens history', (
    tester,
  ) async {
    await LearningStore.saveDiagnosticResult(
      overallScore: 40,
      topicScores: const {
        'Algoritma & Flowchart': 100,
        'Variabel & Tipe Data': 100,
        'Operator': 0,
        'Percabangan': 0,
        'Perulangan': 0,
      },
    );
    await LearningStore.savePracticeResult(
      materialNumber: '01',
      materialTitle: 'Algoritma & Flowchart',
      score: 50,
      correctAnswers: 1,
      totalQuestions: 2,
    );

    await tester.pumpWidget(const MaterialApp(home: ProgressScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Operator'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.ensureVisible(find.text('Lihat Riwayat Belajar'));
    await tester.tap(find.text('Lihat Riwayat Belajar'));
    await tester.pumpAndSettle();
    expect(find.byType(HistoryScreen), findsOneWidget);
    expect(find.text('Tes Diagnostik'), findsOneWidget);
    expect(find.text('Latihan Algoritma & Flowchart'), findsOneWidget);
  });

  testWidgets('profile form saves learner information locally', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Zahra PPLG');
    await tester.tap(find.text('Simpan Profil'));
    await tester.pumpAndSettle();

    expect((await LearningStore.getProfile())['name'], 'Zahra PPLG');
    expect(find.text('Profil berhasil disimpan di perangkat.'), findsOneWidget);
  });

  test('all 12 materials provide valid interactive practice', () {
    expect(MaterialScreen.allMaterials, hasLength(12));
    expect(MaterialPracticeScreen.questionBank, hasLength(12));

    for (final material in MaterialScreen.allMaterials) {
      final questions = MaterialPracticeScreen.questionsFor(
        material['number'] as String,
      );
      expect(questions, isNotEmpty);
      for (final question in questions) {
        expect(
          question.answer,
          inInclusiveRange(0, question.options.length - 1),
        );
        expect(question.explanation, isNotEmpty);
      }
    }
  });

  test(
    'diagnostic, practice, completion, and profile persist locally',
    () async {
      await LearningStore.saveDiagnosticResult(
        overallScore: 80,
        topicScores: const {'Operator': 80},
      );
      await LearningStore.savePracticeResult(
        materialNumber: '03',
        materialTitle: 'Operator',
        score: 100,
        correctAnswers: 2,
        totalQuestions: 2,
      );
      await LearningStore.saveProfile({
        'name': 'Zahra',
        'username': 'zahra',
        'email': 'zahra@example.com',
        'class': 'X PPLG',
      });

      final diagnosticHistory = await LearningStore.getDiagnosticHistory();
      final practiceHistory = await LearningStore.getPracticeHistory();
      final completedMaterials = await LearningStore.getCompletedMaterials();
      final profile = await LearningStore.getProfile();

      expect(diagnosticHistory.single['overallScore'], 80);
      expect(practiceHistory.single['score'], 100);
      expect(completedMaterials, contains('03'));
      expect(profile['name'], 'Zahra');
    },
  );
}
