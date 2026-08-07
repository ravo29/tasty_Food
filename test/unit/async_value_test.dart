import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';
import 'package:tasty_food/features/menu/providers/filter_provider.dart';
import 'package:tasty_food/features/cart/providers/cart_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AsyncValue Error Handling Tests', () {
    test('foodListProvider handles loading state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final asyncFoodList = container.read(foodListProvider);
      
      expect(asyncFoodList.isLoading, true);
    });

    test('foodListProvider resolves to data state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final foodList = await container.read(foodListProvider.future);
      
      expect(foodList, isNotEmpty);
    });
  });

  group('Loading State UI Tests', () {
    test('StateNotifier providers emit correct states', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cart = container.read(cartProvider);
      
      expect(cart, isA<List>());
      expect(cart, isNotEmpty);
    });

    test('StateProvider emits initial state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final category = container.read(selectedCategoryProvider);
      
      expect(category, 'All');
    });

    test('searchQueryProvider can be updated', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(searchQueryProvider.notifier).state = 'burger';
      
      expect(container.read(searchQueryProvider), 'burger');
    });
  });
}