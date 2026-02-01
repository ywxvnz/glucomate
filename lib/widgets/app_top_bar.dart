import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;

  const AppTopBar({super.key, this.title = 'GlucoMate', this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/logo.png', width: 48, height: 48),
                const SizedBox(width: 8),
                Text(title, style: AppTextStyles.appName(color: AppColors.textBlack)),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: onMenuPressed ?? () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}