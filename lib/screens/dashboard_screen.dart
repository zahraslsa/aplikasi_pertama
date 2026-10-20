import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import 'material_detail_screen.dart';
import 'diagnostic_screen.dart';
import 'material_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _progressRevision = 0;
  late Future<Map<String, String>> _profile;
  late Future<Set<String>> _completedMaterials;

  @override
  void initState() {
    super.initState();
    _reloadHomeData();
  }

  void _reloadHomeData() {
    _profile = LearningStore.getProfile();
    _completedMaterials = LearningStore.getCompletedMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
        title: const Text(
          'CODIFY',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _selectedIndex = 3),
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profil',
          ),
          const SizedBox(width: 8),
        ],
      )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(context),
          const MaterialScreen(),
          ProgressScreen(key: ValueKey(_progressRevision)),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              _reloadHomeData();
            } else if (index == 2) {
              _progressRevision++;
            }
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Materi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Progres',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, String>>(
              future: _profile,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Profil gagal dimuat: ${snapshot.error}',
                    style: const TextStyle(color: AppColors.error),
                  );
                }
                return Text(
                  'Halo, ${snapshot.data?['name'] ?? 'Sobat CODIFY'}!',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Siap meningkatkan kemampuan coding-mu hari ini?',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            _buildProgressCard(context),

            const SizedBox(height: 28),

            // Tes diagnostik
            const Text(
              'Mulai Belajar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.psychology_alt_rounded,
                    size: 34,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tes Diagnostik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kenali kemampuan awalmu melalui 25 soal '
                    'dasar pemrograman dan temukan materi yang '
                    'perlu kamu pelajari.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiagnosticScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Mulai Tes'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Daftar materi
            const Text(
              'Materi Pemrograman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pelajari dasar pemrograman secara bertahap.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),

            _buildMaterialCard(
              icon: Icons.account_tree_outlined,
              title: 'Algoritma & Flowchart',
              subtitle: 'Mengenal langkah penyelesaian masalah.',
              number: '01',
            ),
            _buildMaterialCard(
              icon: Icons.data_object_rounded,
              title: 'Variabel & Tipe Data',
              subtitle: 'Memahami penyimpanan data.',
              number: '02',
            ),
            _buildMaterialCard(
              icon: Icons.calculate_outlined,
              title: 'Operator',
              subtitle: 'Mempelajari operasi dalam program.',
              number: '03',
            ),
            _buildMaterialCard(
              icon: Icons.alt_route_rounded,
              title: 'Percabangan',
              subtitle: 'Membuat keputusan berdasarkan kondisi.',
              number: '04',
            ),
            _buildMaterialCard(
              icon: Icons.loop_rounded,
              title: 'Perulangan',
              subtitle: 'Menjalankan instruksi secara berulang.',
              number: '05',
            ),
            OutlinedButton.icon(
              onPressed: () => setState(() => _selectedIndex = 1),
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text('Lihat Semua 12 Materi'),
            ),
          ],
        ),
      );
  }

  Widget _buildProgressCard(BuildContext context) {
    return FutureBuilder<Set<String>>(
      future: _completedMaterials,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Progres gagal dimuat: ${snapshot.error}',
            style: const TextStyle(color: AppColors.error),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final count = snapshot.data!.length;
        final progress = count / MaterialScreen.allMaterials.length;
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => setState(() => _selectedIndex = 2),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.auto_graph_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Progres Belajarmu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0x66FFFFFF),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  count == 0
                      ? 'Mulai belajar untuk melihat perkembanganmu.'
                      : '$count dari 12 materi selesai. Ketuk untuk melihat progres.',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaterialCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String number,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(
              material: MaterialScreen.materialForNumber(number),
            ),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 25),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
