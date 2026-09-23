import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String _selectedCondition = 'Any';
  double _maxPrice = 500;
  bool _availableNow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF1A1A1A)),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Condition',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ['Any', 'New', 'Good', 'Fair'].map((c) {
              final isSelected = _selectedCondition == c;
              return FilterChip(
                label: Text(c),
                selected: isSelected,
                onSelected: (val) {
                  setState(() => _selectedCondition = c);
                },
                selectedColor: const Color(0xFFE6F9F0),
                checkmarkColor: const Color(0xFF00BF6D),
                labelStyle: GoogleFonts.inter(
                  color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFF1A1A1A),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isSelected ? const Color(0xFF00BF6D) : const Color(0xFFE5E5EA),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Max Price Per Day: ₹${_maxPrice.toInt()}',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          Slider(
            value: _maxPrice,
            min: 0,
            max: 2000,
            divisions: 20,
            activeColor: const Color(0xFF00BF6D),
            inactiveColor: const Color(0xFFE5E5EA),
            onChanged: (val) {
              setState(() => _maxPrice = val);
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Available Now',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            activeThumbColor: const Color(0xFF00BF6D),
            value: _availableNow,
            onChanged: (val) => setState(() => _availableNow = val),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'condition': _selectedCondition,
                  'maxPrice': _maxPrice,
                  'availableNow': _availableNow,
                });
              },
              child: Text(
                'Apply Filters',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
