import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';
import 'package:tasty_food/features/favorites/data/favorites_repository.dart';

// Mock repository pour les tests
class MockFavoritesRepository implements FavoritesRepository {
  final List<String> _storage = [];

  @override
  Future<List<String>> loadFavorites() async {
    return List.from(_storage);
  }

  @override
  Future<bool> saveFavorites(List<String> favorites) async {
    _storage.clear();
    _storage.addAll(favorites);
    return true;
  }

  @override
  Future<bool> clearFavorites() async {
    _storage.clear();
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesNotifier Tests', () {
    test('FavoritesNotifier should initialize with empty list', () {
      final repository = MockFavoritesRepository();
      final container = ProviderContainer(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final favorites = container.read(favoriteIdsProvider);
      
      expect(favorites, isEmpty);
    });

    test('FavoritesNotifier should toggle favorite correctly', () async {
      final repository = MockFavoritesRepository();
      final container = ProviderContainer(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(favoriteIdsProvider.notifier);
      
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Add favorite
      await notifier.toggleFavorite('item1');
      expect(container.read(favoriteIdsProvider), contains('item1'));
      
      // Remove favorite
      await notifier.toggleFavorite('item1');
      expect(container.read(favoriteIdsProvider), isNot(contains('item1')));
    });

    test('FavoritesNotifier should check isFavorite correctly', () async {
      final repository = MockFavoritesRepository();
      final container = ProviderContainer(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(favoriteIdsProvider.notifier);
      
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 100));
      
      await notifier.toggleFavorite('item1');
      
      expect(notifier.isFavorite('item1'), true);
      expect(notifier.isFavorite('item2'), false);
    });

    test('MockFavoritesRepository should load and save favorites', () async {
      final repository = MockFavoritesRepository();
      
      // Save favorites
      final saveResult = await repository.saveFavorites(['item1', 'item2']);
      expect(saveResult, true);
      
      // Load favorites
      final loadedFavorites = await repository.loadFavorites();
      expect(loadedFavorites, contains('item1'));
      expect(loadedFavorites, contains('item2'));
      
      // Clear favorites
      final clearResult = await repository.clearFavorites();
      expect(clearResult, true);
      
      // Verify cleared
      final clearedFavorites = await repository.loadFavorites();
      expect(clearedFavorites, isEmpty);
    });

    test('favoritesLoadingProvider should load favorites', () async {
      final repository = MockFavoritesRepository();
      final container = ProviderContainer(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final asyncFavorites = container.read(favoritesLoadingProvider);
      
      expect(asyncFavorites, isA<AsyncValue<List<String>>>());
    });
  });
}