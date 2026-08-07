import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';
import 'package:tasty_food/features/menu/models/food_item.dart';
import 'package:tasty_food/features/menu/providers/filter_provider.dart';
import 'package:tasty_food/features/menu/providers/food_list_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('favoriteIdsProvider exposes the same notifier as favoritesProvider', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(favoriteIdsProvider.notifier);

    expect(notifier, isA<FavoritesNotifier>());

    notifier.toggleFavorite('abc');
    expect(container.read(favoriteIdsProvider), contains('abc'));
  });

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
    final items = result.when(
      data: (value) => value,
      loading: () => <FoodItem>[],
      error: (error, stackTrace) => <FoodItem>[],
    );

    expect(items, hasLength(1));
    expect(items.first.name, 'Beef Burger');
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
    final items = result.when(
      data: (value) => value,
      loading: () => <FoodItem>[],
      error: (error, stackTrace) => <FoodItem>[],
    );

    expect(items, hasLength(1));
    expect(items.first.name, 'Beef Burger');
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
    final items = result.when(
      data: (value) => value,
      loading: () => <FoodItem>[],
      error: (error, stackTrace) => <FoodItem>[],
    );

    expect(items, hasLength(2));
    expect(items.first.price, 5.99);
    expect(items.last.price, 15.99);
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
    final items = result.when(
      data: (value) => value,
      loading: () => <FoodItem>[],
      error: (error, stackTrace) => <FoodItem>[],
    );

    expect(items, hasLength(2));
    expect(items.first.price, 15.99);
    expect(items.last.price, 5.99);
  });
}