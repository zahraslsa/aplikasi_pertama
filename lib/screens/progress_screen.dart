import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import 'history_screen.dart';
import 'material_detail_screen.dart';
import 'material_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Future<_ProgressData> _progress;

  @override
  void initState() {
    super.initState();
    _progress = _loadProgress();
  }

  Future<_ProgressData> _loadProgress() async {
    final values = await Future.wait<Object>([
      LearningStore.getCompletedMaterials(),
      LearningStore.getDiagnosticHistory(),
      LearningStore.getPracticeHistory(),
    ]);
    return _ProgressData(
      completedMaterials: values[0] as Set<String>,
      diagnosticHistory: values[1] as List<Map<String, dynamic>>,
      practiceHistory: values[2] as List<Map<String, dynamic>>,
    );
  }

  void _reload() {
    setState(() => _progress = _loadProgress());
  }

  Map<String, dynamic>? _recommendMaterial(
    List<Map<String, dynamic>> diagnosticHistory,
    Set<String> completedMaterials,
  ) {
    if (diagnosticHistory.isEmpty) {
      return null;
    }

    final latest = diagnosticHistory.last;
    final scores = Map<String, dynamic>.from(latest['topicScores'] as Map);
    final belowTarget =
        scores.entries.where((entry) => (entry.value as int) < 80).toList()
          ..sort((a, b) => (a.value as int).compareTo(b.value as int));

    if (belowTarget.isNotEmpty) {
      return MaterialScreen.materialForTopic(belowTarget.first.key);
    }
    for (final material in MaterialScreen.additionalMaterials) {
      if (!completedMaterials.contains(material['number'])) {
        return material;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progres Belajar'),
        actions: [
          IconButton(
            onPressed: _reload,
            tooltip: 'Muat ulang progres',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder<_ProgressData>(
        future: _progress,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Progres gagal dimuat: ${snapshot.error}',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final completedCount = data.completedMaterials.length;
          final progress = completedCount / MaterialScreen.allMaterials.length;
          final averagePracticeScore = data.practiceHistory.isEmpty
              ? 0
              : (data.practiceHistory.fold<int>(
                          0,
                          (sum, attempt) => sum + (attempt['score'] as int),
                        ) /
                        data.practiceHistory.length)
                    .round();
          final recommendation = _recommendMaterial(
            data.diagnosticHistory,
            data.completedMaterials,
          );
          final latestTopicScores = data.diagnosticHistory.isEmpty
              ? null
              : Map<String, dynamic>.from(
                  data.diagnosticHistory.last['topicScores'] as Map,
                );
          final allTopicsAtTarget =
              latestTopicScores != null &&
              latestTopicScores.values.every((score) => (score as int) >= 80);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Materi selesai',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completedCount dari ${MaterialScreen.allMaterials.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 9,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).round()}% progres belajar',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'Tes diagnostik',
                      value: '${data.diagnosticHistory.length}',
                      icon: Icons.fact_check_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Rata-rata latihan',
                      value: '$averagePracticeScore',
                      icon: Icons.track_changes_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Rekomendasi berikutnya',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (recommendation == null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    data.diagnosticHistory.isEmpty
                        ? 'Kerjakan tes diagnostik untuk mendapatkan rekomendasi materi yang sesuai.'
                        : 'Semua materi pengayaan telah selesai. Hebat, pertahankan progres belajarmu!',
                    style: TextStyle(color: AppColors.textPrimary, height: 1.5),
                  ),
                )
              else
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.lightbulb_outline_rounded,
                      color: AppColors.primary,
                    ),
                    title: Text(recommendation['title'] as String),
                    subtitle: Text(
                      allTopicsAtTarget
                          ? 'Semua kompetensi mencapai target. Lanjutkan materi pengayaan.'
                          : 'Materi dipilih dari kompetensi dengan nilai terendah pada tes terakhir.',
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MaterialDetailScreen(material: recommendation),
                        ),
                      ).then((_) => _reload());
                    },
                  ),
                ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.history_rounded),
                label: const Text('Lihat Riwayat Belajar'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressData {
  final Set<String> completedMaterials;
  final List<Map<String, dynamic>> diagnosticHistory;
  final List<Map<String, dynamic>> practiceHistory;

  const _ProgressData({
    required this.completedMaterials,
    required this.diagnosticHistory,
    required this.practiceHistory,
  });
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
