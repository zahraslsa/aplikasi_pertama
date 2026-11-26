import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/codify_mascot.dart';
import 'dashboard_screen.dart';

class CodifySplashScreen extends StatefulWidget {
  const CodifySplashScreen({super.key});

  @override
  State<CodifySplashScreen> createState() => _CodifySplashScreenState();
}

class _CodifySplashScreenState extends State<CodifySplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _mascotScale;
  late final Animation<Offset> _mascotSlide;
  late final Animation<double> _brandOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1450),
    )..addStatusListener(_onAnimationStatus);
    _mascotScale = Tween<double>(
      begin: 0.72,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _mascotSlide = Tween<Offset>(begin: const Offset(0, 0.16), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.62, curve: Curves.easeOutCubic),
          ),
        );
    _brandOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.18, 0.72, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -50,
              child: _GlowCircle(
                size: 230,
                color: AppColors.skyBlue.withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              bottom: -65,
              left: -55,
              child: _GlowCircle(
                size: 210,
                color: AppColors.butterYellow.withValues(alpha: 0.16),
              ),
            ),
            Positioned(
              top: 132,
              left: 48,
              child: Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.butterYellow.withValues(alpha: 0.9),
                size: 22,
              ),
            ),
            SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SlideTransition(
                          position: _mascotSlide,
                          child: ScaleTransition(
                            scale: _mascotScale,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 184,
                                  height: 184,
                                  decoration: BoxDecoration(
                                    color: AppColors.softWhite,
                                    borderRadius: BorderRadius.circular(58),
                                    border: Border.all(
                                      color: AppColors.softWhite.withValues(
                                        alpha: 0.7,
                                      ),
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryDark.withValues(
                                          alpha: 0.22,
                                        ),
                                        blurRadius: 28,
                                        offset: const Offset(0, 14),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: CodifyMascot(size: 154),
                                  ),
                                ),
                                const Positioned(
                                  left: -20,
                                  bottom: 14,
                                  child: CodifyMascot(
                                    size: 54,
                                    character: CodifyCharacter.zippy,
                                  ),
                                ),
                                const Positioned(
                                  right: -20,
                                  bottom: 44,
                                  child: CodifyMascot(
                                    size: 54,
                                    character: CodifyCharacter.byte,
                                  ),
                                ),
                                const Positioned(
                                  right: -12,
                                  top: 18,
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: AppColors.butterYellow,
                                    size: 32,
                                  ),
                                ),
                                const Positioned(
                                  left: -18,
                                  bottom: 22,
                                  child: Icon(
                                    Icons.code_rounded,
                                    color: AppColors.softLilac,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeTransition(
                          opacity: _brandOpacity,
                          child: Column(
                            children: [
                              const Text(
                                'CODIFY',
                                style: TextStyle(
                                  color: AppColors.softWhite,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Belajar coding, satu langkah setiap hari.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.softWhite.withValues(
                                    alpha: 0.88,
                                  ),
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 36),
                              SizedBox(
                                width: 176,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: _controller.value,
                                        minHeight: 6,
                                        backgroundColor: AppColors.softWhite
                                            .withValues(alpha: 0.22),
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                              AppColors.butterYellow,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Menyiapkan ruang belajar...',
                                      style: TextStyle(
                                        color: AppColors.softWhite.withValues(
                                          alpha: 0.78,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
