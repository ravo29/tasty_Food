import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

void main() {
  group('FoodListProvider Tests', () {
    test('foodListProvider should return list of FoodItem', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);

      expect(foodList, isA<List<FoodItem>>());
      expect(foodList, isNotEmpty);
    });

    test('foodListProvider should return 19 mock items', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);

      expect(foodList, hasLength(19));
    });

    test('foodListProvider should include all categories', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);
      final categories = foodList.map((item) => item.category).toSet();

      expect(categories, contains('Burger'));
      expect(categories, contains('Pizza'));
      expect(categories, contains('Chicken'));
      expect(categories, contains('Pasta'));
      expect(categories, contains('Drinks'));
      expect(categories, contains('Dessert'));
    });

    test('foodListProvider should have correct price type (double)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);

      for (final item in foodList) {
        expect(item.price, isA<double>());
        expect(item.price, greaterThan(0));
      }
    });

    test('foodListProvider should have all required fields', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);

      for (final item in foodList) {
        expect(item.id, isNotEmpty);
        expect(item.name, isNotEmpty);
        expect(item.category, isNotEmpty);
        expect(item.image, isNotEmpty);
        expect(item.description, isNotEmpty);
        expect(item.calories, isNotEmpty);
      }
    });

    test('foodListProvider should have specific burger items', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);
      final burgers = foodList.where((item) => item.category == 'Burger');

      expect(burgers, isNotEmpty);
      expect(burgers.any((item) => item.name.contains('Burger')), true);
    });

    test('foodListProvider should have drink items', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);
      final drinks = foodList.where((item) => item.category == 'Drinks');

      expect(drinks, isNotEmpty);
      expect(drinks.any((item) => item.name.contains('Cappuccino')), true);
      expect(drinks.any((item) => item.name.contains('Lemonade')), true);
    });
  });
}