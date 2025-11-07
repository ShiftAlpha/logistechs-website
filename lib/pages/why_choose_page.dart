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
            'The only African road freight platform with hardware-integrated scanning, silent printing, '
            'and true concurrent multi-user operations. Built specifically for the unique challenges of '
            'African logistics - from inhouse client deployments to final delivery tracking.',
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Unlike generic TMS solutions, LOGISTECHS understands African road freight workflows. '
            'Our system handles everything from invoice capture at client sites to GPS-verified ePODs, '
            'with Ubuntu Linux deployment and Brother/Pantum hardware integration built in.',
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
            _BrochureCountdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyFeaturesSection(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.qr_code_scanner,
        'title': 'Concurrent Background Scanning',
        'description': 'Multiple users scan simultaneously while others work. M-LINK DS6100CB integration with real-time notifications. No workflow interruptions.',
      },
      {
        'icon': Icons.print,
        'title': 'Silent Hardware Printing',
        'description': 'Brother QL-800 thermal and Pantum 2512W A4 printers with background job processing. Print hundreds of labels without dialog interruptions.',
      },
      {
        'icon': Icons.widgets,
        'title': 'Visual Pallet Management',
        'description': 'Drag-and-drop UI for grouping items by box structure. Print separate pallet labels for consignment floor efficiency. Perfect for depot operations.',
      },
      {
        'icon': Icons.people,
        'title': 'Multi-Role System',
        'description': 'Inhouse clerks at client sites, depot hub control, master admin oversight, and driver mobile app. Each role has specific workflows and permissions.',
      },
      {
        'icon': Icons.business,
        'title': 'Inhouse Client Deployment',
        'description': 'Deploy clerks at client locations to capture invoices directly. Build complete client books with API integration. Unique to African road freight.',
      },
      {
        'icon': Icons.smartphone,
        'title': 'GPS-Verified ePODs',
        'description': 'Driver mobile app unlocks delivery only within client radius. Client PIN required for sign-off. Complete digital POD with location proof.',
      },
      {
        'icon': Icons.track_changes,
        'title': 'Client Portal with Map Tracking',
        'description': 'Real-time waybill tracking via map view and scan checkpoints. Vehicle tracking API integration. Complete visibility without support calls.',
      },
      {
        'icon': Icons.api,
        'title': 'Invoice API Integration',
        'description': 'Clients point their systems to your endpoint for automatic invoice import. Zero manual data entry. Full item details captured instantly.',
      },
      {
        'icon': Icons.computer,
        'title': 'Ubuntu Linux Deployment',
        'description': 'Runs natively on Ubuntu with Python daemons for scanner and printer integration. Complete hardware control and reliability.',
      },
      {
        'icon': Icons.article,
        'title': 'Advanced Manifest Generation',
        'description': 'PDF, Excel, CSV formats. Plain, filtered by area, stacked by pallet, per-page, or custom layouts. Complete flexibility for your workflows.',
      },
      {
        'icon': Icons.warehouse,
        'title': 'Depot Control Hub',
        'description': 'Manage inflow/outflow, vehicle assignment, driver allocation, route planning. See all linked inhouse data from central control.',
      },
      {
        'icon': Icons.public,
        'title': 'Built for African Road Freight',
        'description': 'Designed specifically for African logistics challenges. Current clients across South Africa. Understands local workflows and requirements.',
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
            child: Column(
              children: [
                Text(
                  'Competitive Advantages',
                  style: AppTextStyles.h2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Features that set LOGISTECHS apart from generic TMS solutions',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textLight),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isMobile(context)
                  ? 1
                  : (ResponsiveHelper.isTablet(context) ? 2 : 3),
              mainAxisSpacing: AppSpacing.xl,
              crossAxisSpacing: AppSpacing.xl,
              childAspectRatio: ResponsiveHelper.isMobile(context) ? 1.5 : 1.1,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              return _buildFeatureCard(
                icon: features[index]['icon'],
                title: features[index]['title'],
                description: features[index]['description'],
                delay: index * 80,
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
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.h5.copyWith(color: AppColors.primaryBlue),
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

// Countdown widget for brochure release
class _BrochureCountdown extends StatefulWidget {
  @override
  State<_BrochureCountdown> createState() => _BrochureCountdownState();
}

class _BrochureCountdownState extends State<_BrochureCountdown> {
  late DateTime _targetDate;
  late Stream<DateTime> _ticker;

  @override
  void initState() {
    super.initState();
    _targetDate = DateTime(2025, 12, 1); // December 1st, 2025
    _ticker = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  Duration _calculateTimeRemaining() {
    final now = DateTime.now();
    if (now.isBefore(_targetDate)) {
      return _targetDate.difference(now);
    } else {
      return Duration.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _ticker,
      builder: (context, snapshot) {
        final timeRemaining = _calculateTimeRemaining();
        
        final days = timeRemaining.inDays;
        final hours = timeRemaining.inHours % 24;
        final minutes = timeRemaining.inMinutes % 60;
        final seconds = timeRemaining.inSeconds % 60;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.event_available,
                color: AppColors.accentOrange,
                size: 48,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Coming Soon!',
                style: AppTextStyles.h5.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Brochure available on December 1st, 2025',
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeUnit(days.toString().padLeft(2, '0'), 'DAYS'),
                  const SizedBox(width: AppSpacing.sm),
                  Text(':', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(width: AppSpacing.sm),
                  _buildTimeUnit(hours.toString().padLeft(2, '0'), 'HRS'),
                  const SizedBox(width: AppSpacing.sm),
                  Text(':', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(width: AppSpacing.sm),
                  _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'MIN'),
                  const SizedBox(width: AppSpacing.sm),
                  Text(':', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(width: AppSpacing.sm),
                  _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'SEC'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.accentOrange,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
