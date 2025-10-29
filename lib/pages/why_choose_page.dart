// Why Choose Logistechs Page
// Banner with information and brochure download button

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';

class WhyChoosePage extends StatelessWidget {
  const WhyChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.whyChoose),
            _buildBannerSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildKeyFeaturesSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: ResponsiveHelper.getVerticalSpacing(context),
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBannerContent(),
                const SizedBox(height: AppSpacing.xl),
                _buildBrochureDownload(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildBannerContent()),
                const SizedBox(width: AppSpacing.xxxl),
                _buildBrochureDownload(),
              ],
            ),
    );
  }

  Widget _buildBannerContent() {
    return FadeInLeft(
      duration: AppConstants.longAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose LOGISTECHS',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'LOGISTECHS keeps your finger on the pulse of your business through dependable, '
            'informative dashboards, custom alerts and meaningful, real-time intelligence '
            'through a mobile, digital business backbone that fuels strategic decision-making, '
            'at your fingertips.',
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildBrochureDownload() {
    return FadeInRight(
      duration: AppConstants.longAnimation,
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
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
          children: [
            const Icon(
              Icons.download,
              size: 60,
              color: Colors.black,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Download Logistechs Brochure',
              style: AppTextStyles.h5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Download brochure action
                  debugPrint('Download brochure');
                },
                icon: const Icon(Icons.file_download),
                label: Text(
                  'DOWNLOAD',
                  style: AppTextStyles.button,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyFeaturesSection(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.dashboard_customize,
        'title': 'Dashboards that Matter',
        'description': 'Role-based dashboards and KPIs tailored to logistics: OTIF, utilization, empty miles and more.',
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Actionable Alerts',
        'description': 'Real-time exceptions and custom thresholds so your team reacts before issues escalate.',
      },
      {
        'icon': Icons.extension,
        'title': 'Open Integrations',
        'description': 'Accounting, trackers/telemetry and data exports via an open API and ready-made connectors.',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Apps',
        'description': 'Flutter-powered Driver and Customer apps for e‑POD, tracking, chat and document access.',
      },
      {
  'icon': Icons.lock_outline,
        'title': 'Your Deployment, Your Choice',
        'description': 'Run on a secured private cloud or on‑prem. Keep data ownership and meet compliance.',
      },
      {
        'icon': Icons.tune,
        'title': 'Custom Workflows',
        'description': 'Model your real processes—forms, approvals and rules that match how your depots work.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          FadeInDown(
            duration: AppConstants.mediumAnimation,
            child: Text(
              'Key Features That Set Us Apart',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.getGridColumns(context),
              mainAxisSpacing: AppSpacing.xl,
              crossAxisSpacing: AppSpacing.xl,
              childAspectRatio: 1.0,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              return _buildFeatureCard(
                icon: features[index]['icon'],
                title: features[index]['title'],
                description: features[index]['description'],
                delay: index * 100,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.black,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.h5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
