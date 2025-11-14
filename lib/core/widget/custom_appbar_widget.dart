import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatelessWidget {
  final String title;
  final bool isBackButton;
  final Color color;
  const CustomAppbarWidget({
    super.key,
    required this.title,
    this.color = AppColors.black,
    this.isBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppTheme.size(context, 16)),
      height: AppTheme.size(context, 45),
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.size(context, 8))),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: AppTextStyle.title(context: context),
              textAlign: TextAlign.center,
            ),
          ),
          if (isBackButton)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
