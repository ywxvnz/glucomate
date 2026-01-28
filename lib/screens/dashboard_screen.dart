import 'package:flutter/material.dart';
import '../widgets/glucose_card.dart';

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
          children: const [
            GlucoseCard(
              glucoseValue: 120,
              status: 'Normal',
              date: 'Jan 28, 2026',
              time: '8:30 AM',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Future: navigate to manual entry / scan screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
