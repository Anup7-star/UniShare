import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.only(top: 60, bottom: 24, left: 24, right: 24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Text(
                          'JD',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00BF6D),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified, color: Color(0xFF00BF6D)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@college.edu',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F9F0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'College Verified',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00A85C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'National Institute of Technology • Computer Science',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildStatBox('⭐ 4.8', 'Rating'),
                  const SizedBox(width: 12),
                  _buildStatBox('📦 23', 'Deliveries'),
                  const SizedBox(width: 12),
                  _buildStatBox('🔄 12', 'Rentals'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Trust Score and Earnings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5EA)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trust Score', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF6B6B6B))),
                          const SizedBox(height: 8),
                          Text('High', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF00BF6D))),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.85,
                            color: const Color(0xFF00BF6D),
                            minHeight: 4,
                            borderRadius: BorderRadius.circular(2),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5EA)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Earnings', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF6B6B6B))),
                          const SizedBox(height: 8),
                          Text('₹1,450', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFF00BF6D))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Menu
            Container(
              color: const Color(0xFFFFFFFF),
              child: Column(
                children: [
                  _buildMenuItem(
                    Icons.history,
                    'Transaction History',
                    onTap: () => context.go('/deliveries'),
                  ),
                  _buildMenuItem(
                    Icons.inventory_2_outlined,
                    'My Listings',
                    onTap: () => context.go('/rentals'),
                  ),
                  _buildMenuItem(
                    Icons.settings_outlined,
                    'Settings',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings feature coming soon!')),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.help_outline,
                    'Help & Support',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Help & Support', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                          content: Text('Contact campus support at support@unishare.edu or visit the campus helpdesk.', style: GoogleFonts.inter()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text('Close', style: GoogleFonts.inter(color: const Color(0xFF00BF6D))),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.report_problem_outlined,
                    'Report a Problem',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thank you! Feedback submitted to campus admin.')),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.logout,
                    'Log Out',
                    isDestructive: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Log Out', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                          content: Text('Are you sure you want to log out?', style: GoogleFonts.inter()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: Text('Cancel', style: GoogleFonts.inter()),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                context.go('/home');
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF3B30)),
                              child: Text('Log Out', style: GoogleFonts.inter(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E5EA)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF6B6B6B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isDestructive = false, VoidCallback? onTap}) {
    final color = isDestructive ? const Color(0xFFFF3B30) : const Color(0xFF1A1A1A);
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFC7C7CC)),
      onTap: onTap,
    );
  }
}
