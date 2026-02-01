import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.selectedIndex, required this.onTap});

  Widget _navItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTap(index),
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _navItem(FontAwesomeIcons.house, 0),
          _navItem(FontAwesomeIcons.fileLines, 1),
          const SizedBox(width: 48),
          _navItem(FontAwesomeIcons.commentDots, 3),
          _navItem(FontAwesomeIcons.user, 4),
        ],
      ),
    );
  }
}