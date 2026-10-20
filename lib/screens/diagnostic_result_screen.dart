import 'package:flutter/material.dart';

import 'material_detail_screen.dart';
import '../theme/app_colors.dart';
import 'material_screen.dart';
import '../widgets/codify_button.dart';

class DiagnosticResultScreen extends StatelessWidget {
  final Map<String, int> topicScores;
  final int overallScore;

  const DiagnosticResultScreen({
    super.key,
    required this.topicScores,
    required this.overallScore,
  });

  String get recommendation {
    final belowTarget =
        topicScores.entries.where((entry) => entry.value < 80).toList()
          ..sort((a, b) => a.value.compareTo(b.value));

    if (belowTarget.isEmpty) {
      return 'Semua kompetensi sudah mencapai target. Kamu bisa melanjutkan ke materi pengayaan.';
    }

    return 'Prioritaskan belajar pada materi ${belowTarget.first.key}. '
        'Materi ini memiliki nilai paling rendah dan perlu diperkuat.';
  }

  String? get recommendedTopic {
    final belowTarget =
        topicScores.entries.where((entry) => entry.value < 80).toList()
          ..sort((a, b) => a.value.compareTo(b.value));
    return belowTarget.isEmpty ? null : belowTarget.first.key;
  }

  Color getScoreColor(int score) {
    if (score >= 80) {
      return Colors.green;
    } else if (score >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getScoreLabel(int score) {
    if (score >= 80) {
      return 'Tercapai';
    } else if (score >= 60) {
      return 'Cukup';
    } else {
      return 'Perlu belajar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Tes Diagnostik'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallResult(),
            const SizedBox(height: 24),

            const Text(
              'Hasil per Kompetensi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Berikut hasil kemampuanmu pada setiap kompetensi.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            ...topicScores.entries.map(
              (entry) => _buildTopicCard(entry.key, entry.value),
            ),

            const SizedBox(height: 24),

            _buildRecommendation(),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  final material = recommendedTopic == null
                      ? MaterialScreen.materialForNumber('06')
                      : MaterialScreen.materialForTopic(recommendedTopic!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MaterialDetailScreen(material: material),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book_rounded),
                label: Text(
                  recommendedTopic == null
                      ? 'Mulai Materi Pengayaan'
                      : 'Pelajari $recommendedTopic',
                ),
              ),
            ),
            const SizedBox(height: 12),
            CodifyButton(
              text: 'Kembali ke Beranda',
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallResult() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 54),
          const SizedBox(height: 14),
          const Text(
            'Tes Diagnostik Selesai',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Nilai keseluruhan kamu',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            '$overallScore',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'dari 100',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(String topic, int score) {
    final scoreColor = getScoreColor(score);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: scoreColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              score >= 80
                  ? Icons.check_circle_outline_rounded
                  : Icons.menu_book_rounded,
              color: scoreColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  getScoreLabel(score),
                  style: TextStyle(
                    fontSize: 12,
                    color: scoreColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rekomendasi Belajar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recommendation,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
