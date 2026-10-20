import 'package:flutter/material.dart';

import 'material_detail_screen.dart';
import '../theme/app_colors.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materi Pembelajaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 28),

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
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),

            const SizedBox(height: 16),

            ...basicMaterials.map(
              (material) => _buildMaterialCard(context, material),
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
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),

            const SizedBox(height: 16),

            ...additionalMaterials.map(
              (material) => _buildMaterialCard(context, material),
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
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_book_rounded, color: Colors.white, size: 38),
          SizedBox(height: 16),
          Text(
            'Belajar Pemrograman',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pelajari konsep pemrograman dari dasar '
            'hingga penerapannya melalui materi yang '
            'disusun secara bertahap.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
    BuildContext context,
    Map<String, dynamic> material,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(material: material),
          ),
        );
      },
      child: Container(
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
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                material['icon'] as IconData,
                color: AppColors.primary,
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
                      color: AppColors.primary,
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
