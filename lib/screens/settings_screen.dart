import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: SafeArea(child:
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Settings",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            )
            ),
            SizedBox(height: 48),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.dark_mode),
                    title: Text("Dark Mode"),
                    trailing: Switch(value: favoritesProvider.isDarkMode,
                    onChanged: (value) {
                      favoritesProvider.toggleDarkMode(value);
                    })
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  child: ListTile(
                    title: Text("Clear Favorites", style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text("Clear Favorites"),
                          content: Text("Are you sure you want to clear all favorites? This action cannot be undone."),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("Cancel")),
                            TextButton(onPressed: () {
                              favoritesProvider.clearFavorites();
                              Navigator.pop(context);
                            }, child: Text("Clear", style: TextStyle(color: Colors.red)))
                          ],
                        );
                    }
                    );
                  }
                )
                )
              ]
            )
          ]
        ),)),
    );
  }
}