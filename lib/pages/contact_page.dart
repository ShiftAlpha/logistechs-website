/// Contact Us Page
/// Banner, three columns (contact info, form, map), and footer

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/page_banner.dart';
import '../widgets/contact_form.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../utils/url_helper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.contact),
            const PageBanner(
              title: 'ADVANCE YOUR VISIBILITY',
              subtitle: 'Book your demo',
            ),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildContactSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: (isMobile || isTablet)
          ? Column(
              children: [
                _buildContactInfo(),
                const SizedBox(height: AppSpacing.xxxl),
                _buildContactFormSection(),
                const SizedBox(height: AppSpacing.xxxl),
                _buildMapSection(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildContactInfo()),
                const SizedBox(width: AppSpacing.xl),
                Expanded(child: _buildContactFormSection()),
                const SizedBox(width: AppSpacing.xl),
                Expanded(child: _buildMapSection()),
              ],
            ),
    );
  }

  Widget _buildContactInfo() {
    return FadeInLeft(
      duration: AppConstants.longAnimation,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildContactItem(
              icon: FontAwesomeIcons.phone,
              text: AppConstants.phone,
              onTap: () => UrlHelper.launchPhone(AppConstants.phone),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildContactItem(
              icon: FontAwesomeIcons.envelope,
              text: AppConstants.email,
              onTap: () => UrlHelper.launchEmail(AppConstants.email),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildContactItem(
              icon: FontAwesomeIcons.locationDot,
              text: AppConstants.address,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
    required VoidCallback? onTap,
  }) {
    return MouseRegion(
      cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.bodyMedium.copyWith(
                  decoration: onTap != null 
                      ? TextDecoration.underline 
                      : TextDecoration.none,
                  color: onTap != null 
                      ? AppColors.primaryBlue 
                      : AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactFormSection() {
    return FadeInUp(
      duration: AppConstants.longAnimation,
      delay: const Duration(milliseconds: 200),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a message',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppSpacing.xl),
            const ContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return FadeInRight(
      duration: AppConstants.longAnimation,
      delay: const Duration(milliseconds: 400),
      child: Container(
        height: 600,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Location',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.detailedAddress,
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.textLight),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.map,
                        size: 80,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Map Placeholder',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '431 The William, Deinfern, Johannesburg',
                        style: AppTextStyles.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
