import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/campus_graph_view.dart';
import 'widgets/node_marker.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({Key? key}) : super(key: key);

  @override
  _CampusMapScreenState createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _nodes = [
    {'id': 'gate', 'x': 100.0, 'y': 500.0, 'name': 'Main Gate', 'type': 'gate', 'color': Color(0xFFFF9500)},
    {'id': 'lib', 'x': 250.0, 'y': 350.0, 'name': 'Library', 'type': 'academic', 'color': Color(0xFF007AFF)},
    {'id': 'hostel_a', 'x': 400.0, 'y': 200.0, 'name': 'Hostel A', 'type': 'hostel', 'color': Color(0xFF00BF6D)},
    {'id': 'hostel_b', 'x': 450.0, 'y': 400.0, 'name': 'Hostel B', 'type': 'hostel', 'color': Color(0xFF00BF6D)},
    {'id': 'canteen', 'x': 300.0, 'y': 250.0, 'name': 'Canteen', 'type': 'food', 'color': Color(0xFFFF3B30)},
  ];

  final List<Map<String, dynamic>> _edges = [
    {'from': 'gate', 'to': 'lib', 'distance': 150},
    {'from': 'lib', 'to': 'canteen', 'distance': 80},
    {'from': 'canteen', 'to': 'hostel_a', 'distance': 50},
    {'from': 'lib', 'to': 'hostel_b', 'distance': 200},
    {'from': 'canteen', 'to': 'hostel_b', 'distance': 120},
  ];

  void _showNodeDetails(Map<String, dynamic> node) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: node['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on, color: node['color']),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node['name'],
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      Text(
                        node['type'].toString().toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF8E8E93),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Set as Delivery Location',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredNodes = _selectedFilter == 'All'
        ? _nodes
        : _nodes.where((n) => n['type'] == _selectedFilter.toLowerCase()).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Campus Map',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF1A1A1A)),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: ['All', 'Gate', 'Academic', 'Hostel', 'Food'].map((f) {
                final isSelected = _selectedFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(f),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedFilter = f),
                    selectedColor: const Color(0xFFE6F9F0),
                    checkmarkColor: const Color(0xFF00BF6D),
                    labelStyle: GoogleFonts.inter(
                      color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFF6B6B6B),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFFE5E5EA),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 0.5,
        maxScale: 2.0,
        constrained: false,
        child: SizedBox(
          width: 1000,
          height: 1000,
          child: Stack(
            children: [
              CustomPaint(
                size: const Size(1000, 1000),
                painter: CampusGraphPainter(nodes: _nodes, edges: _edges),
              ),
              ...filteredNodes.map((node) {
                return Positioned(
                  left: node['x'] - 24, // center alignment roughly
                  top: node['y'] - 24,
                  child: GestureDetector(
                    onTap: () => _showNodeDetails(node),
                    child: NodeMarker(
                      label: node['name'],
                      color: node['color'],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
