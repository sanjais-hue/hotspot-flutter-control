
import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final bool connected;
  final String command;

  const StatusIndicator({
    super.key,
    required this.connected,
    required this.command,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2C).withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusItem("STATUS:", connected ? "CONNECTED" : "DISCONNECTED"),
              const SizedBox(height: 4),
              _buildStatusItem("COMMAND:", command),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF33E8F0),
                width: 2,
              ),
              color: connected 
                  ? const Color(0xFF33E8F0).withOpacity(0.2) 
                  : Colors.transparent,
            ),
            child: Icon(
              Icons.wifi,
              size: 18,
              color: connected 
                  ? const Color(0xFF33E8F0) 
                  : const Color(0xFF33E8F0).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF33E8F0).withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 4),
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF33E8F0),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33E8F0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
