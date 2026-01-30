import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class TimeFilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool dense;

  const TimeFilterDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: AppColors.textBlack, fontSize: dense ? 12 : 13);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.borderGray.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map((it) => DropdownMenuItem(
                    value: it,
                    child: Text(it, style: textStyle, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
          style: textStyle,
          isDense: true,
          iconEnabledColor: AppColors.iconBlack,
          iconSize: 18,
          dropdownColor: AppColors.containerBackground,
        ),
      ),
    );
  }
}
