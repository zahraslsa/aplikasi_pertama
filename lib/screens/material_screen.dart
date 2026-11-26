import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import 'material_detail_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/codify_mascot.dart';
import '../widgets/codify_card_surface.dart';

class _MaterialScreenState extends State<MaterialScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<_MaterialProgress> _materialProgress;

  @override
  void initState() {
    super.initState();
    _materialProgress = _loadMaterialProgress();
  }

  Future<_MaterialProgress> _loadMaterialProgress() async {
    final completedMaterials = await LearningStore.getCompletedMaterials();
    final practiceHistory = await LearningStore.getPracticeHistory();
    final latestScores = <String, double>{};

    for (final attempt in practiceHistory) {
      final materialNumber = attempt['materialNumber'];
      final score = attempt['score'];
      if (materialNumber is String && score is num) {
        latestScores[materialNumber] = score.toDouble().clamp(0, 100) / 100;
      }
    }

    return _MaterialProgress(
      completedMaterials: completedMaterials,
      latestScores: latestScores,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchQuery.trim().toLowerCase();
    final matchingMaterials = MaterialScreen.allMaterials.where((material) {
      final title = (material['title'] as String).toLowerCase();
      final keywords = (material['subtitle'] as String).toLowerCase();
      return title.contains(query) || keywords.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Materi Pembelajaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 28),

            TextField(
              key: const ValueKey('material-search-field'),
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Cari judul atau kata kunci materi',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder<_MaterialProgress>(
              future: _materialProgress,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Progres materi gagal dimuat: ${snapshot.error}',
                    style: const TextStyle(color: AppColors.error),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final materialProgress = snapshot.data!;
                if (query.isNotEmpty) {
                  if (matchingMaterials.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'Materi tidak ditemukan',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hasil Pencarian',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...matchingMaterials.map(
                        (material) => _buildMaterialCard(
                          context,
                          material,
                          materialProgress: materialProgress,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dasar Pemrograman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Pelajari konsep dasar pemrograman secara bertahap.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...MaterialScreen.basicMaterials.map(
                      (material) => _buildMaterialCard(
                        context,
                        material,
                        materialProgress: materialProgress,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Materi Pengayaan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Perluas pemahamanmu dengan materi lanjutan.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...MaterialScreen.additionalMaterials.map(
                      (material) => _buildMaterialCard(
                        context,
                        material,
                        materialProgress: materialProgress,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softWhite.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'RUANG BELAJAR CODIFY',
                    style: TextStyle(
                      color: AppColors.softWhite,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.65,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Belajar Pemrograman',
                  style: TextStyle(
                    color: AppColors.softWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Pelajari konsep dari dasar hingga penerapannya.',
                  style: TextStyle(
                    color: AppColors.softWhite.withValues(alpha: 0.9),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 108,
            height: 96,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  bottom: 2,
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: AppColors.softWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: CodifyMascot(size: 70)),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.butterYellow,
                      shape: BoxShape.circle,
                    ),
                    child: const CodifyMascot(
                      size: 44,
                      character: CodifyCharacter.zippy,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.skyBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.softWhite, width: 2),
                    ),
                    child: const CodifyMascot(
                      size: 44,
                      character: CodifyCharacter.byte,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
    BuildContext context,
    Map<String, dynamic> material, {
    required _MaterialProgress materialProgress,
  }) {
    final number = material['number'] as String;
    final isCompleted = materialProgress.isCompleted(number);
    final hasStarted = materialProgress.hasStarted(number);
    final progress = materialProgress.progressFor(number);
    final accent = AppColors.learningAccentFor(number);
    final materialIndex = int.tryParse(number) ?? 1;
    final cardSilhouette = switch (materialIndex % 3) {
      0 => CodifyCardSilhouette.foldedNote,
      1 => CodifyCardSilhouette.ticket,
      _ => CodifyCardSilhouette.sticker,
    };
    final accentForeground = accent.computeLuminance() > 0.32
        ? AppColors.darkText
        : AppColors.softWhite;
    final statusColor = isCompleted ? AppColors.success : AppColors.darkText;
    final statusBackground = isCompleted
        ? AppColors.softTint(AppColors.sageGreen, opacity: 0.22)
        : hasStarted
        ? AppColors.softTint(accent, opacity: 0.42)
        : AppColors.warmBeige;
    final statusIcon = isCompleted
        ? Icons.check_circle_rounded
        : hasStarted
        ? Icons.play_circle_outline_rounded
        : Icons.radio_button_unchecked_rounded;
    final statusLabel = isCompleted
        ? 'Selesai dipelajari'
        : hasStarted
        ? 'Sedang dipelajari'
        : 'Belum dimulai';

    return CodifyCardSurface(
      silhouette: cardSilhouette,
      color: AppColors.softTint(
        accent,
        opacity: materialIndex.isEven ? 0.24 : 0.16,
      ),
      borderColor: accent,
      borderWidth: 1.3,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      onTap: () async {
        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(material: material),
          ),
        );
        if (mounted) {
          setState(() {
            _materialProgress = _loadMaterialProgress();
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 58,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    CodifyMascot(
                      size: 56,
                      character: codifyCharacterFor(materialIndex),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.softWhite,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          material['icon'] as IconData,
                          color: accentForeground,
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'MATERI $number',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                          color: accentForeground,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      material['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            material['subtitle'] as String,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 5),
                    Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: accent.withValues(alpha: 0.24),
              valueColor: const AlwaysStoppedAnimation(AppColors.forestGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialProgress {
  final Set<String> completedMaterials;
  final Map<String, double> latestScores;

  const _MaterialProgress({
    required this.completedMaterials,
    required this.latestScores,
  });

  bool isCompleted(String number) => completedMaterials.contains(number);

  bool hasStarted(String number) => latestScores.containsKey(number);

  double progressFor(String number) {
    if (isCompleted(number)) {
      return 1;
    }
    return latestScores[number] ?? 0;
  }
}

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();

  static const List<Map<String, dynamic>> basicMaterials = [
    {
      'number': '01',
      'title': 'Algoritma & Flowchart',
      'subtitle': 'Dasar penyelesaian masalah dan diagram alir.',
      'icon': Icons.account_tree_outlined,
    },
    {
      'number': '02',
      'title': 'Variabel & Tipe Data',
      'subtitle': 'Mengenal variabel dan berbagai jenis data.',
      'icon': Icons.data_object_rounded,
    },
    {
      'number': '03',
      'title': 'Operator',
      'subtitle': 'Operasi aritmatika, perbandingan, dan logika.',
      'icon': Icons.calculate_outlined,
    },
    {
      'number': '04',
      'title': 'Percabangan',
      'subtitle': 'Pengambilan keputusan berdasarkan kondisi.',
      'icon': Icons.alt_route_rounded,
    },
    {
      'number': '05',
      'title': 'Perulangan',
      'subtitle': 'Menjalankan instruksi secara berulang.',
      'icon': Icons.loop_rounded,
    },
  ];

  static const List<Map<String, dynamic>> additionalMaterials = [
    {
      'number': '06',
      'title': 'Array',
      'subtitle': 'Menyimpan dan mengelola kumpulan data.',
      'icon': Icons.view_list_rounded,
    },
    {
      'number': '07',
      'title': 'Function / Method',
      'subtitle': 'Membuat kode yang terstruktur dan dapat digunakan kembali.',
      'icon': Icons.functions_rounded,
    },
    {
      'number': '08',
      'title': 'String & Manipulasi Data',
      'subtitle': 'Mengolah teks dan data dalam program.',
      'icon': Icons.text_fields_rounded,
    },
    {
      'number': '09',
      'title': 'Input & Output',
      'subtitle': 'Menerima masukan dan menampilkan keluaran program.',
      'icon': Icons.input_rounded,
    },
    {
      'number': '10',
      'title': 'Debugging',
      'subtitle': 'Menemukan dan memperbaiki kesalahan pada program.',
      'icon': Icons.bug_report_outlined,
    },
    {
      'number': '11',
      'title': 'OOP Dasar',
      'subtitle': 'Mengenal konsep dasar pemrograman berorientasi objek.',
      'icon': Icons.category_outlined,
    },
    {
      'number': '12',
      'title': 'Studi Kasus Pemrograman',
      'subtitle': 'Menerapkan konsep pemrograman pada kasus sederhana.',
      'icon': Icons.code_rounded,
    },
  ];

  static List<Map<String, dynamic>> get allMaterials => [
    ...basicMaterials,
    ...additionalMaterials,
  ];

  static Map<String, dynamic> materialForNumber(String number) {
    return allMaterials.firstWhere(
      (material) => material['number'] == number,
      orElse: () => throw ArgumentError.value(number, 'number'),
    );
  }

  static Map<String, dynamic> materialForTopic(String topic) {
    for (final material in basicMaterials) {
      if (material['title'] == topic) {
        return material;
      }
    }
    throw ArgumentError.value(topic, 'topic');
  }
}
