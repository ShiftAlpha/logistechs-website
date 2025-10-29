// Custom Navigation Bar Widget
// Top navigation bar with logo, menu items, social icons, and login/register buttons

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../utils/url_helper.dart';
import 'social_icon_button.dart';

class CustomNavBar extends StatefulWidget {
  final String currentRoute;
  
  const CustomNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  bool _isMobileMenuOpen = false;
  String? _hoveredItem;
  bool _isOurSolutionHovered = false;
  final LayerLink _ourSolutionLink = LayerLink();
  OverlayEntry? _ourSolutionOverlay;
  bool _hoverTrigger = false;
  bool _hoverOverlay = false;
  Timer? _hideTimer;

  void _showOurSolutionOverlay() {
    if (_ourSolutionOverlay != null) return;
  final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    _ourSolutionOverlay = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(
          children: [
            // Dismiss area
            Positioned.fill(
              child: GestureDetector(onTap: _hideNow),
            ),
            CompositedTransformFollower(
              link: _ourSolutionLink,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 8),
              showWhenUnlinked: false,
              child: MouseRegion(
                onEnter: (_) {
                  _hoverOverlay = true;
                  _isOurSolutionHovered = true;
                  _hideTimer?.cancel();
                  setState(() {});
                },
                onExit: (_) {
                  _hoverOverlay = false;
                  _scheduleHide();
                },
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDropdownItem('Features', AppRoutes.features),
                        const SizedBox(height: AppSpacing.sm),
                        _buildDropdownItem('FAQs', AppRoutes.faqs),
                        const SizedBox(height: AppSpacing.sm),
                        _buildDropdownItem('Why Choose Logistechs', AppRoutes.whyChoose),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(_ourSolutionOverlay!);
  }

  void _hideOurSolutionOverlay() {
    _ourSolutionOverlay?.remove();
    _ourSolutionOverlay = null;
    if (mounted) setState(() => _isOurSolutionHovered = false);
  }

  void _hideNow() {
    _hideTimer?.cancel();
    _hoverTrigger = false;
    _hoverOverlay = false;
    _hideOurSolutionOverlay();
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 150), () {
      if (!_hoverTrigger && !_hoverOverlay) {
        _hideOurSolutionOverlay();
      }
    });
  }

  @override
  void dispose() {
    _hideOurSolutionOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: AppSpacing.md,
      ),
      child: isDesktop ? _buildDesktopNav() : _buildMobileNav(),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        _buildLogo(),
        
        // Center Navigation Items
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem('Home', AppRoutes.home),
              const SizedBox(width: AppSpacing.xl),
              _buildNavItem('Company', AppRoutes.company),
              const SizedBox(width: AppSpacing.xl),
              _buildOurSolutionDropdown(),
              const SizedBox(width: AppSpacing.xl),
              _buildNavItem('Contact Us', AppRoutes.contact),
            ],
          ),
        ),
        
        // Right side: Social Icons and Login/Register
        Row(
          children: [
            _buildSocialIcons(),
            const SizedBox(width: AppSpacing.lg),
            _buildLoginRegister(),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            Row(
              children: [
                _buildLoginRegister(),
                IconButton(
                  icon: Icon(
                    _isMobileMenuOpen ? Icons.close : Icons.menu,
                    color: AppColors.primaryDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMobileMenuOpen = !_isMobileMenuOpen;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        if (_isMobileMenuOpen) _buildMobileMenu(),
      ],
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.home),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logistechs_icon.png',
              height: 72,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, String route) {
    final isActive = widget.currentRoute == route;
    final isHovered = _hoveredItem == title;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: AnimatedContainer(
          duration: AppConstants.shortAnimation,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: (isActive || isHovered) 
                    ? AppColors.primaryBlue 
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: AppTextStyles.navLink.copyWith(
              color: (isActive || isHovered) 
                  ? AppColors.primaryBlue 
                  : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOurSolutionDropdown() {
    return CompositedTransformTarget(
      link: _ourSolutionLink,
      child: MouseRegion(
        onEnter: (_) {
          _hoverTrigger = true;
          _isOurSolutionHovered = true;
          _hideTimer?.cancel();
          _showOurSolutionOverlay();
          setState(() {});
        },
        onExit: (_) {
          _hoverTrigger = false;
          _scheduleHide();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Our Solution',
              style: AppTextStyles.navLink.copyWith(
                color: _isOurSolutionHovered 
                    ? AppColors.primaryBlue 
                    : AppColors.textDark,
              ),
            ),
            Icon(
              _isOurSolutionHovered 
                  ? Icons.keyboard_arrow_up 
                  : Icons.keyboard_arrow_down,
              color: _isOurSolutionHovered 
                  ? AppColors.primaryBlue 
                  : AppColors.textDark,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String title, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _hideNow();
          Navigator.pushNamed(context, route);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
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
    );
  }

  Widget _buildLoginRegister() {
    return Row(
      children: [
        // Login icon
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => UrlHelper.launchURL(AppConstants.loginUrl),
            child: const Icon(
              FontAwesomeIcons.rightToBracket,
              size: 18,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Separator
        Text(
          '|',
          style: AppTextStyles.navLink.copyWith(color: AppColors.textLight),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Register icon
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => UrlHelper.launchURL(AppConstants.registerUrl),
            child: const Icon(
              FontAwesomeIcons.userPlus,
              size: 18,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenu() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMobileMenuItem('Home', AppRoutes.home),
          _buildMobileMenuItem('Company', AppRoutes.company),
          _buildMobileMenuItem('Features', AppRoutes.features),
          _buildMobileMenuItem('FAQs', AppRoutes.faqs),
          _buildMobileMenuItem('Why Choose Logistechs', AppRoutes.whyChoose),
          _buildMobileMenuItem('Contact Us', AppRoutes.contact),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(String title, String route) {
    return InkWell(
      onTap: () {
        setState(() => _isMobileMenuOpen = false);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: widget.currentRoute == route 
                ? AppColors.primaryBlue 
                : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
