import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';

class FoodListNotifier extends StateNotifier<List<FoodItem>> {
  FoodListNotifier()
      : super([
          const FoodItem(
            id: '1',
            name: 'Beef Burger',
            category: 'Burger',
            price: '7.99',
            image: 'assets/images/RoastChicken.png',
            description: 'Delicious beef burger with cheese and lettuce.',
            calories: '450 kcal',
          ),
          const FoodItem(
            id: '2',
            name: 'Chicken Pasta',
            category: 'Pasta',
            price: '9.50',
            image: 'assets/images/RoastChicken.png',
            description: 'Creamy chicken pasta with herbs.',
            calories: '520 kcal',
          ),
          const FoodItem(
            id: '3',
            name: 'Fried Chicken',
            category: 'Chicken',
            price: '8.20',
            image: 'assets/images/RoastChicken.png',
            description: 'Crispy fried chicken pieces.',
            calories: '600 kcal',
          ),
          const FoodItem(
            id: '4',
            name: 'Chocolate Cake',
            category: 'Dessert',
            price: '4.99',
            image: 'assets/images/RoastChicken.png',
            description: 'Rich chocolate layer cake.',
            calories: '350 kcal',
          ),
        ]);

  void toggleFavorite(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isFavorite: !item.isFavorite) else item,
    ];
  }
}

final foodListProvider = StateNotifierProvider<FoodListNotifier, List<FoodItem>>((ref) {
  return FoodListNotifier();
});