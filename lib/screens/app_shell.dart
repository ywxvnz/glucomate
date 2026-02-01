import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_bar.dart';
import 'dashboard_screen.dart';
import 'log_records_screen.dart';
import 'scan_glucometer_screen.dart';
import 'chatbot_screen.dart';
import 'profile_screen.dart';
import 'manual_logging_screen.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;
  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    DashboardScreen(),
    LogRecordsScreen(),
    ScanGlucometerScreen(),
    ChatbotScreen(),
    ProfileScreen(),
    ManualLoggingScreen(),
  ];

  void _onTapNav(int index) {
    setState(() => _selectedIndex = index);
  }

  void _openScan() {
    setState(() => _selectedIndex = 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
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
                child: ListView(padding: EdgeInsets.zero, children: [
                  ListTile(leading: const Icon(Icons.person), title: const Text('Profile')),
                  ListTile(leading: const Icon(Icons.notifications), title: const Text('Notifications')),
                  ListTile(leading: const Icon(Icons.settings), title: const Text('Settings')),
                ]),
              ),
              ListTile(leading: const Icon(Icons.logout), title: const Text('Logout')),
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
            onTap: _openScan,
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
      bottomNavigationBar: AppBottomNav(selectedIndex: _selectedIndex, onTap: _onTapNav),
    );
  }
}