
import 'package:flutter/material.dart';

class NeonIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool active;
  final String? tooltip;

  const NeonIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.active = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final Widget button = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active 
            ? const Color(0xFF33E8F0).withOpacity(0.2) 
            : const Color(0xFF1A1F2C).withOpacity(0.6),
        border: Border.all(
          color: const Color(0xFF33E8F0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF33E8F0).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          splashColor: const Color(0xFF33E8F0).withOpacity(0.3),
          highlightColor: const Color(0xFF33E8F0).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: const Color(0xFF33E8F0),
              size: 24,
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
