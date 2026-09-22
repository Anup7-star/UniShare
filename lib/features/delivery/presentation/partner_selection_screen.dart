import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';
import 'package:unishare/shared/widgets/uni_button.dart';
import 'package:go_router/go_router.dart';

class PartnerSelectionScreen extends StatefulWidget {
  final String deliveryId;
  const PartnerSelectionScreen({Key? key, required this.deliveryId}) : super(key: key);

  @override
  State<PartnerSelectionScreen> createState() => _PartnerSelectionScreenState();
}

class _PartnerSelectionScreenState extends State<PartnerSelectionScreen> {
  final MockDataService _mockDataService = MockDataService();
  List<UniUser> _volunteers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVolunteers();
  }

  Future<void> _loadVolunteers() async {
    final users = await _mockDataService.getUsers();
    final currentUser = await _mockDataService.getCurrentUser();
    
    // Mock volunteers
    final volunteers = users.where((u) => u.id != currentUser.id).take(3).toList();
    
    setState(() {
      _volunteers = volunteers;
      _isLoading = false;
    });
  }

  void _showPartnerDetails(BuildContext context, UniUser partner) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UniAvatar(imageUrl: partner.avatarUrl, name: partner.name, size: 80),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    partner.name,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (partner.isVerified) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.verified, color: AppColors.primary, size: 20),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                partner.department,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat(Icons.star, AppColors.warning, partner.rating.toStringAsFixed(1), 'Rating'),
                  _buildStat(Icons.local_shipping, AppColors.primary, partner.completedDeliveries.toString(), 'Deliveries'),
                ],
              ),
              const SizedBox(height: 32),
              UniButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.push('/delivery/pickup/${widget.deliveryId}');
                },
                label: 'Accept Partner',
                variant: UniButtonVariant.primary,
                isFullWidth: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(IconData icon, Color color, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
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
          'Select Partner',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
        : _volunteers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Waiting for volunteers...',
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _volunteers.length,
              itemBuilder: (context, index) {
                final partner = _volunteers[index];
                return UniCard(
                  
                  onTap: () => _showPartnerDetails(context, partner),
                  padding: 16,
                  child: Row(
                    children: [
                      UniAvatar(imageUrl: partner.avatarUrl, name: partner.name, size: 48),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  partner.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (partner.isVerified) ...[
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
                                  partner.rating.toStringAsFixed(1),
                                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.local_shipping, color: AppColors.textSecondary, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${partner.completedDeliveries}',
                                  style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      UniButton(
                        onPressed: () {
                          context.push('/delivery/pickup/${widget.deliveryId}');
                        },
                        label: 'Accept',
                        variant: UniButtonVariant.outline,
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}


