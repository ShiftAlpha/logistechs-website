// Features Page
// Real demo screenshots, comprehensive feature descriptions based on actual app functionality

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
              alignRight: false,
              centered: true,
              description: 'A complete, integrated logistics management platform designed specifically for African '
                  'road freight. From invoice capture to final delivery, LOGISTECHS digitizes your entire '
                  'logistics workflow with hardware-integrated scanning, silent printing, and real-time tracking.',
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
    final List<Map<String, String>> screenshots = [
      {
        'image': 'assets/images/screenshots/login.png',
        'title': 'Secure Login',
        'description': 'Multi-role authentication for Inhouse, Depot, and Master users',
      },
      {
        'image': 'assets/images/screenshots/table view & tool bar (inhouse).png',
        'title': 'Inhouse Dashboard',
        'description': 'Complete trip and waybill management from client locations',
      },
      {
        'image': 'assets/images/screenshots/table view & tool bar (inhouse) expanded.png',
        'title': 'Expanded View',
        'description': 'Detailed item-level visibility with filtering and search',
      },
      {
        'image': 'assets/images/screenshots/waybill form.png',
        'title': 'Waybill Creation',
        'description': 'Fast invoice and item capture with API integration',
      },
      {
        'image': 'assets/images/screenshots/tripdetails.png',
        'title': 'Trip Details',
        'description': 'Comprehensive trip management with vehicle and driver assignment',
      },
      {
        'image': 'assets/images/screenshots/scan dialog.png',
        'title': 'Concurrent Scanning',
        'description': 'Background scanning while others use the system - multi-user efficiency',
      },
      {
        'image': 'assets/images/screenshots/scan dialog2.png',
        'title': 'Scan Tracking',
        'description': 'Real-time item tracking through the logistics pipeline',
      },
      {
        'image': 'assets/images/screenshots/pallet management.png',
        'title': 'Pallet Management',
        'description': 'Visual UI for grouping items and managing consignment floor',
      },
      {
        'image': 'assets/images/screenshots/driver-management.png',
        'title': 'Driver Management',
        'description': 'Assign drivers, vehicles, and waybills with real-time GPS tracking',
      },
      {
        'image': 'assets/images/screenshots/driver-portal.png',
        'title': 'Depot UI',
        'description': 'Complete depot control hub with trip tables, status tabs, and inhouse management',
      },
      {
        'image': 'assets/images/screenshots/pod-generation-dialog.png',
        'title': 'POD Generation',
        'description': 'Select inhouses to generate Proof of Delivery documents',
      },
      {
        'image': 'assets/images/screenshots/scan-with-filters.png',
        'title': 'Driver Settings',
        'description': 'Configure driver management, vehicle assignments, and user access controls',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - waybill form.png',
        'title': 'Waybill Preferences',
        'description': 'Customize waybill forms and default settings',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - POD.png',
        'title': 'POD Settings',
        'description': 'Configure proof of delivery options and formats',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - doc export.png',
        'title': 'Document Export',
        'description': 'Generate manifests in PDF, Excel, or CSV formats',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - pallet management.png',
        'title': 'Pallet Configuration',
        'description': 'Set up pallet grouping rules and box structures',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - View.png',
        'title': 'View Preferences',
        'description': 'Personalize your workspace and table layouts',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - Account.png',
        'title': 'Account Management',
        'description': 'User profile, permissions, and security settings',
      },
      {
        'image': 'assets/images/screenshots/settings dialog - profile.png',
        'title': 'Profile Settings',
        'description': 'Manage personal information and preferences',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'See Logistechs In Action',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Comprehensive feature showcase',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          carousel.CarouselSlider(
            options: carousel.CarouselOptions(
              height: ResponsiveHelper.isMobile(context) ? 400 : 500,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              enlargeCenterPage: true,
              viewportFraction: ResponsiveHelper.isMobile(context) ? 0.9 : 0.7,
              onPageChanged: (index, reason) {
                setState(() => _currentCarouselIndex = index);
              },
            ),
            items: screenshots.map((screenshot) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.xl),
                              topRight: Radius.circular(AppRadius.xl),
                            ),
                            child: Image.asset(
                              screenshot['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.nearWhiteBackground,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported, size: 60),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppRadius.xl),
                              bottomRight: Radius.circular(AppRadius.xl),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                screenshot['title']!,
                                style: AppTextStyles.h4.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                screenshot['description']!,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: screenshots.asMap().entries.map((entry) {
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
        'title': '1. Digital Trip & Waybill Management',
        'description': 'Create and manage trips with full waybill tracking. Capture invoices directly at client locations, '
            'build complete trip manifests, and track every waybill from creation to delivery. Inhouse clerks deployed at '
            'client sites handle the entire "client book" digitally.',
        'icon': Icons.description,
        'imageLeft': true,
      },
      {
        'title': '2. Invoice & Item Capture',
        'description': 'Fast data entry with optional API integration - clients can send invoices directly to your endpoint. '
            'Each item gets a unique barcode for tracking through the entire logistics pipeline. Clerks can add, update, or '
            'delete items with complete edit control from item-level up to full trip scope.',
        'icon': Icons.inventory_2,
        'imageLeft': false,
      },
      {
        'title': '3. Label Generation & Printing',
        'description': 'Hardware-integrated label printing with Brother QL-800 thermal printers and Pantum 2512W A4 printers. '
            'Starter tier uses dialog-based printing, while Professional and Enterprise tiers get silent background printing. '
            'Print individual item labels, waybill barcodes, or full trip documentation instantly.',
        'icon': Icons.print,
        'imageLeft': true,
      },
      {
        'title': '4. Advanced Scanning & Status Tracking',
        'description': 'Track items through every stage of the logistics pipeline with M-LINK DS6100CB scanners. Items progress through status stages: '
            'captured → scanned → unloaded → loaded → dispatched → completed. Professional and Enterprise tiers get concurrent background scanning - '
            'multiple users can scan simultaneously while others use the system for different tasks. Icon-based status filters allow instant filtering '
            'by any status stage. Real-time notifications for matched and unmatched scans with color-coded visual feedback.',
        'icon': Icons.qr_code_scanner,
        'imageLeft': false,
      },
      {
        'title': '5. Manifest Generation',
        'description': 'Generate trip manifests in PDF, Excel, or CSV formats. Choose from plain table view, filtered by area, '
            'stacked by pallet, or per-page layouts. Show detailed client information with waybills, invoices, and items, or create '
            'custom filtered views. Generate by current day or custom date ranges.',
        'icon': Icons.article,
        'imageLeft': true,
      },
      {
        'title': '6. Proof of Delivery (POD) System',
        'description': 'Generate 4-copy PODs per waybill: one for client, driver, transportation company, and receiver signature. '
            'Traditional paper-based system transitioning to digital ePODs through the driver mobile app with GPS verification. '
            'Drivers must be within delivery radius to unlock the deliver button.',
        'icon': Icons.check_circle_outline,
        'imageLeft': false,
      },
      {
        'title': '7. Pallet Management',
        'description': 'Visual UI for grouping items based on box structure. Move items between pallets via drag-and-drop interface, '
            'print separate pallet labels for consignment floor efficiency. Perfect for dispatch floors and depot loading/unloading zones. '
            'Complete control over pallet grouping and individual box management.',
        'icon': Icons.widgets,
        'imageLeft': true,
      },
      {
        'title': '8. Multi-Role User System',
        'description': 'Four user types: Inhouse clerks (capture invoices at client sites), Depot users (control hub operations, vehicle/driver '
            'assignment, route management), Master users (add depots/inhouses, set user preferences, manage routes and client books), '
            'and Admin users. Each role has specific permissions and workflows.',
        'icon': Icons.people,
        'imageLeft': false,
      },
      {
        'title': '9. Depot Control Hub',
        'description': 'Depot users manage inflow and outflow of items after vehicle arrival from inhouse locations. Assign waybills to specific '
            'vehicles, manage drivers and routes, track car location via API integration. See all linked inhouse data, scan for unload and load operations. '
            'Complete visibility across all connected inhouse locations.',
        'icon': Icons.warehouse,
        'imageLeft': true,
      },
      {
        'title': '10. Driver Management & POD Portal',
        'description': 'Comprehensive driver and vehicle management with real-time tracking. Assign drivers to vehicles, manage waybills through '
            'intuitive drag-and-drop interface with map visualization. Driver portal provides mobile-friendly POD interface with status filtering '
            '(captured, scanned, loaded, dispatched, completed). Location-based delivery confirmation - drivers must be within client radius to complete '
            'delivery. Integrated Cartrack GPS tracking for real-time vehicle position monitoring. Generate PODs by inhouse with multi-select dialog.',
        'icon': Icons.local_shipping,
        'imageLeft': false,
      },
      {
        'title': '11. Client Portal',
        'description': 'Track & trace portal for clients to monitor their waybills in real-time. View items on map showing vehicle location via tracking API. '
            'See scan status at every checkpoint in the logistics pipeline. Complete visibility from pickup to final delivery without contacting support.',
        'icon': Icons.track_changes,
        'imageLeft': true,
      },
      {
        'title': '12. API Integrations',
        'description': 'Invoice API integration - clients can point their systems to your endpoint for automatic invoice import with all details. '
            'Vehicle tracking API integrations including Cartrack and Orbcomm Sky Q5 for real-time GPS visibility across different fleet management systems. '
            'Extendable architecture for future integrations with accounting systems, WMS platforms, and custom endpoints.',
        'icon': Icons.api,
        'imageLeft': false,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Complete Feature Set',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '12 Core Features Powering African Road Freight',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          ...features.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
              child: _buildFeatureItem(
                context,
                icon: entry.value['icon'],
                title: entry.value['title'],
                description: entry.value['description'],
                imageLeft: entry.value['imageLeft'],
                delay: entry.key * 150,
              ),
            );
          }).toList(),
        ],
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
      child: Icon(
        icon,
        size: 120,
        color: Colors.black,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: imageLeft
          ? [
              SizedBox(width: 120, child: Align(alignment: Alignment.topCenter, child: imageWidget)),
              const SizedBox(width: AppSpacing.xxxl),
              Expanded(child: textWidget),
            ]
          : [
              Expanded(child: textWidget),
              const SizedBox(width: AppSpacing.xxxl),
              SizedBox(width: 120, child: Align(alignment: Alignment.topCenter, child: imageWidget)),
            ],
    );
  }

  Widget _buildModulesGrid(BuildContext context) {
    final modules = [
      {
        'icon': Icons.business,
        'title': 'Inhouse Operations',
        'desc': 'Clerks deployed at client sites capture invoices, build manifests, manage pallets, and control the entire client book digitally.'
      },
      {
        'icon': Icons.warehouse,
        'title': 'Depot Control',
        'desc': 'Hub operations managing vehicle assignment, driver allocation, route planning, and tracking inflow/outflow of all items.'
      },
      {
        'icon': Icons.smartphone,
        'title': 'Driver Mobile App',
        'desc': 'ePOD system with GPS verification. Delivery unlocked within radius, client PIN required for completion. Full job tracking.'
      },
      {
        'icon': Icons.person_outline,
        'title': 'Client Portal',
        'desc': 'Real-time waybill tracking via map view and scan status. Complete visibility without contacting support.'
      },
      {
        'icon': Icons.admin_panel_settings,
        'title': 'Master Control',
        'desc': 'Add depots and inhouses, set user preferences, manage routes, control client books, and configure system-wide settings.'
      },
      {
        'icon': Icons.qr_code_scanner,
        'title': 'Concurrent Scanning',
        'desc': 'Background scanning system - multiple users scan simultaneously while others use the system. Real-time notifications.'
      },
      {
        'icon': Icons.print,
        'title': 'Silent Printing',
        'desc': 'Hardware-integrated thermal and A4 printing. Professional/Enterprise tiers get background printing without dialog interruptions.'
      },
      {
        'icon': Icons.api,
        'title': 'API Integrations',
        'desc': 'Invoice API for automatic import, vehicle tracking API for GPS visibility. Extendable for custom integrations.'
      },
      {
        'icon': Icons.computer,
        'title': 'Ubuntu Linux Deployment',
        'desc': 'Runs on Ubuntu machines with Brother QL-800 thermal printers, Pantum 2512W A4 printers, and M-LINK scanners.'
      },
      {
        'icon': Icons.devices,
        'title': 'Multi-Device Support',
        'desc': 'Desktop app for inhouse/depot users, mobile app for drivers, web portal for clients. Complete cross-platform coverage.'
      },
      {
        'icon': Icons.settings,
        'title': 'User Preferences',
        'desc': 'Customizable prefixes, form defaults, view layouts, POD settings, export formats, and role-specific configurations.'
      },
      {
        'icon': Icons.verified,
        'title': 'Activity Logging',
        'desc': 'Complete audit trail of user actions (implementation in progress). Admins can review all edits, additions, and deletions.'
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'System Capabilities',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Built specifically for African road freight operations',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isMobile(context)
                  ? 1
                  : (ResponsiveHelper.isTablet(context) ? 2 : 3),
              mainAxisSpacing: AppSpacing.xl,
              crossAxisSpacing: AppSpacing.xl,
              childAspectRatio: ResponsiveHelper.isMobile(context) ? 1.8 : 1.3,
            ),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final m = modules[index];
              return FadeInUp(
                duration: AppConstants.longAnimation,
                delay: Duration(milliseconds: 80 * index),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(m['icon'] as IconData, size: 48, color: AppColors.primaryBlue),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        m['title'] as String,
                        style: AppTextStyles.h5.copyWith(color: AppColors.primaryBlue),
                        textAlign: TextAlign.center,
                      ),
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
