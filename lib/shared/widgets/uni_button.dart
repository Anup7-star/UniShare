import 'package:flutter/material.dart';

enum UniButtonVariant { primary, secondary, outline, ghost, destructive }

class UniButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final UniButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool isDisabled;

  const UniButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = UniButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.isDisabled = false,
  });

  @override
  State<UniButton> createState() => _UniButtonState();
}

class _UniButtonState extends State<UniButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    if (widget.isDisabled) return const Color(0xFFF5F5F5);
    switch (widget.variant) {
      case UniButtonVariant.primary:
        return const Color(0xFF00BF6D); // AppColors.primary
      case UniButtonVariant.secondary:
        return const Color(0xFFF5F5F5);
      case UniButtonVariant.destructive:
        return const Color(0xFFFF3B30); // AppColors.error
      case UniButtonVariant.outline:
      case UniButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (widget.isDisabled) return const Color(0xFF8E8E93);
    switch (widget.variant) {
      case UniButtonVariant.primary:
      case UniButtonVariant.destructive:
        return Colors.white;
      case UniButtonVariant.secondary:
        return const Color(0xFF1A1A1A); // AppColors.textPrimary
      case UniButtonVariant.outline:
      case UniButtonVariant.ghost:
        return const Color(0xFF00BF6D); // AppColors.primary
    }
  }

  BorderSide? get _borderSide {
    if (widget.variant == UniButtonVariant.outline) {
      return BorderSide(
        color: widget.isDisabled ? const Color(0xFF8E8E93) : const Color(0xFF00BF6D),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 20, color: _foregroundColor),
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: TextStyle(
            color: _foregroundColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    Widget button = InkWell(
      onTapDown: widget.isDisabled || widget.isLoading ? null : (_) => _controller.forward(),
      onTapUp: widget.isDisabled || widget.isLoading ? null : (_) => _controller.reverse(),
      onTapCancel: widget.isDisabled || widget.isLoading ? null : () => _controller.reverse(),
      onTap: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        width: widget.isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: _borderSide != null ? Border.fromBorderSide(_borderSide!) : null,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: button,
    );
  }
}
