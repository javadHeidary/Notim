import 'package:Notim/core/theme/app_colors.dart';
import 'package:Notim/core/theme/app_text_style.dart';
import 'package:Notim/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color categoryColor;
  final VoidCallback? onTap;
  final VoidCallback? onArrowTap;

  const CustomCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.categoryColor,
    this.onTap,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
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
                              style: AppTextStyle.body(
                                context: context,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: AppTheme.size(context, 6)),
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.text(context: context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppTheme.size(context, 12)),
          InkWell(
            onTap: onArrowTap ?? onTap,
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
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
