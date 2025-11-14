import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomNoteWidget extends StatelessWidget {
  final String title;
  final String content;
  final Color categoryColor;
  final bool isCompleted;
  final ValueChanged<bool?>? onStatusChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CustomNoteWidget({
    super.key,
    required this.title,
    required this.content,
    required this.categoryColor,
    required this.isCompleted,
    this.onStatusChanged,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  String _buildPreview() {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return '---';
    if (trimmed.length <= 40) return trimmed;
    return '${trimmed.substring(0, 40)}…';
  }

  @override
  Widget build(BuildContext context) {
    final preview = _buildPreview();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppTheme.size(context, 16)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.size(context, 16),
                  vertical: AppTheme.size(context, 14),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppTheme.size(context, 16)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.12),
                      blurRadius: AppTheme.size(context, 10),
                      offset: Offset(0, AppTheme.size(context, 6)),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppTheme.size(context, 6),
                        decoration: BoxDecoration(
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(AppTheme.size(context, 4)),
                        ),
                      ),
                      SizedBox(width: AppTheme.size(context, 12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.body(context: context)
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isCompleted
                                        ? AppColors.grey
                                        : AppColors.black,
                                  ),
                            ),
                            SizedBox(height: AppTheme.size(context, 6)),
                            Text(
                              preview,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.text(context: context)
                                  .copyWith(
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: AppColors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppTheme.size(context, 12)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: onEdit,
                            icon: const Icon(Icons.edit),
                            color: AppColors.blue,
                            tooltip: 'ویرایش',
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints.tightFor(
                              width: AppTheme.size(context, 36),
                              height: AppTheme.size(context, 36),
                            ),
                          ),
                          SizedBox(width: AppTheme.size(context, 8)),
                          IconButton(
                            onPressed: onDelete,
                            icon: const Icon(Icons.delete),
                            color: AppColors.red,
                            tooltip: 'حذف',
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints.tightFor(
                              width: AppTheme.size(context, 36),
                              height: AppTheme.size(context, 36),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppTheme.size(context, 12)),
          InkWell(
            onTap: () => onStatusChanged?.call(!isCompleted),
            borderRadius: BorderRadius.circular(AppTheme.size(context, 16)),
            child: Container(
              width: AppTheme.size(context, 56),
              height: AppTheme.size(context, 76),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppTheme.size(context, 16)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.12),
                    blurRadius: AppTheme.size(context, 10),
                    offset: Offset(0, AppTheme.size(context, 6)),
                  ),
                ],
              ),
              child: Checkbox(
                value: isCompleted,
                onChanged: onStatusChanged,
                activeColor: AppColors.blue,
                checkColor: AppColors.white,
                side: BorderSide(color: AppColors.grey, width: AppTheme.size(context, 1.6)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.size(context, 6)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
