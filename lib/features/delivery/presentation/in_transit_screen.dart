import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:unishare/features/delivery/presentation/widgets/delivery_timeline.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/utils/communication_helper.dart';
import 'dart:async';

class InTransitScreen extends StatefulWidget {
  final String deliveryId;
  const InTransitScreen({super.key, required this.deliveryId});

  @override
  State<InTransitScreen> createState() => _InTransitScreenState();
}

class _InTransitScreenState extends State<InTransitScreen> with SingleTickerProviderStateMixin {
  final MockDataService _mockDataService = MockDataService();
  
  DeliveryRequest? _request;
  UniUser? _partner;
  CampusLocation? _pickup;
  CampusLocation? _destination;
  bool _isLoading = true;
  bool _isRequester = false;
  int _elapsedSeconds = 0;
  Timer? _timer;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _loadData();
    _startTimer();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  Future<void> _loadData() async {
    final deliveries = await _mockDataService.getDeliveryRequests();
    final request = deliveries.firstWhere((d) => d.id == widget.deliveryId, orElse: () => deliveries.first);
    final currentUser = await _mockDataService.getCurrentUser();
    
    _isRequester = currentUser.id == request.requesterId;
    
    final partnerId = _isRequester ? request.courierId : request.requesterId;
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

    final String timeStr = '${(_elapsedSeconds ~/ 60).toString().padLeft(2, '0')}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'In Transit',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status Card
            UniCard(
              padding: 24,
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Delivery In Progress',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeStr,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Route Info
            UniCard(
              padding: 16,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pickup?.name ?? 'Unknown',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Pickup', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward, color: AppColors.primary),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _destination?.name ?? 'Unknown',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 4),
                        Text('Destination', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            if (_partner != null) ...[
              UniCard(
                padding: 16,
                child: Row(
                  children: [
                    UniAvatar(imageUrl: _partner!.avatarUrl, name: _partner!.name, size: 48),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _partner!.name,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isRequester ? 'Courier' : 'Requester',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone, color: AppColors.primary),
                          tooltip: 'Call ${_isRequester ? "Courier" : "Requester"}',
                          onPressed: () {
                            CommunicationHelper.showCallModal(
                              context,
                              userName: _partner!.name,
                              role: _isRequester ? 'Courier' : 'Requester',
                              avatarUrl: _partner!.avatarUrl,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                          tooltip: 'Chat with ${_isRequester ? "Courier" : "Requester"}',
                          onPressed: () {
                            CommunicationHelper.openChat(
                              context,
                              otherUserId: _partner!.id,
                              type: ConversationType.delivery,
                              contextId: widget.deliveryId,
                              contextTitle: 'Delivery #${widget.deliveryId}',
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            
            // Timeline
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Status',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            DeliveryTimeline(
              currentStatus: DeliveryStatus.inTransit,
              createdAt: _request!.createdAt,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UniButton(
            onPressed: () {
              context.push('/delivery/complete/${widget.deliveryId}');
            },
            label: 'Complete Delivery',
            variant: UniButtonVariant.primary,
            isFullWidth: true,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }
}


