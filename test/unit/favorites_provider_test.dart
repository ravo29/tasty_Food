import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';
import 'package:tasty_food/features/favorites/data/favorites_repository.dart';

/// A simple in-memory implementation of [FavoritesRepository] for tests.
class _InMemoryFavoritesRepository implements FavoritesRepository {
  List<String> _favorites = [];

  @override
  Future<bool> clearFavorites() async {
    _favorites = [];
    return true;
  }

  @override
  Future<List<String>> loadFavorites() async {
    return _favorites;
  }

  @override
  Future<bool> saveFavorites(List<String> favorites) async {
    _favorites = List.from(favorites);
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesProvider Tests', () {
    test('favoriteIdsProvider exposes the same notifier as favoritesProvider', () async {
      final container = ProviderContainer(overrides: [
        favoritesRepositoryProvider.overrideWithValue(_InMemoryFavoritesRepository()),
      ]);
      addTearDown(container.dispose);

      final notifier = container.read(favoriteIdsProvider.notifier);

      expect(notifier, isA<FavoritesNotifier>());

      // Ensure initial async loadFavorites completes before toggling.
      await container.read(favoritesLoadingProvider.future);

      await notifier.toggleFavorite('abc');
      expect(container.read(favoriteIdsProvider), contains('abc'));
    });

    test('favoritesProvider is an alias for favoriteIdsProvider', () {
      final container = ProviderContainer(overrides: [
        favoritesRepositoryProvider.overrideWithValue(_InMemoryFavoritesRepository()),
      ]);
      addTearDown(container.dispose);

      final favorites = container.read(favoritesProvider);
      final favoriteIds = container.read(favoriteIdsProvider);

      expect(favorites, equals(favoriteIds));
    });
  });
}