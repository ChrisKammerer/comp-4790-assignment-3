import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final cities = sampleCities;
  final hobbies = sampleHobbies;
  bool isDarkMode = false;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIDs = cities
    .where((city) => city.isFavorite)
    .map((city) => city.id.toString())
    .toList();

    await prefs.setStringList("favoriteCities", favoriteIDs);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIDs = prefs.getStringList('favoriteCities') ?? []; 

    for(final city in cities) {
      city.isFavorite = favoriteIDs.contains(city.id.toString());
    }

    notifyListeners();
  }

  void toggleCityFavorite(int cityId) {
    final city = cities.firstWhere((city) => city.id == cityId);
    city.isFavorite = !city.isFavorite;

    saveFavorites();

    notifyListeners();
  }

  void toggleHobbyFavorite(int hobbyId) {
    final hobby = hobbies.firstWhere((hobby) => hobby.id == hobbyId);
    hobby.isFavorite = !hobby.isFavorite;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = true;
    notifyListeners();
  }
}