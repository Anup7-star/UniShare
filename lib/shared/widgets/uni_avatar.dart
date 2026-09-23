import 'package:flutter/material.dart';

class UniAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final bool isVerified;

  const UniAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = 40.0,
    this.isVerified = false,
  });

  String get _initials {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFFE6F9F0), // PrimaryLight
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null || imageUrl!.isEmpty
          ? Text(
              _initials,
              style: TextStyle(
                color: const Color(0xFF00BF6D), // Primary
                fontWeight: FontWeight.w600,
                fontSize: size * 0.4,
              ),
            )
          : null,
    );

    if (isVerified) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFF00BF6D),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: size * 0.25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }
}
