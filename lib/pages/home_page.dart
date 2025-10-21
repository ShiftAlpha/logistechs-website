/// Home Page
/// Main landing page with welcome section, benefits, and demo form

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/contact_form.dart';
import '../widgets/section_title.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../widgets/animated_container.dart' as custom;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.home),
            _buildWelcomeSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildBenefitsSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildDemoSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: ResponsiveHelper.getVerticalSpacing(context) * 1.5,
      ),
      child: custom.AnimatedContainer(
        isTransparent: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInLeft(
              duration: AppConstants.longAnimation,
              child: Text(
                'Welcome to Logistechs',
                style: isMobile ? AppTextStyles.h2 : AppTextStyles.h1,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FadeInLeft(
              duration: AppConstants.longAnimation,
              delay: const Duration(milliseconds: 300),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  'LOGISTECHS keeps your finger on the pulse of your business through dependable, '
                  'informative dashboards, custom alerts and meaningful, real-time intelligence '
                  'through a mobile, digital business backbone that fuels strategic decision-making, '
                  'at your fingertips.',
                  style: AppTextStyles.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Logistechs Benefits',
            subtitle: 'Discover how we transform your logistics operations',
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
            mainAxisSpacing: AppSpacing.xl,
            crossAxisSpacing: AppSpacing.xl,
            childAspectRatio: isMobile ? 1.5 : 1.2,
            children: [
              _buildBenefitCard(
                icon: Icons.speed,
                title: 'Real-Time Tracking',
                description: 'Monitor your fleet and shipments in real-time with our advanced tracking system.',
                delay: 0,
              ),
              _buildBenefitCard(
                icon: Icons.analytics,
                title: 'Smart Analytics',
                description: 'Make data-driven decisions with comprehensive analytics and reporting.',
                delay: 200,
              ),
              _buildBenefitCard(
                icon: Icons.integration_instructions,
                title: 'Easy Integration',
                description: 'Seamlessly integrate with your existing systems and workflows.',
                delay: 400,
              ),
              _buildBenefitCard(
                icon: Icons.cloud,
                title: 'Cloud-Based',
                description: 'Access your data anywhere, anytime with our secure cloud platform.',
                delay: 600,
              ),
              _buildBenefitCard(
                icon: Icons.support_agent,
                title: '24/7 Support',
                description: 'Get round-the-clock support from our dedicated team of experts.',
                delay: 800,
              ),
              _buildBenefitCard(
                icon: Icons.security,
                title: 'Secure & Reliable',
                description: 'Your data is protected with enterprise-grade security measures.',
                delay: 1000,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard({
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.round),
              ),
              child: Icon(
                icon,
                size: 30,
                color: AppColors.primaryBlue,
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

  Widget _buildDemoSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'ADVANCE YOUR VISIBILITY',
            subtitle: 'Book a demo now',
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          custom.AnimatedContainer(
            delay: 300,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 600,
              ),
              child: const ContactForm(),
            ),
          ),
        ],
      ),
    );
  }
}
