import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/filter_provider.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FilterProvider Tests', () {
    test('filteredMenuProvider filters products by selected category', () async {
      final sampleItems = [
        const FoodItem(
          id: '1',
          name: 'Beef Burger',
          category: 'Burger',
          price: 7.99,
          image: 'assets/images/RoastChicken.png',
          description: 'Burger',
          calories: '450 kcal',
        ),
        const FoodItem(
          id: '2',
          name: 'Chicken Pasta',
          category: 'Pasta',
          price: 9.50,
          image: 'assets/images/RoastChicken.png',
          description: 'Pasta',
          calories: '520 kcal',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          foodListProvider.overrideWith((ref) async => sampleItems),
        ],
      );
      addTearDown(container.dispose);

      container.read(selectedCategoryProvider.notifier).state = 'Burger';

      await container.read(foodListProvider.future);
      final result = container.read(filteredMenuProvider);

      expect(result, hasLength(1));
      expect(result.first.name, 'Beef Burger');
    });

    test('filteredMenuProvider filters by search query', () async {
      final sampleItems = [
        const FoodItem(
          id: '1',
          name: 'Beef Burger',
          category: 'Burger',
          price: 7.99,
          image: 'assets/images/burger.png',
          description: 'Burger',
          calories: '450 kcal',
        ),
        const FoodItem(
          id: '2',
          name: 'Chicken Pasta',
          category: 'Pasta',
          price: 9.50,
          image: 'assets/images/RoastChicken.png',
          description: 'Pasta',
          calories: '520 kcal',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          foodListProvider.overrideWith((ref) async => sampleItems),
        ],
      );
      addTearDown(container.dispose);

      container.read(searchQueryProvider.notifier).state = 'burger';

      await container.read(foodListProvider.future);
      final result = container.read(filteredMenuProvider);

      expect(result, hasLength(1));
      expect(result.first.name, 'Beef Burger');
    });

    test('filteredMenuProvider sorts by price ascending', () async {
      final sampleItems = [
        const FoodItem(
          id: '1',
          name: 'Cheap Item',
          category: 'Burger',
          price: 5.99,
          image: 'assets/images/burger.png',
          description: 'Cheap',
          calories: '400 kcal',
        ),
        const FoodItem(
          id: '2',
          name: 'Expensive Item',
          category: 'Burger',
          price: 15.99,
          image: 'assets/images/burger.png',
          description: 'Expensive',
          calories: '600 kcal',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          foodListProvider.overrideWith((ref) async => sampleItems),
        ],
      );
      addTearDown(container.dispose);

      container.read(sortByPriceProvider.notifier).state = 'price_asc';

      await container.read(foodListProvider.future);
      final result = container.read(filteredMenuProvider);

      expect(result, hasLength(2));
      expect(result.first.price, 5.99);
      expect(result.last.price, 15.99);
    });

    test('filteredMenuProvider sorts by price descending', () async {
      final sampleItems = [
        const FoodItem(
          id: '1',
          name: 'Cheap Item',
          category: 'Burger',
          price: 5.99,
          image: 'assets/images/burger.png',
          description: 'Cheap',
          calories: '400 kcal',
        ),
        const FoodItem(
          id: '2',
          name: 'Expensive Item',
          category: 'Burger',
          price: 15.99,
          image: 'assets/images/burger.png',
          description: 'Expensive',
          calories: '600 kcal',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          foodListProvider.overrideWith((ref) async => sampleItems),
        ],
      );
      addTearDown(container.dispose);

      container.read(sortByPriceProvider.notifier).state = 'price_desc';

      await container.read(foodListProvider.future);
      final result = container.read(filteredMenuProvider);

      expect(result, hasLength(2));
      expect(result.first.price, 15.99);
      expect(result.last.price, 5.99);
    });
  });
}