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

    final favoriteCityIDs = cities
    .where((city) => city.isFavorite)
    .map((city) => city.id.toString())
    .toList();

    final favoriteHobbyIDs = hobbies
    .where((hobby) => hobby.isFavorite)
    .map((hobby) => hobby.id.toString())
    .toList();

    await prefs.setStringList("favoriteCities", favoriteCityIDs);
    await prefs.setStringList("favoriteHobbies", favoriteHobbyIDs);

  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteCityIDs = prefs.getStringList('favoriteCities') ?? []; 
    final favoriteHobbyIDs = prefs.getStringList('favoriteHobbies') ?? [];

    for(final city in cities) {
      city.isFavorite = favoriteCityIDs.contains(city.id.toString());
    }

    for(final hobby in hobbies) {
      hobby.isFavorite = favoriteHobbyIDs.contains(hobby.id.toString());
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

    saveFavorites(); 

    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}