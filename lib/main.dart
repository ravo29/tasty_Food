import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/welcome_animation/presentation/screens/welcome_animation_screen.dart';
import 'package:tasty_food/core/constants/app_colors.dart';

void main() {
  runApp(
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
      title: 'Tasty Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          primary: AppColors.primaryGreen,
          secondary: AppColors.primaryOrange,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bgGrey,
      ),
      // L'animation s'affiche en tout premier
      home: const WelcomeAnimationScreen(),
    );
  }
}