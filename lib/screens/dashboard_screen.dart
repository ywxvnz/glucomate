import 'package:flutter/material.dart';
import '../widgets/glucose_card.dart';
import 'manual_logging_screen.dart';
import 'scan_glucometer_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlucoMate'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const GlucoseCard(
              glucoseValue: 120,
              status: 'Normal',
              date: 'Jan 28, 2026',
              time: '8:30 AM',
            ),

            const SizedBox(height: 24),

            // Manual Logging Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManualLoggingScreen(),
                    ),
                  );
                },
                child: const Text('Go to Manual Logging'),
              ),
            ),

            const SizedBox(height: 12),

            // Scan Glucometer Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScanGlucometerScreen(),
                    ),
                  );
                },
                child: const Text('Scan Glucometer'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ScanGlucometerScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
