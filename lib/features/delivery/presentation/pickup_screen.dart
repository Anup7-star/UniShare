import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/utils/communication_helper.dart';
import 'dart:async';

class PickupScreen extends StatefulWidget {
  final String deliveryId;
  const PickupScreen({super.key, required this.deliveryId});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MockDataService _mockDataService = MockDataService();
  
  UniUser? _partner;
  bool _isRequester = false;
  bool _isLoading = true;
  int _elapsedSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
    _startTimer();
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
    
    setState(() {
      _partner = partner;
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
          'Pickup Verification',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: AppColors.primaryLight,
            child: Text(
              _isRequester ? 'Waiting for Courier' : 'Ready for Pickup',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          
          if (_partner != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UniCard(
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
            ),
          
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'QR Code'),
              Tab(text: 'OTP'),
            ],
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildQRTab(),
                _buildOTPTab(),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Time elapsed: $timeStr',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                UniButton(
                  onPressed: () {
                    context.push('/delivery/transit/${widget.deliveryId}');
                  },
                  label: 'Confirm Pickup',
                  variant: UniButtonVariant.primary,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isRequester) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: QrImageView(
                data: 'UNISHARE-TXN-${widget.deliveryId}',
                version: QrVersions.auto,
                size: 200.0,
                ),
            ),
            const SizedBox(height: 24),
            Text(
              'Show this QR to the courier',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ] else ...[
            Icon(Icons.qr_code_scanner, size: 100, color: AppColors.textTertiary),
            const SizedBox(height: 24),
            Text(
              'Scan the QR code shown by the requester',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildOTPTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isRequester) ...[
            Text(
              'Your OTP',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '847293',
              style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Share this code with the courier',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: '000000',
                  hintStyle: GoogleFonts.inter(color: AppColors.textTertiary),
                  counterText: '',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Enter the OTP from the requester',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ]
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}


