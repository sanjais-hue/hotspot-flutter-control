
import 'package:flutter/material.dart';
import 'package:flutter_pluto_control/screens/home_screen.dart';
import 'package:flutter_pluto_control/services/esp_service.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EspConnectionService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLUTO ESP Controller',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            background: Color(0xFF0A0A2A),
            primary: Color(0xFF33E8F0),
            secondary: Color(0xFF0DCAF0),
            tertiary: Color(0xFF6E59A5),
          ),
          textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
          scaffoldBackgroundColor: const Color(0xFF0A0A2A),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
