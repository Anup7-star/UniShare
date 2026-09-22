import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollegeVerifyScreen extends StatefulWidget {
  const CollegeVerifyScreen({super.key});

  @override
  State<CollegeVerifyScreen> createState() => _CollegeVerifyScreenState();
}

class _CollegeVerifyScreenState extends State<CollegeVerifyScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  void _validateAndSubmit() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorText = 'Please enter your college email';
      });
      return;
    }
    
    // Basic college domain validation (e.g., .ac.in or .edu)
    if (!email.endsWith('.ac.in') && !email.endsWith('.edu')) {
      setState(() {
        _errorText = 'Please use a valid college email (.ac.in or .edu)';
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // context.push('/otp', extra: email);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'College Verification',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your college email address to get started',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF1A1A1A),
                  ),
                  decoration: InputDecoration(
                    labelText: 'College Email',
                    hint: 'yourname@iitd.ac.in',
                    labelStyle: GoogleFonts.inter(
                      color: const Color(0xFF6B6B6B),
                    ),
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF8E8E93),
                    ),
                    errorText: _errorText,
                    errorStyle: GoogleFonts.inter(
                      color: const Color(0xFFFF3B30),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE5E5EA)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00BF6D), width: 2),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF3B30)),
                    ),
                  ),
                  onChanged: (value) {
                    if (_errorText != null) {
                      setState(() {
                        _errorText = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'We\'ll send a 6-digit verification code to your email',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE6F9F0),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Send Verification Code',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
