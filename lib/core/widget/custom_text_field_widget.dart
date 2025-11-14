import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.onTap,
  });

  OutlineInputBorder _border({Color color = AppColors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        readOnly: readOnly,
        cursorColor: AppColors.black,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyle.body(context: context),
          hintStyle: AppTextStyle.hintText(context: context),
          filled: true,
          fillColor: AppColors.white,
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(color: AppColors.black),
          errorBorder: _border(color: AppColors.red),
          focusedErrorBorder: _border(color: AppColors.red),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
