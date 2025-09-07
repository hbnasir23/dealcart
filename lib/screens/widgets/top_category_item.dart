import 'package:flutter/material.dart';

class TopCategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color selectedCategoryColor;
  final Color? thisCategoryColor;
  final VoidCallback onTap;

  const TopCategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedCategoryColor,
    this.thisCategoryColor,
    required this.onTap,
  });

  Color lightenColor(Color color, [double amount = 0.8]) {
    return Color.lerp(color, Colors.white, amount)!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : lightenColor(selectedCategoryColor, 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? (thisCategoryColor ?? selectedCategoryColor) : Colors.black87,
            ),
            const SizedBox(height: 6),
            Text(
              label.replaceAll("-", " "),
              style: TextStyle(
                fontSize: isSelected ? 14 : 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black87 : Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
