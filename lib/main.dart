import 'package:flutter/material.dart';
import 'screens/content_view.dart';
import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';

void main() {
  runApp(const FavoritesApp());
}

class FavoritesApp extends StatelessWidget {
  const FavoritesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ContentView(),
      ),
    );
  }
}