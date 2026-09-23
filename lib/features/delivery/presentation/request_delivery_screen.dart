import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/features/delivery/presentation/widgets/package_type_selector.dart';
import 'package:unishare/features/delivery/presentation/widgets/location_picker.dart';
import 'package:unishare/features/delivery/presentation/widgets/price_breakdown.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:unishare/shared/widgets/uni_input.dart';

class RequestDeliveryScreen extends StatefulWidget {
  const RequestDeliveryScreen({super.key});

  @override
  State<RequestDeliveryScreen> createState() => _RequestDeliveryScreenState();
}

class _RequestDeliveryScreenState extends State<RequestDeliveryScreen> {
  final MockDataService _mockDataService = MockDataService();
  
  List<CampusLocation> _pickupLocations = [];
  List<CampusLocation> _dropLocations = [];
  CampusLocation? _pickupLocation;
  CampusLocation? _destination;
  PackageType _packageType = PackageType.document;
  PackageSize _packageSize = PackageSize.small;
  UrgencyLevel _urgency = UrgencyLevel.medium;
  final TextEditingController _noteController = TextEditingController();
  
  double _currentPrice = 15.0;
  
  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final pickup = await _mockDataService.getPickupLocations();
    final drop = await _mockDataService.getDropLocations();
    setState(() {
      _pickupLocations = pickup;
      _dropLocations = drop;
    });
  }

  void _calculatePrice() {
    double base = 10.0;
    
    // Distance mockup
    if (_pickupLocation != null && _destination != null) {
      if (_pickupLocation!.zone != _destination!.zone) {
        base += 10.0;
      } else {
        base += 5.0;
      }
    }
    
    // Size multiplier
    switch (_packageSize) {
      case PackageSize.small: base += 0; break;
      case PackageSize.medium: base += 5; break;
      case PackageSize.large: base += 15; break;
    }
    
    // Urgency multiplier
    switch (_urgency) {
      case UrgencyLevel.low: base *= 0.8; break;
      case UrgencyLevel.medium: base *= 1.0; break;
      case UrgencyLevel.high: base *= 1.5; break;
      case UrgencyLevel.urgent: base *= 2.0; break;
    }
    
    setState(() {
      _currentPrice = base.floorToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Request Delivery',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Where'),
            LocationPicker(
              hint: 'Pickup Location',
              icon: Icons.my_location_outlined,
              locations: _pickupLocations,
              selectedLocation: _pickupLocation,
              onLocationSelected: (loc) {
                setState(() => _pickupLocation = loc);
                _calculatePrice();
              },
            ),
            const SizedBox(height: 12),
            LocationPicker(
              hint: 'Drop Location',
              icon: Icons.location_on_outlined,
              locations: _dropLocations,
              selectedLocation: _destination,
              onLocationSelected: (loc) {
                setState(() => _destination = loc);
                _calculatePrice();
              },
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('What'),
            PackageTypeSelector(
              selectedType: _packageType,
              onTypeChanged: (type) {
                setState(() => _packageType = type);
                _calculatePrice();
              },
            ),
            
            const SizedBox(height: 16),
            Row(
              children: PackageSize.values.map((size) {
                final isSelected = size == _packageSize;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _packageSize = size);
                      _calculatePrice();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryLight : AppColors.scaffold,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.divider,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            size == PackageSize.small ? Icons.inventory_2_outlined :
                            size == PackageSize.medium ? Icons.inventory_outlined : Icons.all_inbox,
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            size.name.capitalize(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('When'),
            Row(
              children: UrgencyLevel.values.map((level) {
                final isSelected = level == _urgency;
                Color color;
                switch (level) {
                  case UrgencyLevel.low: color = const Color(0xFF8E8E93); break;
                  case UrgencyLevel.medium: color = const Color(0xFF007AFF); break;
                  case UrgencyLevel.high: color = const Color(0xFFFF9500); break;
                  case UrgencyLevel.urgent: color = const Color(0xFFFF3B30); break;
                }
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _urgency = level);
                      _calculatePrice();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withValues(alpha: 0.1) : AppColors.scaffold,
                        border: Border.all(
                          color: isSelected ? color : AppColors.divider,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        level.name.capitalize(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? color : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            UniInput(
              controller: _noteController,
              label: 'Additional Notes (Optional)',
              hint: 'e.g., Handle with care, Call on arrival',
              maxLines: 2,
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(color: AppColors.divider),
            ),
            
            PriceBreakdown(
              suggestedPrice: _currentPrice,
              maxPrice: _currentPrice * 2,
              currentPrice: _currentPrice,
              onPriceChanged: (val) {
                setState(() => _currentPrice = val);
              },
            ),
            
            const SizedBox(height: 32),
            UniButton(
              onPressed: () async {
<<<<<<< HEAD
                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);
                final pickupId = _pickupLocation?.id ?? (_locations.isNotEmpty ? _locations.first.id : 'loc_gate');
                final destId = _destination?.id ?? (_locations.length > 1 ? _locations[1].id : 'loc_kumaon');
=======
                final pickupId = _pickupLocation?.id ?? (_pickupLocations.isNotEmpty ? _pickupLocations.first.id : 'loc_gate');
                final destId = _destination?.id ?? (_dropLocations.isNotEmpty ? _dropLocations.first.id : 'loc_a_block');
>>>>>>> 59bbd76c4b00f8ea6674adbf9de5b1ca190a1162
                final currentUser = await _mockDataService.getCurrentUser();
                
                final newReq = DeliveryRequest(
                  id: 'd_${DateTime.now().millisecondsSinceEpoch}',
                  requesterId: currentUser.id,
                  pickupLocationId: pickupId,
                  destinationId: destId,
                  packageType: _packageType,
                  packageSize: _packageSize,
                  note: _noteController.text.isNotEmpty ? _noteController.text : 'Campus delivery',
                  reward: _currentPrice,
                  priceCeiling: _currentPrice * 2,
                  preferredTime: DateTime.now().add(const Duration(hours: 1)),
                  urgency: _urgency,
                  status: DeliveryStatus.open,
                  createdAt: DateTime.now(),
                );

                await _mockDataService.addDeliveryRequest(newReq);

                if (mounted) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('Delivery request posted successfully!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                  navigator.pop(true);
                }
              },
              label: 'Post Request',
              variant: UniButtonVariant.primary,
              isFullWidth: true,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}

