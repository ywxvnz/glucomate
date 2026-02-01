import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Dashboard Home content (extracted from previous implementation)
  Widget _dashboardHome() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _sectionHeader("Indexes"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _indexBox(
                  "Avg Glucose",
                  "120 mg/dL",
                  FontAwesomeIcons.heartPulse,
                ),
                _indexBox("Status", "Normal", FontAwesomeIcons.solidHeart),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _indexBox("Last Reading", "80 mg/dL", FontAwesomeIcons.droplet),
                _indexBox("Trend", "Low", FontAwesomeIcons.chartLine),
              ],
            ),
            const SizedBox(height: 32),
            _sectionHeader("Blood Glucose"),
            const SizedBox(height: 16),
            _lineChart(),
          ],
        ),
      ),
    );
  }

  // Section Header
  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headline(color: AppColors.textBlack)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderGray),
            color: AppColors.containerBackground,
          ),
          child: Row(
            children: [
              Text("Today", style: AppTextStyles.subtitle(color: AppColors.textBlack)),
              const SizedBox(width: 2),
              const Icon(Icons.expand_more, size: 16, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  // Index Box
  Widget _indexBox(String title, String value, IconData icon) {
    return Container(
      width: 160,
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerBackground,
        border: Border.all(color: AppColors.borderGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: AppTextStyles.subtitle(color: AppColors.textGray)),
              const SizedBox(height: 6),
              Text(value, style: AppTextStyles.title(color: AppColors.textBlack)),
            ],
          ),
          FaIcon(icon, color: AppColors.iconBlack, size: 20),
        ],
      ),
    );
  }

  // Line Chart (same painter can remain below)
  Widget _lineChart() {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final yLabels = [250, 200, 150, 100, 50, 0];
    final values = [95, 110, 125, 140, 130, 115, 100];

    return SizedBox(
      height: 240,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: yLabels
                .map((y) => Text(y.toString(), style: AppTextStyles.caption(color: AppColors.textBlack)))
                .toList(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartHeight = constraints.maxHeight - 24;
                final chartWidth = constraints.maxWidth;
                return Column(
                  children: [
                    SizedBox(
                      height: chartHeight,
                      width: chartWidth,
                      child: CustomPaint(painter: _LineChartPainter(values)),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: days
                          .map((d) => Text(d, style: AppTextStyles.caption(color: AppColors.textBlack)))
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _dashboardHome();
}

// Line Chart Painter (copy from previous file)
class _LineChartPainter extends CustomPainter {
  final List<int> values;
  _LineChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = 250.0;
    final minVal = 0.0;

    final paint = Paint()
      ..color = const Color(0xFF185b5a)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [const Color(0xFF185b5a).withOpacity(0.15), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.12)
      ..strokeWidth = 1;

    final paddingBottom = 20.0;
    final graphHeight = size.height - paddingBottom;
    final graphWidth = size.width;
    final stepX = graphWidth / (values.length - 1);

    for (int i = 0; i <= 5; i++) {
      final y = graphHeight * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(graphWidth, y), gridPaint);
    }

    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = stepX * i;
      final y =
          graphHeight -
          ((values[i] - minVal) / (maxVal - minVal) * graphHeight);
      points.add(Offset(x, y));
    }

    if (points.isNotEmpty) {
      final path = Path()..moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      final fillPath = Path.from(path)
        ..lineTo(points.last.dx, graphHeight)
        ..lineTo(points.first.dx, graphHeight)
        ..close();

      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(path, paint);
    }

    final dotPaint = Paint()..color = const Color(0xFF185b5a);
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}