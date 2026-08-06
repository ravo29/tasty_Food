// lib/features/welcome_animation/presentation/screens/welcome_animation_screen.dart
import 'package:flutter/material.dart';
import 'package:tasty_food/core/constants/app_assets.dart';
import 'package:tasty_food/auth/presentation/screens/login_screen.dart';

class WelcomeAnimationScreen extends StatefulWidget {
  const WelcomeAnimationScreen({super.key});

  @override
  State<WelcomeAnimationScreen> createState() => _WelcomeAnimationScreenState();
}

class _WelcomeAnimationScreenState extends State<WelcomeAnimationScreen>
    with TickerProviderStateMixin {
  static const Color onboardingOrange = Color(0xFF2E7D32); // même vert que login/auth
  static const Color onboardingDarkOrange = Color(0xFF1B5E20); // même vert foncé que login/auth

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  // Contrôleur pour l'entrée en fondu échelonnée des différents blocs.
  late final AnimationController _entranceController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _panelFade;
  late final Animation<Offset> _panelSlide;
  late final Animation<double> _textFade;
  late final Animation<double> _buttonFade;

  // Contrôleur en boucle pour l'emoji pizza qui flotte doucement.
  late final AnimationController _floatController;
  late final Animation<double> _floatOffset;
  late final Animation<double> _floatRotation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _panelFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
    );
    _panelSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(_panelFade);

    _textFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );

    _buttonFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );

    _entranceController.forward();

    // Flottement continu de l'emoji pizza (léger va-et-vient vertical + rotation).
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _floatOffset = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _floatRotation = Tween<double>(begin: -0.25, end: -0.12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableHeight = constraints.maxHeight;

            return SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: availableHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --- PARTIE HAUTE (Logo + Pizza flottante + Parallax) ---
                    SizedBox(
                      height: availableHeight * 0.50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 20 - (_scrollOffset * 0.4),
                            left: 30,
                            child: AnimatedBuilder(
                              animation: _floatController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _floatOffset.value),
                                  child: Transform.rotate(
                                    angle: _floatRotation.value,
                                    child: child,
                                  ),
                                );
                              },
                              child: const Text(
                                '🍕',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, -_scrollOffset * 0.2),
                            child: FadeTransition(
                              opacity: _logoFade,
                              child: ScaleTransition(
                                scale: _logoScale,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                  child: Image.asset(
                                    AppAssets.logoTastyFood,
                                    height: 130,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- PARTIE BASSE (Panneau de contrôle) ---
                    FadeTransition(
                      opacity: _panelFade,
                      child: SlideTransition(
                        position: _panelSlide,
                        child: Container(
                          height: availableHeight * 0.48,
                          width: double.infinity,
                          margin: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [onboardingOrange, onboardingDarkOrange],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: onboardingDarkOrange.withValues(alpha: 0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Indicateur de page : le point actif "respire" doucement.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildDot(active: false),
                                    const SizedBox(width: 8),
                                    _buildDot(active: false),
                                    const SizedBox(width: 8),
                                    _PulsingDot(controller: _floatController),
                                  ],
                                ),

                                // Textes d'introduction
                                FadeTransition(
                                  opacity: _textFade,
                                  child: const Column(
                                    children: [
                                      Text(
                                        "Super fast delivery",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Home delivery and online reservation system for restaurants and cafe",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Bouton Get Started avec fondu + feedback tactile
                                FadeTransition(
                                  opacity: _buttonFade,
                                  child: _AnimatedGetStartedButton(
                                    foregroundColor: onboardingOrange,
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        _fadeThroughRoute(const LoginScreen()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot({required bool active}) {
    return Container(
      height: 8,
      width: 8,
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }

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

/// Point de pagination actif qui pulse légèrement en boucle.
class _PulsingDot extends StatelessWidget {
  const _PulsingDot({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double opacity = 0.7 + (controller.value * 0.3);
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Container(
        height: 8,
        width: 8,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Bouton "Get Started" avec un effet d'échelle au toucher.
class _AnimatedGetStartedButton extends StatefulWidget {
  const _AnimatedGetStartedButton({
    required this.foregroundColor,
    required this.onPressed,
  });

  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  State<_AnimatedGetStartedButton> createState() =>
      _AnimatedGetStartedButtonState();
}

class _AnimatedGetStartedButtonState extends State<_AnimatedGetStartedButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: widget.foregroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}