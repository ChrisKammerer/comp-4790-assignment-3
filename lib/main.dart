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
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            cardTheme: CardThemeData(
              shadowColor: Colors.grey[300],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            switchTheme: SwitchThemeData(
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.blueGrey;
                }
                return Colors.grey;
              }),
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.blueGrey[200];
                }
                return Colors.grey[300];
              }),
            )
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black
          ),
          themeMode: favoritesProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: ContentView(),
        );
      })

    );
  }
}