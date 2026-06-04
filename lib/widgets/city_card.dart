import 'package:favorites/models/city_model.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final CityModel city;
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Image.asset(
              "assets/images/${city.cityImage}.jpeg",
              fit: BoxFit.cover,
            )
          ),
          Positioned(
            top: 5,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(city.cityName),
                Icon(city.isFavorite ? Icons.favorite : Icons.favorite_border)
              ]
            )
          )
        ],
      )
    );
  }
}