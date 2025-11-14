import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: AppTheme.size(context, 16)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.size(context, 8))),
      ),
      child: Text(
        title,
        style: AppTextStyle.body(
          context: context,
        ).copyWith(color: AppColors.white),
      ),
    );
  }
}
