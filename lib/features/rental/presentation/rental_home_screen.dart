import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'widgets/category_grid.dart';
import 'widgets/rental_card.dart';
import 'widgets/filter_sheet.dart';

class RentalHomeScreen extends StatefulWidget {
  const RentalHomeScreen({Key? key}) : super(key: key);

  @override
  _RentalHomeScreenState createState() => _RentalHomeScreenState();
}

class _RentalHomeScreenState extends State<RentalHomeScreen> {
  String _selectedCategory = 'All';
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  // Mock data for display
  final List<Map<String, dynamic>> _mockItems = [
    {
      'id': '1',
      'name': 'Scientific Calculator fx-991EX',
      'ownerName': 'Rahul Sharma',
      'pricePerDay': 20,
      'rating': 4.8,
      'category': 'Calculators',
    },
    {
      'id': '2',
      'name': 'Arduino Uno R3 Kit',
      'ownerName': 'Priya Patel',
      'pricePerDay': 50,
      'rating': 4.5,
      'category': 'Electronics',
    },
    {
      'id': '3',
      'name': 'Engineering Drawing Board',
      'ownerName': 'Amit Kumar',
      'pricePerDay': 30,
      'rating': 4.2,
      'category': 'Tools',
    },
    {
      'id': '4',
      'name': 'Digital Multimeter',
      'ownerName': 'Neha Gupta',
      'pricePerDay': 40,
      'rating': 4.9,
      'category': 'Lab Equipment',
    }
  ];

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedCategory == 'All' 
        ? _mockItems 
        : _mockItems.where((item) => item['category'] == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Rentals',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1A1A1A)),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/rentals/new'),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'List Item',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => setState(() => _isSearchExpanded = true),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E5EA)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFF8E8E93)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _isSearchExpanded
                            ? TextField(
                                controller: _searchController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: 'Search items...',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: GoogleFonts.inter(fontSize: 16),
                              )
                            : Text(
                                'Search items...',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF8E8E93),
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      if (_isSearchExpanded)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearchExpanded = false;
                              _searchController.clear();
                            });
                          },
                          child: const Icon(Icons.close, color: Color(0xFF8E8E93)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Categories',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CategoryGrid(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (cat) {
                      setState(() => _selectedCategory = cat);
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Items',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    'See all',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF00BF6D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            sliver: filteredItems.isEmpty 
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Icon(Icons.search_off, color: Color(0xFF8E8E93)),
                            const SizedBox(height: 16),
                            Text(
                              'No items found',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF6B6B6B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return RentalCard(
                          item: filteredItems[index],
                          onTap: () => context.push('/rentals/detail/${filteredItems[index]['id']}'),
                        );
                      },
                      childCount: filteredItems.length,
                    ),
                  ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
