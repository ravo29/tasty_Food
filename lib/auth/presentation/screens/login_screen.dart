// lib/auth/presentation/screens/login_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import 'auth_form_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color darkGreen = Color(0xFF1B5E20);
  static const Color lightGreyButton = Color(0xFFF2F2F2);

  final List<String> foodImages = const [
    'assets/images/ChickenCaesarSalad.png',
    'assets/images/ChickenChargha.png',
    'assets/images/ChickenParmesan.png',
    'assets/images/ChickenQuesadilla.png',
  ];

  late final AnimationController _controller;

  // Animations échelonnées pour chaque section de l'écran.
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;

  late final Animation<double> _mosaicScale;
  late final Animation<double> _mosaicFade;

  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;

  late final Animation<double> _buttonsFade;
  late final Animation<Offset> _buttonsSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(_logoFade);

    _mosaicFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
    );
    _mosaicScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.6, curve: Curves.elasticOut),
      ),
    );

    _titleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.75, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(_titleFade);

    _buttonsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );
    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(_buttonsFade);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),

                // 1. Logo avec fondu + léger glissement vers le bas
                FadeTransition(
                  opacity: _logoFade,
                  child: SlideTransition(
                    position: _logoSlide,
                    child: Image.asset(
                      AppAssets.logoTastyFood,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 2. Mosaïque en losange avec effet "pop" élastique
                FadeTransition(
                  opacity: _mosaicFade,
                  child: ScaleTransition(
                    scale: _mosaicScale,
                    child: Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: foodImages.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Transform.rotate(
                                angle: -45 * math.pi / 180,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryGreen.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(foodImages[index]),
                                      fit: BoxFit.cover,
                                      scale: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 3. Titre avec fondu + glissement vers le haut
                FadeTransition(
                  opacity: _titleFade,
                  child: SlideTransition(
                    position: _titleSlide,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [primaryGreen, darkGreen],
                      ).createShader(bounds),
                      child: const Text(
                        "ALL YOUR FAVOURITE\nFOOD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // 4 & 5. Boutons avec fondu, glissement, et effet d'appui animé
                FadeTransition(
                  opacity: _buttonsFade,
                  child: SlideTransition(
                    position: _buttonsSlide,
                    child: Column(
                      children: [
                        _AnimatedActionButton(
                          label: "Log In",
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          elevated: true,
                          onPressed: () {
                            Navigator.of(context).push(
                              _fadeThroughRoute(
                                const AuthFormScreen(isSignUp: false),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        _AnimatedActionButton(
                          label: "Sign In",
                          backgroundColor: lightGreyButton,
                          foregroundColor: Colors.grey[700]!,
                          elevated: false,
                          onPressed: () {
                            Navigator.of(context).push(
                              _fadeThroughRoute(
                                const AuthFormScreen(isSignUp: true),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Transition de page en fondu-enchaîné, plus moderne que le slide par défaut.
  Route _fadeThroughRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }
}

/// Bouton avec une légère animation d'échelle au toucher (feedback tactile).
class _AnimatedActionButton extends StatefulWidget {
  const _AnimatedActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.elevated,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool elevated;
  final VoidCallback onPressed;

  @override
  State<_AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<_AnimatedActionButton> {
  double _scale = 1.0;

  void _setScale(double value) => setState(() => _scale = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setScale(0.96),
      onTapUp: (_) => _setScale(1.0),
      onTapCancel: () => _setScale(1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              foregroundColor: widget.foregroundColor,
              elevation: widget.elevated ? 4 : 0,
              shadowColor: widget.elevated
                  ? widget.backgroundColor.withValues(alpha: 0.4)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}