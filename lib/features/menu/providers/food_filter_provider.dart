import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

// 1. État des filtres (Catégorie, Recherche, Tri par prix)
class FoodFilterState {
  final String selectedCategory;
  final String searchQuery;
  final String sortBy; // 'none', 'price_asc', 'price_desc'

  const FoodFilterState({
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.sortBy = 'none',
  });

  FoodFilterState copyWith({
    String? selectedCategory,
    String? searchQuery,
    String? sortBy,
  }) {
    return FoodFilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

// 2. Notifier pour modifier l'état des filtres
class FoodFilterNotifier extends StateNotifier<FoodFilterState> {
  FoodFilterNotifier() : super(const FoodFilterState());

  void setSelectedCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSortBy(String sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void resetFilters() {
    state = const FoodFilterState();
  }
}

// Provider de gestion de l'état des filtres
final foodFilterProvider =
    StateNotifierProvider<FoodFilterNotifier, FoodFilterState>((ref) {
  return FoodFilterNotifier();
});

// 3. Provider combiné qui applique les filtres sur la liste asynchrone (AsyncValue)
final filteredFoodListProvider = Provider<AsyncValue<List<FoodItem>>>((ref) {
  final asyncFoodList = ref.watch(foodListProvider);
  final filter = ref.watch(foodFilterProvider);

  return asyncFoodList.whenData((items) {
    List<FoodItem> filtered = items;

    // A. Filtrage par catégorie
    if (filter.selectedCategory != 'All') {
      filtered = filtered
          .where((item) =>
              item.category.toLowerCase() ==
              filter.selectedCategory.toLowerCase())
          .toList();
    }

    // B. Filtrage par recherche textuelle
    if (filter.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((item) => item.name
              .toLowerCase()
              .contains(filter.searchQuery.toLowerCase()))
          .toList();
    }

    // C. Tri par prix
    if (filter.sortBy == 'price_asc') {
      filtered.sort((a, b) {
        final priceA = double.tryParse(a.price) ?? 0.0;
        final priceB = double.tryParse(b.price) ?? 0.0;
        return priceA.compareTo(priceB);
      });
    } else if (filter.sortBy == 'price_desc') {
      filtered.sort((a, b) {
        final priceA = double.tryParse(a.price) ?? 0.0;
        final priceB = double.tryParse(b.price) ?? 0.0;
        return priceB.compareTo(priceA);
      });
    }

    return filtered;
  });
});