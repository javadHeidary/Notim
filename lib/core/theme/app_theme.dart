import 'package:Notim/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColor,
    useMaterial3: true,
  );

  static double size(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    final designWidth = 392;
    return (width / designWidth) * value;
  }
}
