import 'package:aplikasi_pertama/data/learning_store.dart';
import 'package:aplikasi_pertama/main.dart';
import 'package:aplikasi_pertama/screens/dashboard_screen.dart';
import 'package:aplikasi_pertama/screens/diagnostic_question_screen.dart';
import 'package:aplikasi_pertama/screens/diagnostic_result_screen.dart';
import 'package:aplikasi_pertama/screens/history_screen.dart';
import 'package:aplikasi_pertama/screens/material_detail_screen.dart';
import 'package:aplikasi_pertama/screens/material_practice_screen.dart';
import 'package:aplikasi_pertama/screens/material_screen.dart';
import 'package:aplikasi_pertama/screens/progress_screen.dart';
import 'package:aplikasi_pertama/widgets/codify_mascot.dart';
import 'package:aplikasi_pertama/widgets/codify_progress_map.dart';
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
    await tester.pumpWidget(
      const CodifyApp(key: ValueKey('reopened-after-completion')),
    );
    await tester.pumpAndSettle();

    expect(find.text('CODIFY'), findsOneWidget);
    expect(find.text('Mulai Tes'), findsOneWidget);
    expect(find.byType(CodifyMascot), findsWidgets);
    expect(find.text('Hai, Sobat CODIFY!'), findsOneWidget);
    expect(find.text('Siap belajar coding hari ini?'), findsOneWidget);

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

  testWidgets('material search filters locally and keeps detail navigation', (
    tester,
  ) async {
    final materialCount = MaterialScreen.allMaterials.length;

    await tester.pumpWidget(const MaterialApp(home: MaterialScreen()));
    await tester.pumpAndSettle();

    final searchField = find.byKey(const ValueKey('material-search-field'));
    expect(find.text('Algoritma & Flowchart'), findsOneWidget);
    expect(find.text('Studi Kasus Pemrograman'), findsOneWidget);

    await tester.enterText(searchField, 'FLOWCHART');
    await tester.pumpAndSettle();
    expect(find.text('Algoritma & Flowchart'), findsOneWidget);
    expect(find.text('Variabel & Tipe Data'), findsNothing);

    await tester.enterText(searchField, 'diagram alir');
    await tester.pumpAndSettle();
    expect(find.text('Algoritma & Flowchart'), findsOneWidget);

    await tester.enterText(searchField, 'tidak ada materi');
    await tester.pumpAndSettle();
    expect(find.text('Materi tidak ditemukan'), findsOneWidget);

    await tester.tap(find.byTooltip('Hapus pencarian'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(searchField).controller!.text, isEmpty);
    expect(find.text('Materi tidak ditemukan'), findsNothing);
    expect(find.text('Studi Kasus Pemrograman'), findsOneWidget);

    await tester.enterText(searchField, 'operator');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Operator'));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialDetailScreen), findsOneWidget);
    expect(find.text('Materi 03'), findsOneWidget);
    expect(MaterialScreen.allMaterials, hasLength(materialCount));
  });

  testWidgets('material cards show status and practice progress', (
    tester,
  ) async {
    await LearningStore.savePracticeResult(
      materialNumber: '01',
      materialTitle: 'Algoritma & Flowchart',
      score: 60,
      correctAnswers: 3,
      totalQuestions: 5,
    );
    await LearningStore.markMaterialCompleted('02');

    await tester.pumpWidget(const MaterialApp(home: MaterialScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Sedang dipelajari'), findsOneWidget);
    expect(find.text('Selesai dipelajari'), findsOneWidget);
    expect(find.text('Belum dimulai'), findsNWidgets(10));

    final progressValues = tester
        .widgetList<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        )
        .map((indicator) => indicator.value!)
        .toList();
    expect(progressValues, hasLength(12));
    expect(progressValues[0], closeTo(0.6, 0.0001));
    expect(progressValues[1], 1);
    expect(progressValues.skip(2), everyElement(0));
  });

  testWidgets('material completion persists and updates the list card', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MaterialScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Algoritma & Flowchart').first);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Tandai Materi Selesai'));
    await tester.tap(find.text('Tandai Materi Selesai'));
    await tester.pumpAndSettle();

    expect(find.text('Materi sudah ditandai selesai'), findsOneWidget);
    expect(await LearningStore.getCompletedMaterials(), {'01'});

    await LearningStore.markMaterialCompleted('01');
    expect(await LearningStore.getCompletedMaterials(), {'01'});

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Selesai dipelajari'), findsOneWidget);

    await tester.tap(find.text('Algoritma & Flowchart').first);
    await tester.pumpAndSettle();
    expect(find.text('Materi sudah ditandai selesai'), findsOneWidget);

    await tester.pumpWidget(
      const CodifyApp(key: ValueKey('reopened-after-cancellation')),
    );
    await tester.pumpAndSettle();
    expect(find.text('8%'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Selesai dipelajari'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.bar_chart_rounded));
    await tester.pumpAndSettle();
    expect(find.text('1 dari 12'), findsOneWidget);
    expect(
      tester
          .widget<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator).first,
          )
          .value,
      closeTo(1 / 12, 0.0001),
    );

    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Algoritma & Flowchart').first);
    await tester.pumpAndSettle();
    expect(find.text('Materi sudah ditandai selesai'), findsOneWidget);

    await tester.ensureVisible(find.text('Batalkan Status Selesai'));
    await tester.tap(find.text('Batalkan Status Selesai'));
    await tester.pumpAndSettle();
    expect(find.text('Tandai Materi Selesai'), findsOneWidget);
    expect(await LearningStore.getCompletedMaterials(), isEmpty);

    await tester.pumpWidget(const CodifyApp());
    await tester.pumpAndSettle();
    expect(find.text('0%'), findsOneWidget);
    expect(
      tester.widget<CodifyProgressMap>(find.byType(CodifyProgressMap)).progress,
      0,
    );
    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Selesai dipelajari'), findsNothing);
    await tester.tap(find.byIcon(Icons.bar_chart_rounded));
    await tester.pumpAndSettle();
    expect(find.text('0 dari 12'), findsOneWidget);
    expect(
      tester
          .widget<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator).first,
          )
          .value,
      0,
    );
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
    await LearningStore.markMaterialCompleted('01');
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
    expect(find.text('1 dari 12'), findsOneWidget);
    expect(find.text('8% progres belajar'), findsOneWidget);
    expect(find.text('11 materi belum selesai'), findsOneWidget);
    expect(find.text('Peta kompetensi'), findsOneWidget);
    expect(find.text('Pahami kekuatan dan fokus belajarmu'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('competency-node-Operator')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<LinearProgressIndicator>(
            find.byType(LinearProgressIndicator).first,
          )
          .value,
      closeTo(1 / 12, 0.0001),
    );
    expect(find.text('1'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('learning-roadmap')),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const ValueKey('learning-roadmap')), findsOneWidget);
    for (final topic in ['Operator', 'Percabangan', 'Perulangan']) {
      expect(
        find.descendant(
          of: find.byKey(ValueKey('competency-node-$topic')),
          matching: find.text('0'),
        ),
        findsOneWidget,
      );
    }
    await tester.scrollUntilVisible(
      find.text('Langkah pertama'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Langkah pertama'), findsOneWidget);
    expect(find.text('Didapat'), findsOneWidget);
    expect(find.text('Belum terbuka'), findsNWidgets(2));
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('progress-recommendation-tile')),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('progress-recommendation-tile')),
        matching: find.text('Operator'),
      ),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Lihat Riwayat Belajar'));
    await tester.tap(find.text('Lihat Riwayat Belajar'));
    await tester.pumpAndSettle();
    expect(find.byType(HistoryScreen), findsOneWidget);
    expect(find.text('Tes Diagnostik'), findsOneWidget);
    expect(find.text('Latihan Algoritma & Flowchart'), findsOneWidget);
  });

  testWidgets('learning map reflects stored progress and opens a lesson', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 1300);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await LearningStore.markMaterialCompleted('01');
    await LearningStore.savePracticeResult(
      materialNumber: '02',
      materialTitle: 'Variabel & Tipe Data',
      score: 60,
      correctAnswers: 3,
      totalQuestions: 5,
    );

    await tester.pumpWidget(const MaterialApp(home: ProgressScreen()));
    await tester.pumpAndSettle();

    final completedNode = find.descendant(
      of: find.byKey(const ValueKey('progress-map-node-01')),
      matching: find.text('Selesai'),
    );
    final practicedNode = find.descendant(
      of: find.byKey(const ValueKey('progress-map-node-02')),
      matching: find.text('Sudah latihan'),
    );
    expect(completedNode, findsOneWidget);
    expect(practicedNode, findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('progress-map-tap-02')));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialDetailScreen), findsOneWidget);
    expect(find.text('Variabel & Tipe Data'), findsOneWidget);
  });

  testWidgets('progress achievements unlock at completed-material milestones', (
    tester,
  ) async {
    for (final number in ['01', '02', '03', '04']) {
      await LearningStore.markMaterialCompleted(number);
    }

    await tester.pumpWidget(
      const MaterialApp(home: ProgressScreen(key: ValueKey('four-complete'))),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Langkah pertama'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Didapat'), findsOneWidget);
    expect(find.text('Belum terbuka'), findsNWidgets(2));

    await LearningStore.markMaterialCompleted('05');
    await tester.pumpWidget(
      const MaterialApp(home: ProgressScreen(key: ValueKey('five-complete'))),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Langkah pertama'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Didapat'), findsNWidgets(2));
    expect(find.text('Belum terbuka'), findsOneWidget);

    for (final number in ['06', '07', '08', '09', '10', '11', '12']) {
      await LearningStore.markMaterialCompleted(number);
    }
    await tester.pumpWidget(
      const MaterialApp(home: ProgressScreen(key: ValueKey('all-complete'))),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Langkah pertama'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Didapat'), findsNWidgets(3));
    expect(find.text('Belum terbuka'), findsNothing);
  });

  testWidgets('progress dashboard fits a narrow screen', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ProgressScreen()));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard progress updates after completing a material', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Algoritma & Flowchart').first);
    await tester.tap(find.text('Algoritma & Flowchart').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Tandai Materi Selesai'));
    await tester.tap(find.text('Tandai Materi Selesai'));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('8%'), findsOneWidget);
    expect(
      find.text('1 dari 12 materi selesai. Ketuk untuk melihat progres.'),
      findsOneWidget,
    );
    expect(
      tester.widget<CodifyProgressMap>(find.byType(CodifyProgressMap)).progress,
      closeTo(1 / 12, 0.0001),
    );

    final progressMap = find.byKey(const ValueKey('home-progress-scroll'));
    await tester.ensureVisible(progressMap);
    final scrollableMap = find.descendant(
      of: progressMap,
      matching: find.byType(Scrollable),
    );
    final scrollState = tester.state<ScrollableState>(scrollableMap);
    await tester.drag(progressMap, const Offset(-220, 0));
    await tester.pumpAndSettle();
    expect(scrollState.position.pixels, greaterThan(0));
    scrollState.position.jumpTo(0);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('home-progress-mascot')));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialDetailScreen), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(MaterialDetailScreen),
        matching: find.text('Algoritma & Flowchart'),
      ),
      findsOneWidget,
    );
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

  test('diagnostic, practice, and completion persist locally', () async {
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
    final diagnosticHistory = await LearningStore.getDiagnosticHistory();
    final practiceHistory = await LearningStore.getPracticeHistory();
    final completedMaterials = await LearningStore.getCompletedMaterials();
    expect(diagnosticHistory.single['overallScore'], 80);
    expect(practiceHistory.single['score'], 100);
    expect(completedMaterials, contains('03'));
  });
}
