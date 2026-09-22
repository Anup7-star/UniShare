import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryGrid extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategoryGrid({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': Icons.grid_view},
    {'name': 'Books', 'icon': Icons.menu_book},
    {'name': 'Calculators', 'icon': Icons.calculate},
    {'name': 'Electronics', 'icon': Icons.computer},
    {'name': 'Tools', 'icon': Icons.handyman},
    {'name': 'Lab Equipment', 'icon': Icons.science},
    {'name': 'Sports', 'icon': Icons.sports_basketball},
    {'name': 'Other', 'icon': Icons.category},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) {
          final isSelected = category['name'] == selectedCategory;
          return GestureDetector(
            onTap: () => onCategorySelected(category['name']),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE6F9F0) : const Color(0xFFFAFAFA),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFFE5E5EA),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      category['icon'],
                      color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFF6B6B6B),
                      ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFF6B6B6B),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
