import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/features/delivery/presentation/widgets/delivery_timeline.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';
import 'package:unishare/shared/widgets/uni_chip.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/utils/communication_helper.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final String deliveryId;
  const DeliveryDetailScreen({super.key, required this.deliveryId});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  final MockDataService _mockDataService = MockDataService();
  
  DeliveryRequest? _request;
  UniUser? _requester;
  UniUser? _currentUser;
  CampusLocation? _pickup;
  CampusLocation? _destination;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final deliveries = await _mockDataService.getDeliveryRequests();
    final request = deliveries.firstWhere((d) => d.id == widget.deliveryId, orElse: () => deliveries.first);
    
    final requester = await _mockDataService.getUserById(request.requesterId);
    final pickup = await _mockDataService.getLocationById(request.pickupLocationId);
    final destination = await _mockDataService.getLocationById(request.destinationId);
    final currentUser = await _mockDataService.getCurrentUser();
    
    setState(() {
      _request = request;
      _requester = requester;
      _pickup = pickup;
      _destination = destination;
      _currentUser = currentUser;
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

    if (_request == null) return const Scaffold();

    final isCourier = _currentUser?.id != _request!.requesterId;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Delivery Details',
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
            // Hero section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pickup?.name ?? 'Unknown',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pickup',
                          style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _destination?.name ?? 'Unknown',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Destination',
                          style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Package Details
            Text(
              'Package Details',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            UniCard(
              padding: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UniChip(label: _request!.packageType.name.toUpperCase()),
                      const SizedBox(width: 8),
                      UniChip(label: _request!.packageSize.name.toUpperCase()),
                    ],
                  ),
                  if (_request!.note != null && _request!.note!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Note: ${_request!.note}',
                      style: GoogleFonts.inter(color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Reward
            UniCard(
              padding: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reward',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Suggested reward based on distance, urgency and route',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${_request!.reward.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Requester Info (If courier)
            if (isCourier && _requester != null) ...[
              Text(
                'Requested By',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              UniCard(
                padding: 16,
                child: Row(
                  children: [
                    UniAvatar(
                      imageUrl: _requester!.avatarUrl,
                      name: _requester!.name,
                      size: 48,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _requester!.name,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              if (_requester!.isVerified) ...[
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, color: AppColors.primary, size: 16),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: AppColors.warning, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                _requester!.rating.toStringAsFixed(1),
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.local_shipping, color: AppColors.textSecondary, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${_requester!.completedDeliveries} deliveries',
                                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                          tooltip: 'Call Requester',
                          onPressed: () {
                            CommunicationHelper.showCallModal(
                              context,
                              userName: _requester!.name,
                              role: 'Requester',
                              avatarUrl: _requester!.avatarUrl,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                          tooltip: 'Chat with Requester',
                          onPressed: () {
                            CommunicationHelper.openChat(
                              context,
                              otherUserId: _requester!.id,
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
            Text(
              'Status',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            DeliveryTimeline(
              currentStatus: _request!.status,
              createdAt: _request!.createdAt,
            ),
            
            const SizedBox(height: 32),
            
            // Action Buttons
            if (isCourier && _request!.status == DeliveryStatus.open)
              UniButton(
                onPressed: () async {
                  if (_currentUser != null && _request != null) {
                    final messenger = ScaffoldMessenger.of(context);
                    final router = GoRouter.of(context);
                    await _mockDataService.acceptDeliveryRequest(_request!.id, _currentUser!.id);
                    if (mounted) {
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Delivery request accepted! Proceeding to pickup verification.'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      router.push('/delivery/pickup/${_request!.id}');
                    }
                  }
                },
                label: 'Accept Delivery',
                variant: UniButtonVariant.primary,
                isFullWidth: true,
              )
            else if (!isCourier && _request!.status == DeliveryStatus.open)
              Row(
                children: [
                  Expanded(
                    child: UniButton(
                      onPressed: () {},
                      label: 'Edit',
                      variant: UniButtonVariant.secondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: UniButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'Cancel Request',
                      variant: UniButtonVariant.outline,
                    ),
                  ),
                ],
              )
            else if (_request!.status == DeliveryStatus.pickup)
               UniButton(
                onPressed: () {
                  context.push('/delivery/pickup/${_request!.id}');
                },
                label: 'Go to Pickup',
                variant: UniButtonVariant.primary,
                isFullWidth: true,
              )
             else if (_request!.status == DeliveryStatus.inTransit)
               UniButton(
                onPressed: () {
                  context.push('/delivery/transit/${_request!.id}');
                },
                label: 'View Transit',
                variant: UniButtonVariant.primary,
                isFullWidth: true,
              ),
              
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}


