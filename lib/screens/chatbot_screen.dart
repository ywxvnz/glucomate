import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_colors.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chatbot (placeholder)', style: AppTextStyles.title(color: AppColors.textBlack)),
    );
  }
}