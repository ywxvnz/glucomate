import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'manual_logging_screen.dart';
import 'scan_glucometer_screen.dart';
import 'log_records_screen.dart';

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
    const Center(child: Text('Chart Page')),
    const SizedBox.shrink(),
    const Center(child: Text('Chatbot Page')),
    const Center(child: Text('Settings Page')),
  ];

  // Dashboard Home
  Widget _dashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scrollable profile + greeting
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.lightBlueAccent,
                  child: const Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,", style: GoogleFonts.nunito(fontSize: 15)),
                    Text(
                      "Juan Lucas",
                      style: GoogleFonts.nunito(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ManualLoggingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
              child: Text(
                "Manual Logging",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LogRecordsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
              child: Text(
                "Log Records",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  // Section Header
  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w700),
        ),
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
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Text(
                  dateLabel,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.expand_more, size: 16),
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
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade300),
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
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.nunito(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          FaIcon(icon, color: Colors.black, size: 20),
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
                .map(
                  (y) => Text(
                    y.toString(),
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
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
                            (d) => Text(
                              d,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
      splashColor: Colors.lightBlueAccent.withOpacity(0.3),
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.lightBlueAccent.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: isSelected ? Colors.lightBlueAccent : Colors.grey,
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
        leading: FaIcon(
          icon,
          color: isSelected ? Colors.lightBlueAccent : Colors.grey,
        ),
        title: Text(
          title,
          style: GoogleFonts.nunito(
            color: isSelected ? Colors.lightBlueAccent : null,
          ),
        ),
        hoverColor: Colors.lightBlueAccent.withOpacity(0.1),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: _isDarkMode
            ? Colors.grey[900]
            : const Color(0xFFEDF1F6),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: _isDarkMode ? Colors.grey[900] : const Color(0xFFEDF1F6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo and App Name
                Row(
                  children: [
                    Image.asset(
                      'assets/logo.png', // full logo picture
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "GlucoMate",
                      style: GoogleFonts.fredoka(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
            ),
          ),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.shade700,
                      Colors.lightBlueAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "GlucoMate",
                          style: GoogleFonts.fredoka(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
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
                    _drawerItem(Icons.dashboard, "Dashboard", 0, () {
                      setState(() => _selectedIndex = 0);
                      Navigator.pop(context);
                    }),
                    _drawerItem(
                      Icons.person,
                      "Profile",
                      1,
                      () => Navigator.pop(context),
                    ),
                    _drawerItem(
                      Icons.history,
                      "History",
                      2,
                      () => Navigator.pop(context),
                    ),
                    _drawerItem(Icons.settings, "Settings", 4, () {
                      setState(() => _selectedIndex = 4);
                      Navigator.pop(context);
                    }),
                    ListTile(
                      leading: Icon(
                        _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: Colors.grey,
                      ),
                      title: Text(
                        _isDarkMode ? "Dark Mode" : "Light Mode",
                        style: GoogleFonts.nunito(),
                      ),
                      onTap: () => setState(() => _isDarkMode = !_isDarkMode),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.grey),
                title: Text("Logout", style: GoogleFonts.nunito()),
                onTap: () {},
              ),
            ],
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
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlue.withOpacity(0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.qr_code_scanner, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
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
              _navBarIcon(FontAwesomeIcons.chartLine, 1),
              const SizedBox(width: 48),
              _navBarIcon(FontAwesomeIcons.commentDots, 3),
              _navBarIcon(FontAwesomeIcons.gear, 4),
            ],
          ),
        ),
      ),
    );
  }
}

// Line Chart Painter (unchanged)
class _LineChartPainter extends CustomPainter {
  final List<int> values;
  _LineChartPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = 250.0;
    final minVal = 0.0;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.withOpacity(0.15), Colors.transparent],
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

    final dotPaint = Paint()..color = Colors.blue;
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
