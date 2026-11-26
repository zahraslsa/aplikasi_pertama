import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import 'history_screen.dart';
import 'material_detail_screen.dart';
import 'material_screen.dart';
import '../widgets/codify_mascot.dart';
import '../widgets/codify_card_surface.dart';

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
          IconButton.filledTonal(
            onPressed: _reload,
            tooltip: 'Muat ulang progres',
            style: IconButton.styleFrom(
              backgroundColor: AppColors.softTint(
                AppColors.dustyBlue,
                opacity: 0.2,
              ),
              foregroundColor: AppColors.forestGreen,
            ),
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
                      backgroundColor: AppColors.peach,
                      silhouette: CodifyCardSilhouette.ticket,
                      iconColor: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Rata-rata latihan',
                      value: '$averagePracticeScore',
                      icon: Icons.track_changes_rounded,
                      backgroundColor: AppColors.butterYellow,
                      silhouette: CodifyCardSilhouette.foldedNote,
                      iconColor: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCompetencyCard(latestTopicScores),
              const SizedBox(height: 20),
              _buildLearningMap(data),
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
                height: 176,
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
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.forestGreen,
                  backgroundColor: AppColors.softTint(
                    AppColors.dustyBlue,
                    opacity: 0.12,
                  ),
                  side: BorderSide(
                    color: AppColors.forestGreen.withValues(alpha: 0.28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
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
    return CodifyCardSurface(
      silhouette: CodifyCardSilhouette.sticker,
      color: AppColors.primary,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, AppColors.deepBlue],
      ),
      borderColor: AppColors.butterYellow.withValues(alpha: 0.8),
      borderWidth: 1.5,
      elevation: 6,
      padding: const EdgeInsets.all(20),
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
                        color: AppColors.butterYellow,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Materi selesai',
                      style: TextStyle(
                        color: AppColors.softWhite,
                        fontSize: 14,
                      ),
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
                        backgroundColor: AppColors.softWhite.withValues(
                          alpha: 0.24,
                        ),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.butterYellow,
                        ),
                      ),
                    ),
                    Text(
                      '$progressPercent%',
                      style: const TextStyle(
                        color: AppColors.butterYellow,
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
              color: AppColors.softWhite,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '$remainingCount materi belum selesai',
            style: const TextStyle(color: AppColors.softWhite, fontSize: 13),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.softWhite.withValues(alpha: 0.24),
              valueColor: const AlwaysStoppedAnimation(AppColors.butterYellow),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$progressPercent% progres belajar',
            style: const TextStyle(
              color: AppColors.butterYellow,
              fontWeight: FontWeight.w700,
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
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
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.softTint(AppColors.dustyBlue, opacity: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.hub_rounded,
                  color: AppColors.forestGreen,
                  size: 23,
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
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Pahami kekuatan dan fokus belajarmu',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
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
              final material = MaterialScreen.basicMaterials.firstWhere(
                (item) => item['title'] == entry.key,
                orElse: () => const {'icon': Icons.code_rounded},
              );
              return _CompetencyDiagramNode(
                key: ValueKey('competency-node-${entry.key}'),
                topic: entry.key,
                score: entry.value as int,
                icon: material['icon'] as IconData,
                accent: AppColors
                    .learningAccents[index % AppColors.learningAccents.length],
                isLast: index == entries.length - 1,
              );
            }),
        ],
      ),
    );
  }

  Widget _buildLearningMap(_ProgressData data) {
    String? nextMaterialNumber;
    for (final material in MaterialScreen.allMaterials) {
      final number = material['number'] as String;
      if (!data.completedMaterials.contains(number)) {
        nextMaterialNumber = number;
        break;
      }
    }

    return Container(
      key: const ValueKey('learning-roadmap'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.softTint(AppColors.peach, opacity: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.route_rounded,
                  color: AppColors.deepBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jalur belajar',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Satu titik untuk setiap materi',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softTint(
                    AppColors.butterYellow,
                    opacity: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${MaterialScreen.allMaterials.length} titik',
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...List.generate(MaterialScreen.allMaterials.length, (index) {
            final material = MaterialScreen.allMaterials[index];
            final number = material['number'] as String;
            final completed = data.completedMaterials.contains(number);
            final hasPracticed = data.practiceHistory.any(
              (attempt) => attempt['materialNumber'] == number,
            );
            final isNext = number == nextMaterialNumber;
            final lastAttempt = data.practiceHistory.lastWhere(
              (attempt) => attempt['materialNumber'] == number,
              orElse: () => const <String, dynamic>{},
            );
            final score = lastAttempt['score'] as int?;

            return _LearningMapNode(
              key: ValueKey('progress-map-node-$number'),
              number: number,
              title: material['title'] as String,
              icon: material['icon'] as IconData,
              isCompleted: completed,
              hasPracticed: hasPracticed,
              isNext: isNext,
              score: score,
              isLast: index == MaterialScreen.allMaterials.length - 1,
              onTap: () async {
                await Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MaterialDetailScreen(material: material),
                  ),
                );
                if (mounted) {
                  _reload();
                }
              },
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
        color: AppColors.softTint(AppColors.peach, opacity: 0.28),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(26),
        ),
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
          const CodifyMascot(size: 68, character: CodifyCharacter.byte),
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
  final CodifyCardSilhouette silhouette;
  final Color iconColor;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.silhouette,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CodifyCardSurface(
      silhouette: silhouette,
      color: backgroundColor,
      borderColor: AppColors.darkText.withValues(alpha: 0.16),
      elevation: 2,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softWhite.withValues(alpha: 0.62),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
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
              color: AppColors.darkText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompetencyDiagramNode extends StatelessWidget {
  final String topic;
  final int score;
  final IconData icon;
  final Color accent;
  final bool isLast;

  const _CompetencyDiagramNode({
    super.key,
    required this.topic,
    required this.score,
    required this.icon,
    required this.accent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final reachedTarget = score >= 80;
    final scoreColor = reachedTarget ? AppColors.success : accent;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.softTint(accent, opacity: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accent.withValues(alpha: 0.65),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: AppColors.darkText, size: 19),
                ),
                if (!isLast)
                  CustomPaint(
                    size: const Size(2, 24),
                    painter: _DottedConnectorPainter(
                      color: accent.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.softTint(accent, opacity: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reachedTarget ? 'Target tercapai' : 'Perlu diasah',
                          style: TextStyle(
                            color: reachedTarget
                                ? AppColors.success
                                : AppColors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CircularProgressIndicator(
                            value: score.clamp(0, 100) / 100,
                            strokeWidth: 4,
                            backgroundColor: accent.withValues(alpha: 0.16),
                            valueColor: AlwaysStoppedAnimation(scoreColor),
                          ),
                        ),
                        Text(
                          '$score',
                          style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningMapNode extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;
  final bool isCompleted;
  final bool hasPracticed;
  final bool isNext;
  final int? score;
  final bool isLast;
  final VoidCallback onTap;

  const _LearningMapNode({
    super.key,
    required this.number,
    required this.title,
    required this.icon,
    required this.isCompleted,
    required this.hasPracticed,
    required this.isNext,
    required this.score,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.learningAccentFor(number);
    final statusColor = isCompleted
        ? AppColors.success
        : hasPracticed
        ? AppColors.dustyBlue
        : isNext
        ? AppColors.deepBlue
        : AppColors.textSecondary;
    final status = isCompleted
        ? 'Selesai'
        : hasPracticed
        ? 'Sudah latihan'
        : isNext
        ? 'Langkah berikutnya'
        : 'Belum ada latihan';

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.success
                        : isNext
                        ? AppColors.deepBlue
                        : AppColors.softTint(accent, opacity: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.75),
                      width: 2,
                    ),
                    boxShadow: isNext
                        ? [
                            BoxShadow(
                              color: AppColors.deepBlue.withValues(alpha: 0.18),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check_rounded
                        : hasPracticed
                        ? Icons.code_rounded
                        : isNext
                        ? Icons.play_arrow_rounded
                        : Icons.circle_outlined,
                    color: isCompleted || isNext
                        ? AppColors.softWhite
                        : AppColors.darkText,
                    size: 18,
                  ),
                ),
                if (!isLast)
                  CustomPaint(
                    size: const Size(2, 30),
                    painter: _DottedConnectorPainter(
                      color: isCompleted
                          ? AppColors.success.withValues(alpha: 0.6)
                          : AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                key: ValueKey('progress-map-tap-$number'),
                onTap: onTap,
                borderRadius: BorderRadius.circular(17),
                child: Ink(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isNext
                        ? AppColors.softTint(AppColors.deepBlue, opacity: 0.08)
                        : AppColors.softTint(accent, opacity: 0.07),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: isNext
                          ? AppColors.deepBlue.withValues(alpha: 0.38)
                          : AppColors.border.withValues(alpha: 0.75),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.softTint(accent, opacity: 0.22),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(icon, color: AppColors.darkText, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$number  $title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    status,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (score != null)
                                  Text(
                                    '$score/100',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedConnectorPainter extends CustomPainter {
  final Color color;

  const _DottedConnectorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final centerX = size.width / 2;
    for (var y = 3.0; y < size.height; y += 7) {
      canvas.drawCircle(Offset(centerX, y), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DottedConnectorPainter oldDelegate) {
    return oldDelegate.color != color;
  }
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
        ? (accent.computeLuminance() > 0.32
              ? AppColors.darkText
              : AppColors.softWhite)
        : AppColors.textSecondary;

    return CodifyCardSurface(
      width: 164,
      silhouette: CodifyCardSilhouette.ticket,
      color: isUnlocked
          ? AppColors.softTint(accent, opacity: 0.16)
          : AppColors.surface,
      borderColor: isUnlocked
          ? accent.withValues(alpha: 0.82)
          : AppColors.border,
      borderWidth: isUnlocked ? 1.4 : 1,
      elevation: isUnlocked ? 3 : 0,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CodifyMascot(
                size: 50,
                character: title.startsWith('Langkah pertama')
                    ? CodifyCharacter.zippy
                    : title.startsWith('Lima materi')
                    ? CodifyCharacter.byte
                    : CodifyCharacter.pip,
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
