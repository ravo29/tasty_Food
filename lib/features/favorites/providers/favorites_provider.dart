import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';
import 'package:tasty_food/features/favorites/data/favorites_repository.dart';

// FutureProvider pour le chargement initial des favoris depuis le repository
final favoritesLoadingProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(favoritesRepositoryProvider);
  return await repository.loadFavorites();
});

class FavoritesNotifier extends StateNotifier<List<String>> {
  final FavoritesRepository _repository;

  FavoritesNotifier(this._repository) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final savedFavorites = await _repository.loadFavorites();
      if (mounted) {
        state = savedFavorites;
      }
    } catch (e) {
      print('Error loading favorites: $e');
      if (mounted) {
        state = [];
      }
    }
  }

  Future<void> _saveFavorites(List<String> favorites) async {
    try {
      await _repository.saveFavorites(favorites);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  Future<void> toggleFavorite(String productId) async {
    if (state.contains(productId)) {
      state = state.where((id) => id != productId).toList();
    } else {
      state = [...state, productId];
    }
    await _saveFavorites(state);
  }

  bool isFavorite(String productId) => state.contains(productId);
}

// Provider du repository (implémentation concrète)
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return SharedPreferencesFavoritesRepository();
});

final favoriteIdsProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(repository);
});

final favoritesProvider = favoriteIdsProvider;

final favoriteDishesProvider = Provider<List<FoodItem>>((ref) {
  final favoriteIds = ref.watch(favoriteIdsProvider);
  final asyncFoods = ref.watch(foodListProvider);

  return asyncFoods.when(
    data: (foods) {
      return foods.where((food) => favoriteIds.contains(food.id)).toList();
    },
    loading: () => <FoodItem>[],
    error: (error, stack) {
      print('Error in favoriteDishesProvider: $error');
      return <FoodItem>[];
    },
  );
});