import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/dashboard_screen.dart';

class GlucoMateApp extends StatelessWidget {
  const GlucoMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlucoMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: GoogleFonts.playfairDisplayTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryTextTheme: GoogleFonts.playfairDisplayTextTheme(
          Theme.of(context).primaryTextTheme,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
