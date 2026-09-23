import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemScreen extends StatefulWidget {
  const ListItemScreen({super.key});

  @override
  State<ListItemScreen> createState() => _ListItemScreenState();
}

class _ListItemScreenState extends State<ListItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCondition = 'New';
  String _selectedCategory = 'Electronics';
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'List an Item',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border(top: BorderSide(color: const Color(0xFFE5E5EA))),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                'List Item',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Photos',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildPhotoPlaceholder(),
                  const SizedBox(width: 12),
                  _buildPhotoPlaceholder(),
                  const SizedBox(width: 12),
                  _buildPhotoPlaceholder(),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                ),
                style: GoogleFonts.inter(color: const Color(0xFF1A1A1A)),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                ),
                items: ['Books', 'Calculators', 'Electronics', 'Tools', 'Lab Equipment', 'Sports', 'Other']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.inter())))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                ),
                style: GoogleFonts.inter(color: const Color(0xFF1A1A1A)),
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
                children: ['New', 'Good', 'Fair', 'Worn'].map((c) {
                  final isSelected = _selectedCondition == c;
                  return ChoiceChip(
                    label: Text(c),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() => _selectedCondition = c);
                    },
                    selectedColor: const Color(0xFFE6F9F0),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price per day',
                        prefixText: '₹ ',
                        labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                      ),
                      style: GoogleFonts.inter(color: const Color(0xFF1A1A1A)),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Deposit (Optional)',
                        prefixText: '₹ ',
                        labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                      ),
                      style: GoogleFonts.inter(color: const Color(0xFF1A1A1A)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: GoogleFonts.inter(color: const Color(0xFF8E8E93)),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE5E5EA))),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00BF6D))),
                ),
                items: ['Hostel A', 'Hostel B', 'Library', 'Main Gate']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.inter())))
                    .toList(),
                onChanged: (val) {},
              ),
              const SizedBox(height: 24),
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
                value: _isAvailable,
                onChanged: (val) => setState(() => _isAvailable = val),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5EA), style: BorderStyle.solid),
      ),
      child: const Center(
        child: Icon(Icons.add_a_photo, color: Color(0xFF8E8E93)),
      ),
    );
  }
}
