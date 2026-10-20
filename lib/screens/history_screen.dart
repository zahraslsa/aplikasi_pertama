import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import 'diagnostic_result_screen.dart';
import 'material_detail_screen.dart';
import 'material_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<_HistoryEntry>> _history;

  @override
  void initState() {
    super.initState();
    _history = _loadHistory();
  }

  Future<List<_HistoryEntry>> _loadHistory() async {
    final values = await Future.wait<Object>([
      LearningStore.getDiagnosticHistory(),
      LearningStore.getPracticeHistory(),
    ]);
    final diagnostics = values[0] as List<Map<String, dynamic>>;
    final practices = values[1] as List<Map<String, dynamic>>;

    final entries = <_HistoryEntry>[
      for (final result in diagnostics)
        _HistoryEntry(
          type: _HistoryType.diagnostic,
          title: 'Tes Diagnostik',
          subtitle: 'Nilai keseluruhan ${result['overallScore']}/100',
          score: result['overallScore'] as int,
          completedAt: DateTime.parse(result['completedAt'] as String),
          data: result,
        ),
      for (final result in practices)
        _HistoryEntry(
          type: _HistoryType.practice,
          title: 'Latihan ${result['materialTitle']}',
          subtitle:
              '${result['correctAnswers']} dari ${result['totalQuestions']} jawaban benar',
          score: result['score'] as int,
          completedAt: DateTime.parse(result['completedAt'] as String),
          data: result,
        ),
    ]..sort((a, b) => b.completedAt.compareTo(a.completedAt));

    return entries;
  }

  void _reload() {
    setState(() => _history = _loadHistory());
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year} • $hour:$minute';
  }

  void _openEntry(_HistoryEntry entry) {
    final Widget destination;
    if (entry.type == _HistoryType.diagnostic) {
      destination = DiagnosticResultScreen(
        topicScores: Map<String, int>.from(
          entry.data['topicScores'] as Map,
        ),
        overallScore: entry.score,
      );
    } else {
      destination = MaterialDetailScreen(
        material: MaterialScreen.materialForNumber(
          entry.data['materialNumber'] as String,
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Belajar'),
        actions: [
          IconButton(
            onPressed: _reload,
            tooltip: 'Muat ulang riwayat',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<_HistoryEntry>>(
        future: _history,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Riwayat gagal dimuat: ${snapshot.error}',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data!;
          if (entries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Text(
                  'Belum ada aktivitas belajar. Hasil tes dan latihan akan tersimpan di sini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final color = entry.score >= 80
                  ? AppColors.success
                  : entry.score >= 60
                  ? AppColors.warning
                  : AppColors.error;

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.12),
                    child: Icon(
                      entry.type == _HistoryType.diagnostic
                          ? Icons.fact_check_outlined
                          : Icons.quiz_outlined,
                      color: color,
                    ),
                  ),
                  title: Text(entry.title),
                  subtitle: Text(
                    '${entry.subtitle}\n${_formatDate(entry.completedAt)}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    '${entry.score}',
                    style: TextStyle(
                      color: color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _openEntry(entry),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

enum _HistoryType { diagnostic, practice }

class _HistoryEntry {
  final _HistoryType type;
  final String title;
  final String subtitle;
  final int score;
  final DateTime completedAt;
  final Map<String, dynamic> data;

  const _HistoryEntry({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.score,
    required this.completedAt,
    required this.data,
  });
}
