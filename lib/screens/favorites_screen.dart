import 'package:flutter/material.dart';
import '/widgets/city_card.dart';
import '/widgets/hobby_card.dart';
import '/widgets/book_card.dart';
import '/data/sample_data.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

enum ContentCategory { cities, hobbies, books }

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  ContentCategory selectedCategory = ContentCategory.cities;
  String searchText = "";

  String get searchHint => "Search favorite ${selectedCategory.name}";
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SegmentedButton(
                segments: [
                  ButtonSegment(
                    value: ContentCategory.cities,
                    label: Text("Cities"),
                  ),
                  ButtonSegment(
                    value: ContentCategory.hobbies,
                    label: Text("Hobbies"),
                  ),
                  ButtonSegment(
                    value: ContentCategory.books,
                    label: Text("Books"),
                  ),
                ],
                selected: {selectedCategory},
                onSelectionChanged: (selection) {
                  setState(() {
                    selectedCategory = selection.first;
                  });
                },
              ),

              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: searchHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),

              SizedBox(height: 16),

              Expanded(
                child: Builder(
                  builder: (context) {
                    switch (selectedCategory) {
                      case ContentCategory.cities:
                        final filteredCities = favoritesProvider.cities
                            .where((city) => city.isFavorite &&
                                city.cityName
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                            .toList();
                        return ListView.builder(
                          itemCount: filteredCities.length,
                          itemBuilder: (context, index) {
                            final city = filteredCities[index];
                            return CityCard(city: city);
                          },
                        );
                      case ContentCategory.hobbies:
                        final filteredHobbies = favoritesProvider.hobbies
                            .where((hobby) => hobby.isFavorite &&
                                hobby.hobbyName
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                            .toList();
                        return ListView.builder(
                          itemCount: filteredHobbies.length,
                          itemBuilder: (context, index) {
                            final hobby = filteredHobbies[index];
                            return HobbyCard(hobby: hobby);
                          },
                        );
                      case ContentCategory.books:
                        final filteredBooks = favoritesProvider.books
                            .where((book) => book.isFavorite &&
                                book.bookTitle
                                .toLowerCase()
                                .contains(searchText.toLowerCase()))
                            .toList();
                        return ListView.builder(
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            final book = filteredBooks[index];
                            return BookCard(book: book);
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}