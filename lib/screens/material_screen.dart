import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import 'material_detail_screen.dart';
import '../theme/app_colors.dart';

class _MaterialScreenState extends State<MaterialScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<Set<String>> _completedMaterials;

  @override
  void initState() {
    super.initState();
    _completedMaterials = LearningStore.getCompletedMaterials();
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

            FutureBuilder<Set<String>>(
              future: _completedMaterials,
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

                final completedMaterials = snapshot.data!;
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
                          completedMaterials: completedMaterials,
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
                        completedMaterials: completedMaterials,
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
                        completedMaterials: completedMaterials,
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.sageGreen,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_book_rounded, color: AppColors.forestGreen, size: 38),
          SizedBox(height: 16),
          Text(
            'Belajar Pemrograman',
            style: TextStyle(
              color: AppColors.darkText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pelajari konsep pemrograman dari dasar '
            'hingga penerapannya melalui materi yang '
            'disusun secara bertahap.',
            style: TextStyle(
              color: AppColors.darkText,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
    BuildContext context,
    Map<String, dynamic> material, {
    required Set<String> completedMaterials,
  }) {
    final isCompleted = completedMaterials.contains(material['number']);
    final accent = AppColors.learningAccentFor(material['number'] as String);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(material: material),
          ),
        );
        if (mounted) {
          setState(() {
            _completedMaterials = LearningStore.getCompletedMaterials();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.softTint(accent, opacity: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withValues(alpha: 0.36)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.softTint(accent, opacity: 0.38),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                material['icon'] as IconData,
                color: AppColors.darkText,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material['number'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    material['title'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    material['subtitle'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (isCompleted) ...[
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Selesai',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
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
