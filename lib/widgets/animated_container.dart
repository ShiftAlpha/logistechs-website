/// Animated Container Widget
/// Reusable animated container with fade-in and slide-up effects

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/constants.dart';

class AnimatedContainer extends StatelessWidget {
  final Widget child;
  final int delay;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool isTransparent;
  
  const AnimatedContainer({
    super.key,
    required this.child,
    this.delay = 0,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay),
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
        margin: margin,
        decoration: BoxDecoration(
          color: isTransparent 
              ? Colors.transparent 
              : backgroundColor ?? AppColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppRadius.lg,
          ),
          boxShadow: isTransparent
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
