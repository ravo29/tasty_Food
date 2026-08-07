import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        state = prefs.getStringList('favorite_ids') ?? [];
      }
    } catch (_) {
      if (mounted) {
        state = [];
      }
    }
  }

  Future<void> _saveFavorites(List<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorite_ids', favorites);
    } catch (_) {}
  }

  void toggleFavorite(String productId) {
    if (state.contains(productId)) {
      state = state.where((id) => id != productId).toList();
    } else {
      state = [...state, productId];
    }
    _saveFavorites(state);
  }

  bool isFavorite(String productId) => state.contains(productId);
}

final favoriteIdsProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});

final favoritesProvider = favoriteIdsProvider;

final favoriteDishesProvider = Provider<AsyncValue<List<FoodItem>>>((ref) {
  final favoriteIds = ref.watch(favoriteIdsProvider);
  final asyncFoods = ref.watch(foodListProvider);

  return asyncFoods.whenData((foods) {
    return foods.where((food) => favoriteIds.contains(food.id)).toList();
  });
});