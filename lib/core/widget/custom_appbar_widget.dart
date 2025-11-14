import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 45,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
