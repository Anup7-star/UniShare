import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:unishare/shared/widgets/uni_input.dart';
import 'package:go_router/go_router.dart';

class DeliveryCompleteScreen extends StatefulWidget {
  final String deliveryId;
  const DeliveryCompleteScreen({super.key, required this.deliveryId});

  @override
  State<DeliveryCompleteScreen> createState() => _DeliveryCompleteScreenState();
}

class _DeliveryCompleteScreenState extends State<DeliveryCompleteScreen> with SingleTickerProviderStateMixin {
  final MockDataService _mockDataService = MockDataService();
  
  DeliveryRequest? _request;
  UniUser? _partner;
  CampusLocation? _pickup;
  CampusLocation? _destination;
  bool _isLoading = true;
  
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadData();
    
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    
    _animController.forward();
  }

  Future<void> _loadData() async {
    final deliveries = await _mockDataService.getDeliveryRequests();
    final request = deliveries.firstWhere((d) => d.id == widget.deliveryId, orElse: () => deliveries.first);
    final currentUser = await _mockDataService.getCurrentUser();
    
    final isRequester = currentUser.id == request.requesterId;
    
    final partnerId = isRequester ? request.courierId : request.requesterId;
    final partner = partnerId != null ? await _mockDataService.getUserById(partnerId) : null;
    
    final pickup = await _mockDataService.getLocationById(request.pickupLocationId);
    final destination = await _mockDataService.getLocationById(request.destinationId);
    
    setState(() {
      _request = request;
      _partner = partner;
      _pickup = pickup;
      _destination = destination;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              
              // Success Animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 80,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Delivery Complete!',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Route', style: GoogleFonts.inter(color: AppColors.textSecondary)),
                        Text('${_pickup?.name} → ${_destination?.name}', 
                          style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time Taken', style: GoogleFonts.inter(color: AppColors.textSecondary)),
                        Text('14 mins', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Reward', style: GoogleFonts.inter(color: AppColors.textSecondary)),
                        Text('₹${_request!.reward.toStringAsFixed(0)}', 
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            fontSize: 16,
                          )),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              if (_partner != null) ...[
                Text(
                  'Rate your experience with ${_partner!.name}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: index < _rating ? AppColors.warning : AppColors.textTertiary,
                          size: 48,
                        ),
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 24),
                
                UniInput(
                  controller: _feedbackController,
                  label: '',
                  hint: 'Leave an optional feedback...',
                  maxLines: 3,
                ),
              ],
              
              const SizedBox(height: 32),
              
              UniButton(
                onPressed: () {
                  context.go('/delivery');
                },
                label: 'Submit Rating',
                variant: UniButtonVariant.primary,
                isFullWidth: true,
                isDisabled: _rating == 0,
              ),
              
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: () {
                  context.go('/delivery');
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }
}

