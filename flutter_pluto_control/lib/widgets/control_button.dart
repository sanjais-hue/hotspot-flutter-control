
import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool active;
  final String? variant;

  const ControlButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.active = false,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
        color: active 
            ? const Color(0xFF33E8F0).withOpacity(0.2) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          splashColor: const Color(0xFF33E8F0).withOpacity(0.3),
          highlightColor: const Color(0xFF33E8F0).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF33E8F0),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: const Color(0xFF33E8F0).withOpacity(0.5),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
