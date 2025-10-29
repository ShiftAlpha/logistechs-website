// Page Banner Widget
// Reusable page banner/hero section with title and description

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';

class PageBanner extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? actionButton;
  final bool alignRight;
  final String? backgroundImage;
  final bool centered;
  
  const PageBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.actionButton,
    this.alignRight = false,
    this.backgroundImage,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: ResponsiveHelper.getVerticalSpacing(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
                opacity: 0.2,
              )
            : null,
      ),
      child: Align(
        alignment: centered
            ? Alignment.center
            : (alignRight && !isMobile 
                ? Alignment.centerRight 
                : Alignment.centerLeft),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 600,
          ),
          child: Column(
            crossAxisAlignment: centered
                ? CrossAxisAlignment.center
                : (alignRight && !isMobile
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start),
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subtitle != null) ...[
                FadeInDown(
                  duration: AppConstants.mediumAnimation,
                  child: Text(
                    subtitle!,
                    style: AppTextStyles.h5.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: centered
                        ? TextAlign.center
                        : (alignRight && !isMobile 
                            ? TextAlign.right 
                            : TextAlign.left),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              FadeInDown(
                duration: AppConstants.mediumAnimation,
                delay: const Duration(milliseconds: 200),
                child: Text(
                  title,
                  style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2,
                  textAlign: centered
                      ? TextAlign.center
                      : (alignRight && !isMobile 
                          ? TextAlign.right 
                          : TextAlign.left),
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: AppSpacing.lg),
                FadeInUp(
                  duration: AppConstants.mediumAnimation,
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    description!,
                    style: AppTextStyles.bodyLarge,
                    textAlign: centered
                        ? TextAlign.center
                        : (alignRight && !isMobile 
                            ? TextAlign.right 
                            : TextAlign.left),
                  ),
                ),
              ],
              if (actionButton != null) ...[
                const SizedBox(height: AppSpacing.xl),
                FadeInUp(
                  duration: AppConstants.mediumAnimation,
                  delay: const Duration(milliseconds: 600),
                  child: actionButton!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
