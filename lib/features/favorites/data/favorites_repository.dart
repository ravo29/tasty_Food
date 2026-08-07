import 'package:shared_preferences/shared_preferences.dart';

/// Repository pour la persistance des favoris
/// Sépare la logique de données de la logique métier
abstract class FavoritesRepository {
  Future<List<String>> loadFavorites();
  Future<bool> saveFavorites(List<String> favorites);
  Future<bool> clearFavorites();
}

class SharedPreferencesFavoritesRepository implements FavoritesRepository {
  static const String _favoritesKey = 'favorite_ids';

  @override
  Future<List<String>> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_favoritesKey) ?? [];
    } catch (e) {
      print('Error loading favorites from repository: $e');
      return [];
    }
  }

  @override
  Future<bool> saveFavorites(List<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setStringList(_favoritesKey, favorites);
    } catch (e) {
      print('Error saving favorites from repository: $e');
      return false;
    }
  }

  @override
  Future<bool> clearFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_favoritesKey);
    } catch (e) {
      print('Error clearing favorites from repository: $e');
      return false;
    }
  }
}