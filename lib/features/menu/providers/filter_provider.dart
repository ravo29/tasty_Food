import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
final sortByPriceProvider = StateProvider<String>((ref) => 'none');
final searchQueryProvider = StateProvider<String>((ref) => '');

final menuProductsProvider = foodListProvider;

final filteredMenuProvider = Provider<AsyncValue<List<FoodItem>>>((ref) {
  final asyncProducts = ref.watch(menuProductsProvider);
  final category = ref.watch(selectedCategoryProvider);
  final sortBy = ref.watch(sortByPriceProvider);
  final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();

  return asyncProducts.whenData((products) {
    List<FoodItem> filtered = category == 'All'
        ? List.from(products)
        : products.where((product) => product.category == category).toList();

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final name = product.name.toLowerCase();
        return name.contains(searchQuery);
      }).toList();
    }

    if (sortBy == 'price_asc') {
      filtered.sort((a, b) {
        final priceA = double.tryParse(a.price) ?? 0.0;
        final priceB = double.tryParse(b.price) ?? 0.0;
        return priceA.compareTo(priceB);
      });
    } else if (sortBy == 'price_desc') {
      filtered.sort((a, b) {
        final priceA = double.tryParse(a.price) ?? 0.0;
        final priceB = double.tryParse(b.price) ?? 0.0;
        return priceB.compareTo(priceA);
      });
    }

    return filtered;
  });
});