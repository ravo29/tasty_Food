import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodFilterState {
  final String selectedCategory;
  final String searchQuery;

  const FoodFilterState({
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  FoodFilterState copyWith({
    String? selectedCategory,
    String? searchQuery,
  }) {
    return FoodFilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class FoodFilterNotifier extends StateNotifier<FoodFilterState> {
  FoodFilterNotifier() : super(const FoodFilterState());

  void setSelectedCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void resetFilters() {
    state = const FoodFilterState();
  }
}

final foodFilterProvider = StateNotifierProvider<FoodFilterNotifier, FoodFilterState>((ref) {
  return FoodFilterNotifier();
});