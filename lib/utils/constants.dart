/// Constants file containing colors, text styles, and other app-wide constants
/// This file centralizes all design tokens for consistent theming across the application

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Colors
/// Near-white background with professional color scheme
class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color accentOrange = Color(0xFFFF6B35);
  
  // Background Colors
  static const Color nearWhiteBackground = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  
  // Text Colors
  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  
  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  
  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color linkedin = Color(0xFF0A66C2);
}

/// App Text Styles
/// Consistent typography throughout the application
class AppTextStyles {
  // Headings
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );
  
  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );
  
  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  
  static TextStyle h4 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  
  static TextStyle h5 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  
  // Body Text
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
    height: 1.6,
  );
  
  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
    height: 1.6,
  );
  
  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
    height: 1.6,
  );
  
  // Special Text Styles
  static TextStyle navLink = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );
  
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );
  
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
}

/// App Spacing
/// Consistent spacing values throughout the application
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// App Border Radius
class AppRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 24.0;
  static const double round = 999.0;
}

/// App Constants
class AppConstants {
  // Contact Information
  static const String phone = '+27 64 750 8514';
  static const String email = 'ask@logistechs.com';
  static const String address = 'Head office: RSA';
  static const String detailedAddress = '431 The William, Deinfern, Johannesburg';
  
  // Social Media Links
  static const String facebookUrl = 'https://www.facebook.com/';
  static const String twitterUrl = 'https://twitter.com/';
  static const String instagramUrl = 'https://www.instagram.com/';
  static const String linkedinUrl = 'https://www.linkedin.com/';
  
  // External Links
  static const String loginUrl = 'https://logistechs-edl.web.app/';
  
  // Company Information
  static const String companyName = 'LOGISTECHS';
  static const String copyright = '© 2025 LOGISTECHS | Powered by Genesis';
  
  // Vision and Mission
  static const String vision = 'To be the leading digital logistics platform across Africa';
  static const String mission = 'To power the African road freight one depot at a time.';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
}

/// Breakpoints for responsive design
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double wideDesktop = 1600;
}
