
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pluto_control/services/esp_service.dart';

class ConnectDialog extends StatefulWidget {
  final String initialIp;

  const ConnectDialog({
    super.key,
    required this.initialIp,
  });

  @override
  State<ConnectDialog> createState() => _ConnectDialogState();
}

class _ConnectDialogState extends State<ConnectDialog> {
  late TextEditingController _ipController;
  
  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController(text: widget.initialIp);
  }
  
  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final espService = Provider.of<EspConnectionService>(context);
    
    return Dialog(
      backgroundColor: const Color(0xFF1A1F2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: const Color(0xFF33E8F0).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Connect to ESP Device',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33E8F0),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'IP Address',
                labelStyle: TextStyle(
                  color: const Color(0xFF33E8F0).withOpacity(0.7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF33E8F0).withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF33E8F0),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
              ),
              style: const TextStyle(color: Color(0xFF33E8F0)),
            ),
            const SizedBox(height: 8),
            Text(
              'Default IP when connected to ESP hotspot is usually 192.168.4.1',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF33E8F0).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: const Color(0xFF33E8F0).withOpacity(0.7),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    final success = await espService.connect(_ipController.text);
                    if (success && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33E8F0),
                    foregroundColor: const Color(0xFF0A0A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Connect'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
