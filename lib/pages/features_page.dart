// Features Page
// Page banner, carousel, and alternating feature sections

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
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
            _buildModulesGrid(context),
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
          carousel.CarouselSlider(
            options: carousel.CarouselOptions(
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
                          AppColors.primaryBlue.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
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
                            color: AppColors.white.withValues(alpha: 0.9),
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
                              color: AppColors.white.withValues(alpha: 0.9),
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
        'title': 'Transport Management',
        'description': 'Digitize dispatch with load consolidation, trip planning, milestone tracking and proof-of-delivery (POD). Bring orders, trips and PODs into a single flow.',
        'icon': Icons.local_shipping,
        'imageLeft': true,
      },
      {
        'title': 'Resource Planning',
        'description': 'Plan drivers, tractors, trailers and depots against capacity. Manage availability, shifts and utilization with clear calendars.',
        'icon': Icons.event_available,
        'imageLeft': false,
      },
      {
        'title': 'Route Optimization',
        'description': 'Optimize routes, reduce empty miles and improve on-time delivery using geo-visibility and smart routing suggestions.',
        'icon': Icons.alt_route,
        'imageLeft': true,
      },
      {
        'title': 'Fleet Management',
        'description': 'Track asset health, service schedules, defects and costs. Keep vehicles road-ready with maintenance workflows and reminders.',
        'icon': Icons.directions_car,
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
          color: AppColors.primaryBlue.withValues(alpha: 0.1),
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

  Widget _buildModulesGrid(BuildContext context) {
    final modules = [
      {
        'icon': Icons.smartphone,
        'title': 'Driver App',
        'desc': 'Trips, checklists, live tracking and e‑POD captured in a clean mobile workflow.'
      },
      {
        'icon': Icons.person_outline,
        'title': 'Customer Portal',
        'desc': 'Live ETA, order tracking, document downloads and SLA visibility for your clients.'
      },
      {
        'icon': Icons.extension,
        'title': 'Integrations & API',
        'desc': 'Connect accounting, telemetry/trackers and data lakes. Open API for custom needs.'
      },
      {
        'icon': Icons.dashboard_customize,
        'title': 'Dashboards & Alerts',
        'desc': 'Role‑based dashboards, KPIs and real‑time alerts that surface what matters.'
      },
      {
        'icon': Icons.payments,
        'title': 'Finance & Costing',
        'desc': 'Revenue tracking, trip costing and export to your finance stack.'
      },
      {
        'icon': Icons.badge_outlined,
        'title': 'HR & Compliance',
        'desc': 'Docs, certifications and expiries across drivers and staff.'
      },
      {
        'icon': Icons.fact_check,
        'title': 'SHEQ & Inspections',
        'desc': 'Digital checklists, incidents and audits for safe, compliant operations.'
      },
      {
        'icon': Icons.build_circle_outlined,
        'title': 'Maintenance',
        'desc': 'Services, defects, parts and workshop jobs to keep assets road‑ready.'
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Solution Modules',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getGridColumns(context),
              mainAxisSpacing: AppSpacing.xl,
              crossAxisSpacing: AppSpacing.xl,
              childAspectRatio: 1.2,
            ),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final m = modules[index];
              return FadeInUp(
                duration: AppConstants.longAnimation,
                delay: Duration(milliseconds: 100 * index),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(m['icon'] as IconData, size: 40, color: AppColors.primaryBlue),
                      const SizedBox(height: AppSpacing.md),
                      Text(m['title'] as String, style: AppTextStyles.h5, textAlign: TextAlign.center),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        m['desc'] as String,
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
