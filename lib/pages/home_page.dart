// Home Page
// Main landing page with welcome section, benefits, and demo form

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
      child:
          isMobile
              ? custom.AnimatedContainer(
                isTransparent: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      duration: AppConstants.longAnimation,
                      child: Text('Logistechs', style: AppTextStyles.h2),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FadeInLeft(
                      duration: AppConstants.longAnimation,
                      delay: const Duration(milliseconds: 300),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Text(
                          'POWERING AFRICAN LOGISTICS',
                          style: AppTextStyles.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    // Logo image below text for mobile
                    Center(
                      child: FadeInUp(
                        duration: AppConstants.longAnimation,
                        delay: const Duration(milliseconds: 600),
                        child: Image.asset(
                          'assets/images/logistechs_icon.png',
                          width: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left text column
                  Expanded(
                    child: custom.AnimatedContainer(
                      isTransparent: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FadeInLeft(
                            duration: AppConstants.longAnimation,
                            child: Text('LOGISTECHS', style: AppTextStyles.h1),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          FadeInLeft(
                            duration: AppConstants.longAnimation,
                            delay: const Duration(milliseconds: 300),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Text(
                                'POWERING AFRICAN LOGISTICS',
                                style: AppTextStyles.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xxxl),
                  // Right logo column - height matches text column (stretched by IntrinsicHeight)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 286,
                      maxWidth: 416,
                    ),
                    child: custom.AnimatedContainer(
                      isTransparent: true,
                      child: Transform.translate(
                        offset: const Offset(0, -20),
                        child: Image.asset(
                          'assets/images/logistechs_icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
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
            title: 'Benefits',
            subtitle: 'Discover how we transform your logistics operations',
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount:
                isMobile
                    ? 1
                    : isTablet
                    ? 2
                    : 3,
            mainAxisSpacing: AppSpacing.xl,
            crossAxisSpacing: AppSpacing.xl,
            childAspectRatio: isMobile ? 1.5 : 1.2,
            children: [
              _buildBenefitCard(
                icon: Icons.local_shipping,
                title: 'Transport Management',
                description:
                    'Digitize dispatch, consolidate loads, track delivery milestones and PODs in one place.',
                delay: 0,
              ),
              _buildBenefitCard(
                icon: Icons.event_available,
                title: 'Resource Planning',
                description:
                    'Plan drivers, vehicles and depots with capacity views and utilization insights.',
                delay: 200,
              ),
              _buildBenefitCard(
                icon: Icons.alt_route,
                title: 'Route Optimization',
                description:
                    'Optimize routes and reduce empty miles with smart routing and geo-visibility.',
                delay: 400,
              ),
              _buildBenefitCard(
                icon: Icons.directions_car,
                title: 'Fleet & Maintenance',
                description:
                    'Track fleet health, service schedules and costs to keep assets road-ready.',
                delay: 600,
              ),
              _buildBenefitCard(
                icon: Icons.verified_user,
                title: 'Compliance & SHEQ',
                description:
                    'Digitize inspections, incidents and audits to stay compliant and safe.',
                delay: 800,
              ),
              _buildBenefitCard(
                icon: Icons.person_outline,
                title: 'Customer Portal',
                description:
                    'Give customers live ETA, tracking and proof-of-delivery for a seamless experience.',
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
              color: Colors.black.withValues(alpha: 0.1),
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
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.round),
              ),
              child: Icon(icon, size: 30, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTextStyles.h5, textAlign: TextAlign.center),
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
