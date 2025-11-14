import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String label;
  final String? hint;
  final String? Function(T?)? validator;
  final bool enabled;

  const CustomDropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.hint,
    this.validator,
    this.enabled = true,
  });

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        isExpanded: true,
        alignment: AlignmentDirectional.centerEnd,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: enabled ? AppColors.black : AppColors.grey,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: AppTextStyle.body(context: context),
          hintStyle: AppTextStyle.hintText(context: context),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: _border(AppColors.grey),
          enabledBorder: _border(AppColors.grey),
          disabledBorder: _border(AppColors.grey.withOpacity(0.4)),
          focusedBorder: _border(AppColors.black),
          errorBorder: _border(AppColors.red),
          focusedErrorBorder: _border(AppColors.red),
        ),
        dropdownColor: AppColors.white,
        style: AppTextStyle.body(context: context),
      ),
    );
  }
}
