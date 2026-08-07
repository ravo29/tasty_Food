import 'package:flutter_test/flutter_test.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';

void main() {
  group('FoodItem Model Tests', () {
    test('FoodItem should create with correct values', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Test Burger',
        category: 'Burger',
        price: 9.99,
        image: 'assets/images/burger.png',
        description: 'Test description',
        calories: '500 kcal',
        isFavorite: false,
      );

      expect(foodItem.id, '1');
      expect(foodItem.name, 'Test Burger');
      expect(foodItem.category, 'Burger');
      expect(foodItem.price, 9.99);
      expect(foodItem.image, 'assets/images/burger.png');
      expect(foodItem.description, 'Test description');
      expect(foodItem.calories, '500 kcal');
      expect(foodItem.isFavorite, false);
    });

    test('FoodItem should convert to map correctly', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Test Burger',
        category: 'Burger',
        price: 9.99,
        image: 'assets/images/burger.png',
        description: 'Test description',
        calories: '500 kcal',
        isFavorite: true,
      );

      final map = foodItem.toMap();

      expect(map['id'], '1');
      expect(map['name'], 'Test Burger');
      expect(map['category'], 'Burger');
      expect(map['price'], 9.99);
      expect(map['image'], 'assets/images/burger.png');
      expect(map['description'], 'Test description');
      expect(map['calories'], '500 kcal');
      expect(map['isFavorite'], true);
    });

    test('FoodItem copyWith should create new instance with updated values', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Test Burger',
        category: 'Burger',
        price: 9.99,
        image: 'assets/images/burger.png',
        description: 'Test description',
        calories: '500 kcal',
        isFavorite: false,
      );

      final updatedItem = foodItem.copyWith(
        name: 'Updated Burger',
        price: 12.99,
        isFavorite: true,
      );

      expect(updatedItem.id, '1'); // unchanged
      expect(updatedItem.name, 'Updated Burger'); // changed
      expect(updatedItem.category, 'Burger'); // unchanged
      expect(updatedItem.price, 12.99); // changed
      expect(updatedItem.isFavorite, true); // changed
    });

    test('FoodItem copyWith should preserve original when no parameters provided', () {
      const foodItem = FoodItem(
        id: '1',
        name: 'Test Burger',
        category: 'Burger',
        price: 9.99,
        image: 'assets/images/burger.png',
        description: 'Test description',
        calories: '500 kcal',
        isFavorite: false,
      );

      final copiedItem = foodItem.copyWith();

      expect(copiedItem.id, foodItem.id);
      expect(copiedItem.name, foodItem.name);
      expect(copiedItem.category, foodItem.category);
      expect(copiedItem.price, foodItem.price);
      expect(copiedItem.image, foodItem.image);
      expect(copiedItem.description, foodItem.description);
      expect(copiedItem.calories, foodItem.calories);
      expect(copiedItem.isFavorite, foodItem.isFavorite);
    });
  });
}