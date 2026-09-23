import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';

class CommunicationHelper {
  /// Open chat with a specific user and context (delivery or rental)
  static Future<void> openChat(
    BuildContext context, {
    required String otherUserId,
    required ConversationType type,
    String? contextId,
    String? contextTitle,
  }) async {
    final mockService = MockDataService();
    final conv = await mockService.getOrCreateConversation(
      otherUserId: otherUserId,
      type: type,
      contextId: contextId,
      contextTitle: contextTitle,
    );

    if (context.mounted) {
      context.push('/messages/${conv.id}');
    }
  }

  /// Show a simulated voice call modal
  static void showCallModal(
    BuildContext context, {
    required String userName,
    String? role,
    String? avatarUrl,
    String? phoneNumber,
  }) {
    final phone = phoneNumber ?? '+91 987${(userName.hashCode.abs() % 9000000 + 1000000)}';
    final userRole = role ?? 'Campus Peer';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _CallModalContent(
          userName: userName,
          role: userRole,
          avatarUrl: avatarUrl,
          phoneNumber: phone,
        );
      },
    );
  }
}

class _CallModalContent extends StatefulWidget {
  final String userName;
  final String role;
  final String? avatarUrl;
  final String phoneNumber;

  const _CallModalContent({
    required this.userName,
    required this.role,
    this.avatarUrl,
    required this.phoneNumber,
  });

  @override
  State<_CallModalContent> createState() => _CallModalContentState();
}

class _CallModalContentState extends State<_CallModalContent> {
  bool _isMuted = false;
  bool _isSpeaker = false;
  bool _isConnected = false;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    // Simulate connection after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isConnected = true);
        _startTimer();
      }
    });
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted || !_isConnected) return false;
      setState(() => _seconds++);
      return true;
    });
  }

  String _formatDuration(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B), // Dark slate call overlay
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Avatar
            UniAvatar(
              imageUrl: widget.avatarUrl ?? '',
              name: widget.userName,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              widget.userName,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.role,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.phoneNumber,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 12),
            // Call status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _isConnected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : Colors.white10,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isConnected ? AppColors.primary : Colors.white24,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _isConnected ? AppColors.primary : Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isConnected
                        ? 'Connected • ${_formatDuration(_seconds)}'
                        : 'Calling...',
                    style: TextStyle(
                      color: _isConnected ? Colors.white : Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            // Call action row (Mute, Speaker, Keypad)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  label: _isMuted ? 'Unmute' : 'Mute',
                  isActive: _isMuted,
                  onTap: () => setState(() => _isMuted = !_isMuted),
                ),
                _buildActionButton(
                  icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
                  label: 'Speaker',
                  isActive: _isSpeaker,
                  onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                ),
                _buildActionButton(
                  icon: Icons.dialpad,
                  label: 'Keypad',
                  isActive: false,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            // End call button
            GestureDetector(
              onTap: () {
                setState(() => _isConnected = false);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Call with ${widget.userName} ended'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444), // Danger Red
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66EF4444),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'End Call',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
