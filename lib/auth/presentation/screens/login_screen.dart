// lib/auth/presentation/screens/login_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import 'auth_form_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF2E7D32);
    const Color lightGreyButton = Color(0xFFF2F2F2);

    final List<String> foodImages = [
      'assets/images/ChickenCaesarSalad.png',
      'assets/images/ChickenChargha.png',
      'assets/images/ChickenParmesan.png',
      'assets/images/ChickenQuesadilla.png',
    ];

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

                // 1. Logo Tasty Food
                Image.asset(
                  AppAssets.logoTastyFood,
                  height: 120, // Taille réduite pour éviter le dépassement
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 30),

                // 2. Mosaïque de 4 images disposées en Losange
                Transform.rotate(
                  angle: 45 * math.pi / 180,
                  child: SizedBox(
                    width: 170, // Taille légèrement ajustée
                    height: 170,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                const SizedBox(height: 40),

                // 3. Titre "ALL YOUR FAVOURITE FOOD"
                const Text(
                  "ALL YOUR FAVOURITE\nFOOD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 32),

                // 4. Bouton Log In
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthFormScreen(isSignUp: false),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // 5. Bouton Sign In (Vert / Gris selon votre préférence)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthFormScreen(isSignUp: true),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightGreyButton,
                      foregroundColor: Colors.grey[700],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
}