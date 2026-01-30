import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'manual_logging_screen.dart';

class ScanGlucometerScreen extends StatelessWidget {
  const ScanGlucometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Glucometer'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textGray,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Camera Preview Placeholder
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: AppColors.borderGray),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 64,
                  color: AppColors.iconBlack,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Scan Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: OCR logic later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scanning not implemented yet')),
                  );
                },
                icon: const Icon(Icons.document_scanner),
                label: const Text('Scan Glucometer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.buttonCyan,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Manual Input Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManualLoggingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Manual Input'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
