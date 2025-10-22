// Section Title Widget
// Reusable animated section title

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final int delay;
  
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : textAlign == TextAlign.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        FadeInDown(
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: delay),
          child: Text(
            title,
            style: isMobile ? AppTextStyles.h4 : AppTextStyles.h3,
            textAlign: textAlign,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.md),
          FadeInUp(
            duration: AppConstants.mediumAnimation,
            delay: Duration(milliseconds: delay + 200),
            child: Text(
              subtitle!,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textGrey,
              ),
              textAlign: textAlign,
            ),
          ),
        ],
      ],
    );
  }
}
