import 'package:flutter/material.dart';

import '../data/learning_store.dart';
import '../theme/app_colors.dart';
import '../widgets/codify_button.dart';
import '../widgets/codify_mascot.dart';
import 'history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _classController = TextEditingController();
  late Future<Map<String, String>> _profile;
  bool _isInitialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _profile = LearningStore.getProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _classController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nama tidak boleh kosong.')));
      return;
    }

    setState(() => _isSaving = true);
    try {
      await LearningStore.saveProfile({
        'name': name,
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'class': _classController.text.trim(),
      });
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
        _profile = LearningStore.getProfile();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil disimpan di perangkat.')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil tidak berhasil disimpan: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: FutureBuilder<Map<String, String>>(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Profil gagal dimuat: ${snapshot.error}',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_isInitialized) {
            _nameController.text = snapshot.data!['name']!;
            _usernameController.text = snapshot.data!['username']!;
            _emailController.text = snapshot.data!['email']!;
            _classController.text = snapshot.data!['class']!;
            _isInitialized = true;
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              _buildProfileHeader(snapshot.data!),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: AppColors.dustyBlue,
                          size: 23,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Informasi profil',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _buildField(
                      label: 'Nama Lengkap',
                      controller: _nameController,
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      label: 'Username',
                      controller: _usernameController,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      label: 'Email',
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      label: 'Kelas',
                      controller: _classController,
                      icon: Icons.school_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CodifyButton(
                text: _isSaving ? 'Menyimpan...' : 'Simpan Profil',
                onPressed: _saveProfile,
                isLoading: _isSaving,
              ),
              const SizedBox(height: 12),
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
                label: const Text('Buka Riwayat Belajar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, String> profile) {
    final name = profile['name']?.trim() ?? '';
    final username = profile['username']?.trim() ?? '';
    final className = profile['class']?.trim() ?? '';
    final initials = _initialsFor(name);
    final avatar = CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.forestGreen,
      child: initials.isEmpty
          ? const Icon(
              Icons.person_outline_rounded,
              color: AppColors.softWhite,
              size: 34,
            )
          : Text(
              initials,
              style: const TextStyle(
                color: AppColors.softWhite,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
    final identityDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profil belajar CODIFY',
          style: TextStyle(
            color: AppColors.forestGreen,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.darkText,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (username.isNotEmpty) ...[
          const SizedBox(height: 3),
          Text(
            '@$username',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
        if (className.isNotEmpty) ...[
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.softTint(AppColors.butterYellow, opacity: 0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              className,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.softTint(AppColors.sageGreen, opacity: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.sageGreen.withValues(alpha: 0.55)),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 360) {
                return Row(
                  children: [
                    avatar,
                    const SizedBox(width: 12),
                    Expanded(child: identityDetails),
                  ],
                );
              }
              return Row(
                children: [
                  avatar,
                  const SizedBox(width: 12),
                  Expanded(child: identityDetails),
                  const SizedBox(width: 4),
                  const CodifyMascot(size: 58, character: CodifyCharacter.byte),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.softTint(AppColors.dustyBlue, opacity: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.forestGreen,
                  size: 17,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Data profil disimpan di perangkat ini.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
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

  String _initialsFor(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty || trimmedName == 'Sobat CODIFY') {
      return '';
    }

    final words = trimmedName.split(RegExp(r'\s+'));
    final initials = [
      String.fromCharCodes(words.first.runes.take(1)),
      if (words.length > 1) String.fromCharCodes(words.last.runes.take(1)),
    ];
    return initials.join().toUpperCase();
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }
}
