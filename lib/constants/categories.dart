import 'package:flutter/material.dart';

class AppCategories {
  static final List<Map<String, dynamic>> allCategories = [
    {"name": "smartphones", "icon": Icons.smartphone, "color": Colors.blue},
    {"name": "laptops", "icon": Icons.laptop, "color": Colors.green},
    {"name": "fragrances", "icon": Icons.spa, "color": Colors.purple},
    {"name": "skincare", "icon": Icons.face, "color": Colors.pink},
    {"name": "groceries", "icon": Icons.shopping_basket, "color": Colors.orange},
    {"name": "home-decoration", "icon": Icons.home, "color": Colors.brown},
    {"name": "furniture", "icon": Icons.chair, "color": Colors.teal},
    {"name": "tops", "icon": Icons.checkroom, "color": Colors.red},
    {"name": "womens-dresses", "icon": Icons.woman, "color": Colors.pinkAccent},
    {"name": "womens-shoes", "icon": Icons.shopping_bag, "color": Colors.purpleAccent},
    {"name": "mens-shirts", "icon": Icons.man, "color": Colors.blueAccent},
    {"name": "mens-shoes", "icon": Icons.directions_walk, "color": Colors.greenAccent},
    {"name": "mens-watches", "icon": Icons.watch, "color": Colors.cyan},
    {"name": "womens-watches", "icon": Icons.watch_later, "color": Colors.amber},
    {"name": "womens-bags", "icon": Icons.work, "color": Colors.deepOrange},
    {"name": "womens-jewellery", "icon": Icons.diamond, "color": Colors.yellow},
    {"name": "sunglasses", "icon": Icons.visibility, "color": Colors.indigo},
    {"name": "automotive", "icon": Icons.directions_car, "color": Colors.blueGrey},
    {"name": "motorcycle", "icon": Icons.motorcycle, "color": Colors.deepPurple},
    {"name": "lighting", "icon": Icons.lightbulb, "color": Colors.yellowAccent},
  ];

  static Map<String, dynamic>? findCategoryByName(String name) {
    try {
      return allCategories.firstWhere((category) => category["name"] == name);
    } catch (e) {
      return null;
    }
  }

  static Color getCategoryColor(String name) {
    final category = findCategoryByName(name);
    return category != null ? category["color"] as Color : Colors.grey;
  }
}