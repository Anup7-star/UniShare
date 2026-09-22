import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                // Logo Area
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F9F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Color(0xFF00BF6D),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // App Name
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Uni',
                          style: TextStyle(color: Color(0xFF1A1A1A)),
                        ),
                        TextSpan(
                          text: 'Share',
                          style: TextStyle(color: Color(0xFF00BF6D)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tagline
                Text(
                  'Verified students helping verified students',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 48),
                // Features
                _buildFeatureItem(Icons.local_shipping_outlined, 'Campus Deliveries'),
                const SizedBox(height: 24),
                _buildFeatureItem(Icons.handshake_outlined, 'Peer Rentals'),
                const SizedBox(height: 24),
                _buildFeatureItem(Icons.verified_user_outlined, 'Verified Trust'),
                const Spacer(flex: 3),
                // CTA Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to CollegeVerifyScreen
                    // context.push('/verify');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue with College Email',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Footer text
                Text(
                  'Only verified college students can join',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1A1A1A),
            ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }
}
