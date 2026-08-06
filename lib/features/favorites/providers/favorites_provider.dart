import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';

/// Provider qui dérive de `foodListProvider` et retourne uniquement la liste des favoris.
final favoritesProvider = Provider<List<FoodItem>>((ref) {
  final allDishes = ref.watch(foodListProvider);
  return allDishes.where((dish) => dish.isFavorite).toList();
});