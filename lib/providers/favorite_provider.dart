import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class FavoritesProvider extends ChangeNotifier {
  final cities = sampleCities;
  final hobbies = sampleHobbies;

  void toggleCityFavorite(int cityId) {
    final city = cities.firstWhere((city) => city.id == cityId);
    city.isFavorite = !city.isFavorite;
    notifyListeners();
  }

  void toggleHobbyFavorite(int hobbyId) {
    final hobby = hobbies.firstWhere((hobby) => hobby.id == hobbyId);
    hobby.isFavorite = !hobby.isFavorite;
    notifyListeners();
  }
}