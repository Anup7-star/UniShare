import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPicker extends StatelessWidget {
  final CampusLocation? selectedLocation;
  final List<CampusLocation> locations;
  final ValueChanged<CampusLocation> onLocationSelected;
  final String hintText;
  final IconData icon;

  LocationPicker({
    Key? key,
    required this.selectedLocation,
    required this.locations,
    required this.onLocationSelected,
    String? hintText,
    String? hint,
    this.icon = Icons.location_on_outlined,
  })  : hintText = hintText ?? hint ?? 'Select Location',
        super(key: key);

  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: AppColors.scaffold,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            final Map<String, List<CampusLocation>> groupedLocations = {};
            for (var loc in locations) {
              groupedLocations.putIfAbsent(loc.type, () => []).add(loc);
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    hintText,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.divider),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: groupedLocations.keys.length,
                    itemBuilder: (context, index) {
                      final type = groupedLocations.keys.elementAt(index);
                      final typeLocations = groupedLocations[type]!;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              type.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ),
                          ...typeLocations.map((loc) => ListTile(
                            leading: Icon(
                              _getIconForType(loc.type),
                              color: AppColors.primary,
                            ),
                            title: Text(
                              loc.name,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: loc.description != null
                                ? Text(
                                    loc.description!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              onLocationSelected(loc);
                              Navigator.pop(context);
                            },
                          )),
                          const Divider(color: AppColors.divider),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'hostel': return Icons.home_work_outlined;
      case 'gate': return Icons.door_front_door_outlined;
      case 'academic': return Icons.school_outlined;
      case 'canteen': return Icons.restaurant_outlined;
      default: return Icons.location_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showLocationBottomSheet(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedLocation?.name ?? hintText,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: selectedLocation != null ? AppColors.textPrimary : AppColors.textTertiary,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
