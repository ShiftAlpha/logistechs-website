/// Custom Footer Widget
/// Four-section footer with logo, quick links, contact info, and social icons
/// Includes scroll-to-top button and copyright notice

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../utils/url_helper.dart';
import 'social_icon_button.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return Container(
      color: AppColors.primaryDark,
      padding: EdgeInsets.all(
        ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          isDesktop 
              ? _buildDesktopFooter(context)
              : _buildMobileFooter(context),
          const Divider(color: Colors.white24, height: 40),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildLogoSection()),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: _buildQuickLinks(context)),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: _buildContactInfo()),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: _buildSocialsSection()),
        const SizedBox(width: AppSpacing.lg),
        _buildScrollToTop(context),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogoSection(),
        const SizedBox(height: AppSpacing.xl),
        _buildQuickLinks(context),
        const SizedBox(height: AppSpacing.xl),
        _buildContactInfo(),
        const SizedBox(height: AppSpacing.xl),
        _buildSocialsSection(),
        const SizedBox(height: AppSpacing.xl),
        Center(child: _buildScrollToTop(context)),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LOGISTECHS',
          style: AppTextStyles.h4.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Powering African logistics',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: AppTextStyles.h5.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildFooterLink(context, 'Home', AppRoutes.home),
        _buildFooterLink(context, 'Company', AppRoutes.company),
        _buildFooterLink(context, 'Features', AppRoutes.features),
        _buildFooterLink(context, 'FAQs', AppRoutes.faqs),
        _buildFooterLink(context, 'Why Choose Logistechs', AppRoutes.whyChoose),
        _buildFooterLink(context, 'Contact Us', AppRoutes.contact),
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: AppTextStyles.h5.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => UrlHelper.launchPhone(AppConstants.phone),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(
                AppConstants.phone,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => UrlHelper.launchEmail(AppConstants.email),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Text(
                AppConstants.email,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Text(
            AppConstants.address,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Socials',
          style: AppTextStyles.h5.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            SocialIconButton(
              icon: FontAwesomeIcons.facebookF,
              color: AppColors.facebook,
              onTap: () => UrlHelper.launchSocialMedia(AppConstants.facebookUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            SocialIconButton(
              icon: FontAwesomeIcons.twitter,
              color: AppColors.twitter,
              onTap: () => UrlHelper.launchSocialMedia(AppConstants.twitterUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            SocialIconButton(
              icon: FontAwesomeIcons.instagram,
              color: AppColors.instagram,
              onTap: () => UrlHelper.launchSocialMedia(AppConstants.instagramUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            SocialIconButton(
              icon: FontAwesomeIcons.linkedin,
              color: AppColors.linkedin,
              onTap: () => UrlHelper.launchSocialMedia(AppConstants.linkedinUrl),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScrollToTop(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(AppRadius.round),
          ),
          child: const Icon(
            Icons.keyboard_arrow_up,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Text(
      AppConstants.copyright,
      style: AppTextStyles.caption.copyWith(
        color: Colors.white54,
      ),
      textAlign: TextAlign.center,
    );
  }
}
