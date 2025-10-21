/// App Routes Configuration
/// Defines all route names and route generator for navigation

import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/company_page.dart';
import '../pages/features_page.dart';
import '../pages/faqs_page.dart';
import '../pages/contact_page.dart';
import '../pages/why_choose_page.dart';

class AppRoutes {
  // Route Names
  static const String home = '/';
  static const String company = '/company';
  static const String features = '/features';
  static const String faqs = '/faqs';
  static const String contact = '/contact';
  static const String whyChoose = '/why-choose';
  
  /// Generate routes based on route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case company:
        return MaterialPageRoute(builder: (_) => const CompanyPage());
      case features:
        return MaterialPageRoute(builder: (_) => const FeaturesPage());
      case faqs:
        return MaterialPageRoute(builder: (_) => const FaqsPage());
      case contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      case whyChoose:
        return MaterialPageRoute(builder: (_) => const WhyChoosePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
  
  /// Get route name display text
  static String getRouteName(String route) {
    switch (route) {
      case home:
        return 'Home';
      case company:
        return 'Company';
      case features:
        return 'Features';
      case faqs:
        return 'FAQs';
      case contact:
        return 'Contact Us';
      case whyChoose:
        return 'Why Choose Logistechs';
      default:
        return '';
    }
  }
}
