import 'package:flutter/material.dart';
import 'top_category_item.dart';

class TopCategoriesSection extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String selectedCategory;
  final Color selectedCategoryColor;
  final Function(String) onCategorySelected;
  final ScrollController scrollController;

  const TopCategoriesSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.selectedCategoryColor,
    required this.onCategorySelected,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 8),

          TopCategoryItem(
            icon: Icons.all_inclusive,
            label: "All",
            isSelected: selectedCategory == "all",
            selectedCategoryColor: selectedCategoryColor,
            thisCategoryColor: Colors.deepPurple,
            onTap: () => onCategorySelected("all"),
          ),
          ...categories.take(10).map((category) =>
              TopCategoryItem(
                icon: category["icon"],
                label: category["name"],
                isSelected: selectedCategory == category["name"],
                selectedCategoryColor: selectedCategoryColor,
                thisCategoryColor: category["color"],
                onTap: () => onCategorySelected(category["name"]),
              ),
          ).toList(),
        ],
      ),
    );
  }
}