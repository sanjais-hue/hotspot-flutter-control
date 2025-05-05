
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Command {
  FRONT,
  LEFT,
  RIGHT,
  DOWN,
  DANCE1,
  DANCE2,
  CLOCK,
  BUG,
  MOON,
  HAND,
  DUMBBELL,
  SMILE,
  IDLE
}

class EspConnectionService extends ChangeNotifier {
  String _defaultIp = '192.168.4.1';
  bool _connected = false;
  Command? _lastCommand;
  String _ipAddress = '192.168.4.1';

  EspConnectionService() {
    _loadSavedIp();
    // Try auto-connect
    connect();
  }

  bool get connected => _connected;
  Command? get lastCommand => _lastCommand;
  String get ipAddress => _ipAddress;

  Future<void> _loadSavedIp() async {
    final prefs = await SharedPreferences.getInstance();
    _ipAddress = prefs.getString('esp-ip-address') ?? _defaultIp;
  }

  Future<bool> connect([String? ipAddress]) async {
    if (ipAddress != null) {
      _ipAddress = ipAddress;
    }

    try {
      // In a real app, we would make an actual request to check if the ESP is available
      // final response = await http.get(
      //   Uri.parse('http://$_ipAddress/status'),
      // ).timeout(const Duration(seconds: 3));
      
      // if (response.statusCode == 200) {
      //   _connected = true;
      //   final prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('esp-ip-address', _ipAddress);
      //   notifyListeners();
      //   _showToast('Connected to ESP device');
      //   return true;
      // }

      // Simulate successful connection for demo purposes
      _connected = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('esp-ip-address', _ipAddress);
      notifyListeners();
      _showToast('Connected to ESP device (Demo Mode)');
      return true;
    } catch (error) {
      debugPrint('Connection error: $error');
      
      // Simulation for demo
      _connected = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('esp-ip-address', _ipAddress);
      notifyListeners();
      _showToast('Connected to ESP device (Demo Mode)');
      return true;

      // Real error handling
      // _connected = false;
      // notifyListeners();
      // _showToast('Failed to connect to ESP device', isError: true);
      // return false;
    }
  }

  void disconnect() {
    _connected = false;
    _lastCommand = null;
    notifyListeners();
    _showToast('Disconnected from ESP device');
  }

  Future<bool> sendCommand(Command command) async {
    if (!_connected) {
      _showToast('Not connected to ESP device', isError: true);
      return false;
    }

    try {
      // In a real app, we would make an actual request to send the command
      // final response = await http.post(
      //   Uri.parse('http://$_ipAddress/command'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'command': command.toString().split('.').last}),
      // ).timeout(const Duration(seconds: 2));
      
      // if (response.statusCode == 200) {
      //   _lastCommand = command;
      //   notifyListeners();
      //   return true;
      // }

      // Simulate successful command for demo purposes
      debugPrint('Sending command: ${command.toString().split('.').last}');
      _lastCommand = command;
      notifyListeners();
      return true;
    } catch (error) {
      debugPrint('Command error: $error');
      _showToast('Failed to send command: ${command.toString().split('.').last}', isError: true);
      return false;
    }
  }

  void _showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}
