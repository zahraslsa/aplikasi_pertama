import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import 'history_screen.dart';
import 'material_detail_screen.dart';
import 'material_screen.dart';
import '../widgets/codify_mascot.dart';

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
          final totalMaterials = MaterialScreen.allMaterials.length;
          final completedCount = MaterialScreen.allMaterials
              .where(
                (material) =>
                    data.completedMaterials.contains(material['number']),
              )
              .length;
          final progress = totalMaterials == 0
              ? 0.0
              : completedCount / totalMaterials;
          final remainingCount = totalMaterials - completedCount;
          final progressPercent = (progress * 100).round();
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
              _buildOverviewCard(
                completedCount: completedCount,
                remainingCount: remainingCount,
                totalMaterials: totalMaterials,
                progress: progress,
                progressPercent: progressPercent,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'Tes diagnostik',
                      value: '${data.diagnosticHistory.length}',
                      icon: Icons.fact_check_outlined,
                      backgroundColor: AppColors.softTint(
                        AppColors.peach,
                        opacity: 0.24,
                      ),
                      iconColor: AppColors.forestGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Rata-rata latihan',
                      value: '$averagePracticeScore',
                      icon: Icons.track_changes_rounded,
                      backgroundColor: AppColors.softTint(
                        AppColors.butterYellow,
                        opacity: 0.28,
                      ),
                      iconColor: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCompetencyCard(latestTopicScores),
              const SizedBox(height: 24),
              const Text(
                'Pencapaian belajar',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Badge terbuka berdasarkan materi yang sudah selesai.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _AchievementCard(
                      title: 'Langkah pertama',
                      detail: 'Selesaikan 1 materi',
                      accent: AppColors.peach,
                      icon: Icons.emoji_events_rounded,
                      isUnlocked: completedCount >= 1,
                    ),
                    const SizedBox(width: 10),
                    _AchievementCard(
                      title: 'Lima materi',
                      detail: 'Selesaikan 5 materi',
                      accent: AppColors.butterYellow,
                      icon: Icons.workspace_premium_rounded,
                      isUnlocked: completedCount >= 5,
                    ),
                    const SizedBox(width: 10),
                    _AchievementCard(
                      title: 'Tuntas semua',
                      detail: 'Selesaikan semua materi',
                      accent: AppColors.dustyBlue,
                      icon: Icons.military_tech_rounded,
                      isUnlocked:
                          totalMaterials > 0 &&
                          completedCount == totalMaterials,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _buildMotivationCard(completedCount, totalMaterials),
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
                    color: AppColors.softTint(
                      AppColors.softLilac,
                      opacity: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    data.diagnosticHistory.isEmpty
                        ? 'Kerjakan tes diagnostik untuk mendapatkan rekomendasi materi yang sesuai.'
                        : 'Semua materi pengayaan telah selesai. Hebat, pertahankan progres belajarmu!',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                )
              else
                Card(
                  color: AppColors.softTint(
                    AppColors.learningAccentFor(
                      recommendation['number'] as String,
                    ),
                    opacity: 0.2,
                  ),
                  child: ListTile(
                    key: const ValueKey('progress-recommendation-tile'),
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
                    onTap: () async {
                      await Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MaterialDetailScreen(material: recommendation),
                        ),
                      );
                      if (mounted) {
                        _reload();
                      }
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

  Widget _buildOverviewCard({
    required int completedCount,
    required int remainingCount,
    required int totalMaterials,
    required double progress,
    required int progressPercent,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.sageGreen, opacity: 0.36),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.sageGreen.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ringkasan belajar',
                      style: TextStyle(
                        color: AppColors.forestGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Materi selesai',
                      style: TextStyle(color: AppColors.darkText, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 76,
                height: 76,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 7,
                        backgroundColor: AppColors.sageGreen.withValues(
                          alpha: 0.35,
                        ),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.forestGreen,
                        ),
                      ),
                    ),
                    Text(
                      '$progressPercent%',
                      style: const TextStyle(
                        color: AppColors.forestGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$completedCount dari $totalMaterials',
            style: const TextStyle(
              color: AppColors.darkText,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '$remainingCount materi belum selesai',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.softWhite,
              valueColor: const AlwaysStoppedAnimation(AppColors.forestGreen),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$progressPercent% progres belajar',
            style: const TextStyle(
              color: AppColors.forestGreen,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetencyCard(Map<String, dynamic>? topicScores) {
    final entries =
        topicScores?.entries.toList() ?? const <MapEntry<String, dynamic>>[];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.softTint(AppColors.dustyBlue, opacity: 0.3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_graph_rounded,
                  color: AppColors.forestGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Peta kompetensi',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 62,
                      height: 8,
                      child: CustomPaint(painter: _SketchUnderlinePainter()),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Nilai dari tes diagnostik terakhir',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (entries.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.softTint(AppColors.dustyBlue, opacity: 0.16),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.fact_check_outlined,
                    color: AppColors.forestGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Belum ada hasil tes diagnostik. Skor kompetensi akan muncul setelah tes pertama.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ...List.generate(entries.length, (index) {
              final entry = entries[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == entries.length - 1 ? 0 : 14,
                ),
                child: _CompetencyScoreRow(
                  topic: entry.key,
                  score: entry.value as int,
                  accent:
                      AppColors.learningAccents[index %
                          AppColors.learningAccents.length],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildMotivationCard(int completedCount, int totalMaterials) {
    final message = completedCount == 0
        ? 'Mulai dari satu materi hari ini. Setiap langkah kecil membangun kemampuan coding-mu.'
        : completedCount == totalMaterials
        ? 'Kamu menuntaskan semua materi. Hebat! Terus asah kemampuanmu lewat latihan.'
        : completedCount >= 5
        ? 'Keren, kamu sudah menyelesaikan $completedCount materi. Pertahankan ritme belajarmu!'
        : 'Kamu sudah menyelesaikan $completedCount materi. Lanjutkan langkah kecil berikutnya!';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.peach, opacity: 0.24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Terus bertumbuh!',
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const CodifyMascot(size: 68),
        ],
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
  final Color backgroundColor;
  final Color iconColor;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
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

class _CompetencyScoreRow extends StatelessWidget {
  final String topic;
  final int score;
  final Color accent;

  const _CompetencyScoreRow({
    required this.topic,
    required this.score,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                topic,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$score/100',
              style: const TextStyle(
                color: AppColors.forestGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: score.clamp(0, 100) / 100,
            minHeight: 7,
            backgroundColor: accent.withValues(alpha: 0.18),
            valueColor: AlwaysStoppedAnimation(accent),
          ),
        ),
      ],
    );
  }
}

class _SketchUnderlinePainter extends CustomPainter {
  const _SketchUnderlinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final peachStroke = Paint()
      ..color = AppColors.peach.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.8;
    final greenStroke = Paint()
      ..color = AppColors.forestGreen.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawPath(
      Path()
        ..moveTo(1, size.height * 0.58)
        ..quadraticBezierTo(
          size.width * 0.3,
          size.height * 0.12,
          size.width * 0.52,
          size.height * 0.55,
        )
        ..quadraticBezierTo(
          size.width * 0.76,
          size.height * 0.88,
          size.width - 1,
          size.height * 0.4,
        ),
      peachStroke,
    );
    canvas.drawPath(
      Path()
        ..moveTo(4, size.height * 0.9)
        ..quadraticBezierTo(
          size.width * 0.45,
          size.height * 0.56,
          size.width * 0.82,
          size.height * 0.82,
        ),
      greenStroke,
    );
  }

  @override
  bool shouldRepaint(covariant _SketchUnderlinePainter oldDelegate) => false;
}

class _AchievementCard extends StatelessWidget {
  final String title;
  final String detail;
  final Color accent;
  final IconData icon;
  final bool isUnlocked;

  const _AchievementCard({
    required this.title,
    required this.detail,
    required this.accent,
    required this.icon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isUnlocked
        ? AppColors.forestGreen
        : AppColors.textSecondary;

    return Container(
      width: 164,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.softTint(accent, opacity: isUnlocked ? 0.34 : 0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnlocked ? accent.withValues(alpha: 0.6) : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.softTint(
                    accent,
                    opacity: isUnlocked ? 0.5 : 0.22,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: accent.withValues(alpha: isUnlocked ? 0.65 : 0.3),
                  ),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const Spacer(),
              Icon(
                isUnlocked ? Icons.check_circle_rounded : Icons.lock_outline,
                color: iconColor,
                size: 16,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkText,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            isUnlocked ? 'Didapat' : 'Belum terbuka',
            style: TextStyle(
              color: iconColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
