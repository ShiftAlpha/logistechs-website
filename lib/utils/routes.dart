// App Routes Configuration
// Defines all route names and route generator for navigation

import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/company_page.dart';
import '../pages/features_page.dart';
import '../pages/faqs_page.dart';
import '../pages/contact_page.dart';
import '../pages/why_choose_page.dart';
import '../pages/track_page.dart';
import '../pages/pricing_page.dart';
import '../pages/checkout_page.dart';
import '../pages/timeline_page.dart';

class AppRoutes {
  // Route Names
  static const String home = '/';
  static const String company = '/company';
  static const String features = '/features';
  static const String faqs = '/faqs';
  static const String contact = '/contact';
  static const String whyChoose = '/why-choose';
  static const String track = '/track';
  static const String pricing = '/pricing';
  static const String checkout = '/checkout';
  static const String timeline = '/roadmap';
  
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
      case track:
        return MaterialPageRoute(builder: (_) => const TrackPage());
      case pricing:
        return MaterialPageRoute(builder: (_) => const PricingPage());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutPage());
      case timeline:
        return MaterialPageRoute(builder: (_) => const TimelinePage());
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
      case track:
        return 'Track';
      case pricing:
        return 'Pricing';
      case checkout:
        return 'Checkout';
      default:
        return '';
    }
  }
}
