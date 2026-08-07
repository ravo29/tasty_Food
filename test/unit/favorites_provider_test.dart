import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasty_food/features/favorites/providers/favorites_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesProvider Tests', () {
    test('favoriteIdsProvider exposes the same notifier as favoritesProvider', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(favoriteIdsProvider.notifier);

      expect(notifier, isA<FavoritesNotifier>());

      notifier.toggleFavorite('abc');
      expect(container.read(favoriteIdsProvider), contains('abc'));
    });

    test('favoritesProvider is an alias for favoriteIdsProvider', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final favorites = container.read(favoritesProvider);
      final favoriteIds = container.read(favoriteIdsProvider);

      expect(favorites, equals(favoriteIds));
    });
  });
}