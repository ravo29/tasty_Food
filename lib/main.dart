// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_theme.dart';
import 'features/welcome_animation/presentation/screens/welcome_animation_screen.dart';

void main() {
  runApp(
    // Indispensable pour Riverpod
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasty Food E-commerce',
      theme: AppTheme.lightTheme, // Ton thème configuré
      debugShowCheckedModeBanner: false,
      // L'écran initial est maintenant l'écran d'animation
      home: const WelcomeAnimationScreen(), 
    );
  }
}