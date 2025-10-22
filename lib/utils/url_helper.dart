// URL Launcher Helper
// Handles opening external URLs, emails, and phone calls

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlHelper {
  /// Launch URL in browser
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
  
  /// Launch email client
  static Future<void> launchEmail(String email, {String? subject, String? body}) async {
    String emailUrl = 'mailto:$email';
    if (subject != null || body != null) {
      emailUrl += '?';
      if (subject != null) emailUrl += 'subject=${Uri.encodeComponent(subject)}';
      if (subject != null && body != null) emailUrl += '&';
      if (body != null) emailUrl += 'body=${Uri.encodeComponent(body)}';
    }
    
    final Uri uri = Uri.parse(emailUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch email client');
    }
  }
  
  /// Launch phone dialer
  static Future<void> launchPhone(String phoneNumber) async {
    final String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri uri = Uri.parse('tel:$cleanNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch phone dialer');
    }
  }
  
  /// Launch social media link
  static Future<void> launchSocialMedia(String url) async {
    await launchURL(url);
  }
}
