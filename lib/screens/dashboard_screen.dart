import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import '../widgets/codify_mascot.dart';
import 'material_detail_screen.dart';
import 'diagnostic_screen.dart';
import 'material_screen.dart';
import 'progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _progressRevision = 0;
  late Future<Set<String>> _completedMaterials;

  @override
  void initState() {
    super.initState();
    _reloadHomeData();
  }

  void _reloadHomeData() {
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
            )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(context),
          const MaterialScreen(),
          ProgressScreen(key: ValueKey(_progressRevision)),
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
          _buildWelcomeHero(),
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
              color: AppColors.softTint(AppColors.butterYellow, opacity: 0.34),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(28),
              ),
              border: Border.all(
                color: AppColors.peach.withValues(alpha: 0.36),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.psychology_alt_rounded,
                      size: 34,
                      color: AppColors.primary,
                    ),
                    const Spacer(),
                    const CodifyMascot(
                      size: 58,
                      character: CodifyCharacter.zippy,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.butterYellow,
                      foregroundColor: AppColors.darkText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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

  Widget _buildWelcomeHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 112,
            child: Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.softWhite.withValues(alpha: 0.55),
              size: 18,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softWhite.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            size: 14,
                            color: AppColors.softWhite,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'TEMAN BELAJAR CODING',
                            style: TextStyle(
                              color: AppColors.softWhite,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Hai, Sobat CODIFY!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.softWhite,
                        fontSize: 22,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Siap belajar coding hari ini?',
                      style: TextStyle(
                        color: AppColors.softWhite,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.softWhite.withValues(alpha: 0.96),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDark.withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(child: CodifyMascot(size: 90)),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: -8,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.butterYellow,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.softWhite, width: 3),
              ),
              child: const CodifyMascot(
                size: 46,
                character: CodifyCharacter.pip,
              ),
            ),
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

        final total = MaterialScreen.allMaterials.length;
        final count = MaterialScreen.allMaterials
            .where(
              (material) =>
                  snapshot.data!.contains(material['number'] as String),
            )
            .length;
        final progress = total == 0 ? 0.0 : count / total;
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => setState(() => _selectedIndex = 2),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(26),
              ),
              border: Border.all(
                color: AppColors.dustyBlue.withValues(alpha: 0.7),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.dustyBlue.withValues(alpha: 0.14),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
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
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.auto_graph_rounded,
                        color: AppColors.softWhite,
                        size: 23,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Progres Belajarmu',
                      style: TextStyle(
                        color: AppColors.darkText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    color: AppColors.darkText,
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
                    backgroundColor: AppColors.dustyBlue.withValues(
                      alpha: 0.36,
                    ),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.forestGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  count == 0
                      ? '0 dari $total materi selesai. Mulai belajar untuk melihat perkembanganmu.'
                      : '$count dari $total materi selesai. Ketuk untuk melihat progres.',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
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
    final accent = AppColors.learningAccentFor(number);
    final materialIndex = int.tryParse(number) ?? 1;
    final cardRadius = switch (materialIndex % 3) {
      0 => BorderRadius.circular(26),
      1 => const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(28),
      ),
      _ => const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(28),
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(12),
      ),
    };
    return InkWell(
      borderRadius: cardRadius,
      onTap: () async {
        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialDetailScreen(
              material: MaterialScreen.materialForNumber(number),
            ),
          ),
        );
        if (mounted) {
          setState(_reloadHomeData);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.softTint(
            accent,
            opacity: materialIndex.isEven ? 0.24 : 0.16,
          ),
          borderRadius: cardRadius,
          border: Border.all(color: accent.withValues(alpha: 0.72), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  CodifyMascot(
                    size: 52,
                    character: codifyCharacterFor(materialIndex),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.softWhite,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: accent.computeLuminance() > 0.32
                            ? AppColors.darkText
                            : AppColors.softWhite,
                        size: 12,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.softTint(accent, opacity: 0.22),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
