import 'package:flutter/material.dart';

class GlucoseCard extends StatelessWidget {
  final int glucoseValue;
  final String status;
  final String date;
  final String time;

  const GlucoseCard({
    super.key,
    required this.glucoseValue,
    required this.status,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$glucoseValue mg/dL',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(status),
                Text('$date • $time'),
              ],
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
