import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasty_food/features/menu/presentation/screens/home_menu_screen.dart';

void main() {
  group('HomeMenuScreen Widget Tests', () {
    testWidgets('HomeMenuScreen should render without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: HomeMenuScreen(),
            ),
          ),
        ),
      );

      expect(find.byType(HomeMenuScreen), findsOneWidget);
    });

    testWidgets('HomeMenuScreen should display search field', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: HomeMenuScreen(),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('HomeMenuScreen should display Categories section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: HomeMenuScreen(),
            ),
          ),
        ),
      );

      // Wait for async data to load
      await tester.pumpAndSettle();

      expect(find.text('Categories'), findsOneWidget);
    });

    testWidgets('HomeMenuScreen should display loading indicator initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: HomeMenuScreen(),
            ),
          ),
        ),
      );

      // Check for loading indicator before data loads
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}