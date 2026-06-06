import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final cities = sampleCities;
  final hobbies = sampleHobbies;
  final books = sampleBooks;
  bool isDarkMode = false;

  FavoritesProvider() {
    loadFavorites();
    loadDarkModePreference();
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

    final favoriteBookIDs = books
    .where((book) => book.isFavorite)
    .map((book) => book.id.toString())
    .toList();

    await prefs.setStringList("favoriteCities", favoriteCityIDs);
    await prefs.setStringList("favoriteHobbies", favoriteHobbyIDs);
    await prefs.setStringList("favoriteBooks", favoriteBookIDs);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteCityIDs = prefs.getStringList('favoriteCities') ?? []; 
    final favoriteHobbyIDs = prefs.getStringList('favoriteHobbies') ?? [];
    final favoriteBookIDs = prefs.getStringList('favoriteBooks') ?? [];
    for(final city in cities) {
      city.isFavorite = favoriteCityIDs.contains(city.id.toString());
    }

    for(final hobby in hobbies) {
      hobby.isFavorite = favoriteHobbyIDs.contains(hobby.id.toString());
    }

    for(final book in books) {
      book.isFavorite = favoriteBookIDs.contains(book.id.toString());
    }

    notifyListeners();
  }

  Future<void> saveDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", isDarkMode);
  }

  Future<void> loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool("isDarkMode") ?? false;
    notifyListeners();
  }

  Future<void> clearFavorites() async {
    for (final city in cities) {
      city.isFavorite = false;
    }

    for (final hobby in hobbies) {
      hobby.isFavorite = false;
    }

    for (final book in books) {
      book.isFavorite = false;
    }

    saveFavorites();
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

  void toggleBookFavorite(int bookId) {
    final book = books.firstWhere((book) => book.id == bookId);
    book.isFavorite = !book.isFavorite;

    saveFavorites();

    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    saveDarkModePreference();
    notifyListeners();
  }
}