import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String title;
  const CustomEmptyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.sentiment_dissatisfied, size: AppTheme.size(context, 80), color: AppColors.grey),
        SizedBox(height: AppTheme.size(context, 16)),
        Text(title, style: AppTextStyle.text(context: context)),
      ],
    );
  }
}
