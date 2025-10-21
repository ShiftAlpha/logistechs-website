/// Why Choose Logistechs Page
/// Banner with information and brochure download button

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
        color: AppColors.lightGrey,
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
              color: Colors.black.withOpacity(0.1),
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
              color: AppColors.primaryBlue,
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
                  backgroundColor: AppColors.primaryBlue,
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
        'icon': Icons.dashboard,
        'title': 'Informative Dashboards',
        'description': 'Get a comprehensive view of your operations with customizable dashboards that display the metrics that matter most to your business.',
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Custom Alerts',
        'description': 'Stay informed with real-time alerts tailored to your business needs. Never miss a critical event or opportunity.',
      },
      {
        'icon': Icons.insights,
        'title': 'Real-Time Intelligence',
        'description': 'Access meaningful, actionable insights in real-time. Make informed decisions based on current data, not yesterday\'s reports.',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Access',
        'description': 'Manage your business from anywhere with our mobile-friendly platform. Your business intelligence at your fingertips.',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Strategic Decision-Making',
        'description': 'Fuel your strategic planning with accurate, timely data. Make decisions that drive your business forward.',
      },
      {
        'icon': Icons.integration_instructions,
        'title': 'Digital Business Backbone',
        'description': 'Build your digital infrastructure on a platform designed for growth, scalability, and reliability.',
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
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryBlue,
                    AppColors.primaryBlue.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.round),
              ),
              child: Icon(
                icon,
                size: 35,
                color: AppColors.white,
              ),
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
