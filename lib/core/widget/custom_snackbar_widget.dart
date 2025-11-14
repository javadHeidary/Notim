import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

void showSnackBarWidget(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Text(
        message,
        style: AppTextStyle.body(
          context: context,
        ).copyWith(color: AppColors.white),
      ),
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
