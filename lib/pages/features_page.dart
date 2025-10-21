/// Features Page
/// Page banner, carousel, and alternating feature sections

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/page_banner.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.features),
            PageBanner(
              title: 'Features',
              alignRight: true,
              description: 'Whilst most Road Freight software solutions exist in siloed, digital spaces, '
                  'LOGISTECHS solution represents an integrated, centralized platform that is powered by '
                  'core elements from Transport Management, Resource Planning, Route Optimization and '
                  'Fleet Management software.',
            ),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildCarouselSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildFeaturesList(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSection(BuildContext context) {
    final List<Map<String, String>> carouselItems = [
      {
        'title': 'Transport Management',
        'description': 'Comprehensive transport management system for efficient fleet operations',
      },
      {
        'title': 'Resource Planning',
        'description': 'Optimize your resources with intelligent planning and allocation',
      },
      {
        'title': 'Route Optimization',
        'description': 'Save time and fuel with advanced route optimization algorithms',
      },
      {
        'title': 'Fleet Management',
        'description': 'Complete visibility and control over your entire fleet',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: ResponsiveHelper.isMobile(context) ? 0.9 : 0.8,
              onPageChanged: (index, reason) {
                setState(() => _currentCarouselIndex = index);
              },
            ),
            items: carouselItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.primaryBlue.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxxl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 60,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Text(
                            item['title']!,
                            style: AppTextStyles.h2.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            item['description']!,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselItems.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarouselIndex == entry.key
                      ? AppColors.primaryBlue
                      : AppColors.textLight,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Integrated Platform',
        'description': 'All your logistics tools in one centralized platform. No more switching between multiple systems.',
        'icon': Icons.apps,
        'imageLeft': true,
      },
      {
        'title': 'Real-Time Visibility',
        'description': 'Track your shipments, vehicles, and drivers in real-time. Stay informed with live updates and notifications.',
        'icon': Icons.visibility,
        'imageLeft': false,
      },
      {
        'title': 'Advanced Analytics',
        'description': 'Make data-driven decisions with comprehensive analytics, reports, and dashboards tailored to your business.',
        'icon': Icons.analytics,
        'imageLeft': true,
      },
      {
        'title': 'Seamless Integration',
        'description': 'Integrate with your existing systems including accounting software, trackers, and other business tools.',
        'icon': Icons.integration_instructions,
        'imageLeft': false,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
            child: _buildFeatureItem(
              context,
              icon: entry.value['icon'],
              title: entry.value['title'],
              description: entry.value['description'],
              imageLeft: entry.value['imageLeft'],
              delay: entry.key * 200,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool imageLeft,
    required int delay,
  }) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    final imageWidget = FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 100,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
    
    final textWidget = FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay + 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            description,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
    
    if (isMobile) {
      return Column(
        children: [
          imageWidget,
          const SizedBox(height: AppSpacing.xl),
          textWidget,
        ],
      );
    }
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: imageLeft
          ? [
              Expanded(child: imageWidget),
              const SizedBox(width: AppSpacing.xxxl),
              Expanded(child: textWidget),
            ]
          : [
              Expanded(child: textWidget),
              const SizedBox(width: AppSpacing.xxxl),
              Expanded(child: imageWidget),
            ],
    );
  }
}
