import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle title({required BuildContext context}) => TextStyle(
    fontFamily: 'vazir',
    fontSize: AppTheme.size(context, 18),
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle subtitle({required BuildContext context}) => TextStyle(
    fontFamily: 'vazir',
    fontSize: AppTheme.size(context, 16),
    fontWeight: FontWeight.w400,
    // color: AppColors.hintTextColor,
    color: AppColors.white,
  );
  static TextStyle body({required BuildContext context}) => TextStyle(
    fontFamily: 'vazir',
    fontSize: AppTheme.size(context, 16),
    fontWeight: FontWeight.w400,
    // color: AppColors.hintTextColor,
    color: AppColors.black,
  );
  static TextStyle text({required BuildContext context}) => TextStyle(
    fontFamily: 'vazir',
    fontSize: AppTheme.size(context, 14),
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static TextStyle hintText({required BuildContext context}) => TextStyle(
    fontFamily: 'vazir',
    fontSize: AppTheme.size(context, 12),
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
}
