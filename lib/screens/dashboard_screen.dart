import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:glucomate/screens/manual_logging_screen.dart';
import 'scan_glucometer_screen.dart';
import 'log_records_screen.dart';
import '../utils/app_text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();
  bool _isDarkMode = false;

  String get dateLabel {
    final now = DateTime.now();
    final diff = now.difference(_selectedDate).inDays;
    if (diff == 0) return "Today";
    if (diff == 1) return "Yesterday";
    if (diff <= 6) return "Past Days";
    return "Past Weeks";
  }

  late final List<Widget> _pages = [
    _dashboardHome(),
    const Center(
      child: Text('Log Records Page'),
    ),
    const SizedBox.shrink(),
    const Center(
      child: Text('Chatbot Page', style: TextStyle(color: Colors.black)),
    ),
    const Center(
      child: Text('Profile Page', style: TextStyle(color: Colors.black)),
    ),
  ];

  // Dashboard Home
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
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now(),
            );
            if (picked != null) setState(() => _selectedDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderGray),
              color: AppColors.containerBackground,
            ),
            child: Row(
              children: [
                Text(dateLabel, style: AppTextStyles.subtitle(color: AppColors.textBlack)),
                const SizedBox(width: 2),
                const Icon(Icons.expand_more, size: 16, color: Colors.black),
              ],
            ),
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

  // Line Chart
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
                  .map((y) => Text(y.toString(), style: AppTextStyles.caption(color: AppColors.textBlack))).toList()
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
                          .map(
                            (d) => Text(d, style: AppTextStyles.caption(color: AppColors.textBlack)),
                          )
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

  void _onItemTapped(int index) {
    if (index == 2) return;
    setState(() => _selectedIndex = index);
  }

  // NavBar helper
  Widget _navBarIcon(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _onItemTapped(index),
      splashColor: AppColors.cyan.withOpacity(0.3),
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cyan.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: isSelected ? AppColors.cyan : AppColors.iconBlack,
        ),
      ),
    );
  }

  // Drawer item with hover & active
  Widget _drawerItem(
    IconData icon,
    String title,
    int index,
    VoidCallback onTap,
  ) {
    final isSelected = _selectedIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        leading: FaIcon(icon, color: isSelected ? AppColors.cyan : AppColors.iconBlack),
        title: Text(
          title,
          style: AppTextStyles.subtitle(color: isSelected ? AppColors.cyan : AppColors.textBlack),
        ),
        hoverColor: AppColors.cyan.withOpacity(0.1),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.background,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo and App Name
                  Row(
                    children: [
                      Image.asset('assets/logo.png', width: 48, height: 48),
                      const SizedBox(width: 8),
                      Text("GlucoMate", style: AppTextStyles.appName(color: AppColors.textBlack)),
                    ],
                  ),
                  Builder(builder: (context) => IconButton(icon: const Icon(Icons.menu, color: Colors.black), onPressed: () => Scaffold.of(context).openEndDrawer())),
                ],
              ),
            ),
          ),
        ),
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  color: AppColors.containerBackground,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.borderGray,
                        child: const Icon(Icons.person, color: Colors.black, size: 30),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Example Name", style: AppTextStyles.title(color: AppColors.textBlack)),
                          Text("example@gmail.com", style: AppTextStyles.subtitle(color: AppColors.textGray)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 12),
                      _drawerItem(Icons.person, "Profile", 0, () {
                        setState(() => _selectedIndex = 0);
                        Navigator.pop(context);
                      }),
                      _drawerItem(
                        Icons.notifications,
                        "Notifications",
                        1,
                        () => Navigator.pop(context),
                      ),
                      _drawerItem(
                        Icons.settings,
                        "Settings",
                        2,
                        () => Navigator.pop(context),
                      ),

                      ListTile(
                        leading: const Icon(Icons.light_mode, color: AppColors.iconBlack),
                        title: Text("Light Mode", style: AppTextStyles.subtitle(color: AppColors.textBlack)),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.iconBlack),
                  title: Text("Logout", style: AppTextStyles.subtitle(color: AppColors.textBlack)),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        floatingActionButton: Transform.translate(
          offset: const Offset(0, 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScanGlucometerScreen()),
                );
              },
              child: Container(
                width: 64,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.qr_code_scanner, color: AppColors.textWhite),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.containerBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navBarIcon(FontAwesomeIcons.house, 0),
              _navBarIcon(FontAwesomeIcons.fileLines, 1),
              const SizedBox(width: 48),
              _navBarIcon(FontAwesomeIcons.commentDots, 3),
              _navBarIcon(FontAwesomeIcons.user, 4),
            ],
          ),
        ),
      ),
    );
  }
}

// Line Chart Painter
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
