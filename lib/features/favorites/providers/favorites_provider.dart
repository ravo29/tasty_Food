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
      final savedFavorites = prefs.getStringList('favorite_ids');
      if (mounted) {
        state = savedFavorites ?? [];
      }
    } catch (e) {
      // Log error for debugging
      print('Error loading favorites: $e');
      if (mounted) {
        state = [];
      }
    }
  }

  Future<void> _saveFavorites(List<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorite_ids', favorites);
    } catch (e) {
      // Log error for debugging
      print('Error saving favorites: $e');
    }
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

  return asyncFoods.when(
    data: (foods) {
      return foods.where((food) => favoriteIds.contains(food.id)).toList();
    },
    loading: () => [], // Return empty list while loading
    error: (error, stack) {
      print('Error in favoriteDishesProvider: $error');
      return []; // Return empty list on error
    },
  );
});