import 'package:favorites/models/hobby_model.dart';
import 'package:flutter/material.dart';

class HobbyCard extends StatelessWidget {
  final HobbyModel hobby;
  const HobbyCard({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(hobby.hobbyIcon, style: TextStyle(fontSize: 24)),
        title: Text(hobby.hobbyName),
        trailing: Icon(hobby.isFavorite ? Icons.favorite : Icons.favorite_border)
      )
    );
  }
}