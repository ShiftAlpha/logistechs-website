// Responsive Helper Utilities
// Provides helper methods to determine screen size and build responsive layouts

import 'package:flutter/material.dart';
import 'constants.dart';

class ResponsiveHelper {
  /// Check if current device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }
  
  /// Check if current device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.mobile && width < AppBreakpoints.desktop;
  }
  
  /// Check if current device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktop;
  }
  
  /// Check if current device is wide desktop
  static bool isWideDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.wideDesktop;
  }
  
  /// Get responsive value based on screen size
  static T getResponsiveValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
  
  /// Get maximum content width for centered content
  static double getMaxContentWidth(BuildContext context) {
    if (isWideDesktop(context)) return 1400;
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 900;
    return MediaQuery.of(context).size.width;
  }
  
  /// Get horizontal padding based on screen size
  static double getHorizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 80.0;
    if (isTablet(context)) return 40.0;
    return 20.0;
  }
  
  /// Get vertical spacing based on screen size
  static double getVerticalSpacing(BuildContext context) {
    if (isDesktop(context)) return 80.0;
    if (isTablet(context)) return 60.0;
    return 40.0;
  }
  
  /// Get number of columns for grid layouts
  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) return 3;
    if (isTablet(context)) return 2;
    return 1;
  }
}

/// Responsive Widget Builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktop && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= AppBreakpoints.mobile && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
