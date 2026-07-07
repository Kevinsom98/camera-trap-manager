import 'package:camera_trap_app/ui/dashboard_ui.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CameraTrapApp());
}

class CameraTrapApp extends StatelessWidget {
  const CameraTrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Trap Management Suite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Set an earthy, outdoor-friendly primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Forest Green
          brightness: Brightness.light,
          secondary: const Color(0xFFF57C00), // High-visibility Orange for alerts/GPS
        ),
        // Globally style all cards for a soft, modern elevation
        cardTheme: CardThemeData( 
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // Globally style all text fields so you don't have to write it on every form
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        // Make the main action buttons thick and easy to tap
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
      ),
      home:  ProjectDashboard(),
    );
  }
}