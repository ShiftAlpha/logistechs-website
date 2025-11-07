// Track Parcel Page
// Displays parcel tracking search and detailed tracking information

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/tracking_model.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final TextEditingController _waybillController = TextEditingController();
  ParcelDetails? _trackedParcel;
  bool _hasSearched = false;
  bool _parcelFound = false;

  void _searchParcel() {
    final waybillNumber = _waybillController.text.trim();
    
    if (waybillNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a waybill number')),
      );
      return;
    }

    setState(() {
      _hasSearched = true;
      // For demo: if waybill matches the mock number, show results
      if (waybillNumber == 'D511012968943') {
        _trackedParcel = MockTrackingData.getMockParcel(waybillNumber);
        _parcelFound = true;
      } else {
        _parcelFound = false;
      }
    });
  }

  @override
  void dispose() {
    _waybillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomNavBar(currentRoute: '/track'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Section
            _buildSearchSection(isMobile),
            
            // Results Section
            if (_hasSearched)
              _parcelFound
                  ? _buildTrackingResults(isMobile, isTablet)
                  : _buildNotFoundSection(),
            
            // Information Section (shown when not searched yet)
            if (!_hasSearched)
              _buildInformationSection(isMobile, isTablet),
            
            // Footer
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Track my parcel',
            style: AppTextStyles.h2.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _waybillController,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Waybill number',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _searchParcel(),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _searchParcel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text(
                    'Track Now',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      color: AppColors.nearWhiteBackground,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          // Hero Section
          Text(
            'Real-Time Parcel Tracking',
            style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 800),
            child: Text(
              'Enter your waybill number above to track your parcel in real-time. '
              'Get detailed information about your delivery status, location updates, '
              'and estimated delivery time.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),

          // Features Grid
          _buildFeaturesGrid(isMobile, isTablet),

          SizedBox(height: isMobile ? 40 : 60),

          // How It Works Section
          _buildHowItWorksSection(isMobile, isTablet),

          SizedBox(height: isMobile ? 40 : 60),

          // Demo Section
          _buildDemoSection(isMobile),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid(bool isMobile, bool isTablet) {
    final features = [
      {
        'icon': Icons.location_on,
        'title': 'Live Location Tracking',
        'description': 'Track your parcel\'s current location in real-time with GPS-verified updates at every checkpoint.',
      },
      {
        'icon': Icons.update,
        'title': 'Status Updates',
        'description': 'Receive instant notifications at each stage: captured, scanned, loaded, dispatched, and delivered.',
      },
      {
        'icon': Icons.schedule,
        'title': 'Delivery Timeline',
        'description': 'View complete delivery history with timestamps for every scan point and location change.',
      },
      {
        'icon': Icons.map,
        'title': 'Route Visualization',
        'description': 'See the full journey of your parcel from sender to receiver with interactive map view.',
      },
      {
        'icon': Icons.verified_user,
        'title': 'ePOD Verification',
        'description': 'Digital proof of delivery with GPS verification, recipient signature, and delivery photos.',
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'description': 'Access tracking information anytime, anywhere. No account or login required.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
        mainAxisSpacing: AppSpacing.xl,
        crossAxisSpacing: AppSpacing.xl,
        childAspectRatio: isMobile ? 1.3 : 1.1,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Container(
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
                feature['icon'] as IconData,
                size: isMobile ? 48 : 56,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                feature['title'] as String,
                style: (isMobile ? AppTextStyles.h5 : AppTextStyles.h5).copyWith(
                  color: AppColors.primaryBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                feature['description'] as String,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHowItWorksSection(bool isMobile, bool isTablet) {
    final steps = [
      {
        'number': '1',
        'title': 'Enter Waybill Number',
        'description': 'Type or scan your unique waybill number in the search box above.',
      },
      {
        'number': '2',
        'title': 'View Tracking Details',
        'description': 'See real-time status, location updates, and complete delivery timeline.',
      },
      {
        'number': '3',
        'title': 'Monitor Delivery',
        'description': 'Track your parcel until successful delivery with ePOD confirmation.',
      },
    ];

    return Column(
      children: [
        Text(
          'How It Works',
          style: isMobile ? AppTextStyles.h3 : AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 30 : 40),
        
        isMobile 
          ? Column(
              children: steps.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < steps.length - 1 ? AppSpacing.xl : 0,
                  ),
                  child: _buildStepCard(entry.value, isMobile),
                );
              }).toList(),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: steps.map((step) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: _buildStepCard(step, isMobile),
                  ),
                );
              }).toList(),
            ),
      ],
    );
  }

  Widget _buildStepCard(Map<String, String> step, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.accentOrange, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentOrange.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: isMobile ? 60 : 70,
            height: isMobile ? 60 : 70,
            decoration: BoxDecoration(
              color: AppColors.accentOrange,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step['number']!,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isMobile ? 32 : 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            step['title']!,
            style: (isMobile ? AppTextStyles.h5 : AppTextStyles.h5).copyWith(
              color: AppColors.primaryBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            step['description']!,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? AppSpacing.xl : AppSpacing.xxxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue.withValues(alpha: 0.1), AppColors.accentOrange.withValues(alpha: 0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            size: isMobile ? 48 : 64,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Try Demo Tracking',
            style: isMobile ? AppTextStyles.h4 : AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Want to see how it works? Try our demo waybill number:',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.accentOrange, width: 2),
            ),
            child: SelectableText(
              'D511012968943',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () {
              _waybillController.text = 'D511012968943';
              _searchParcel();
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Try Demo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentOrange,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
                vertical: AppSpacing.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingResults(bool isMobile, bool isTablet) {
    if (_trackedParcel == null) return const SizedBox.shrink();

    if (isMobile) {
      return _buildMobileTrackingView();
    } else if (isTablet) {
      return _buildTabletTrackingView();
    } else {
      return _buildDesktopTrackingView();
    }
  }

  Widget _buildMobileTrackingView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSenderDetailsSection(),
          const SizedBox(height: 24),
          _buildReceiverDetailsSection(),
          const SizedBox(height: 24),
          _buildTimelineSection(),
        ],
      ),
    );
  }

  Widget _buildTabletTrackingView() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildSenderDetailsSection(),
                    const SizedBox(height: 24),
                    _buildReceiverDetailsSection(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: _buildTimelineSection(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMapSection(),
        ],
      ),
    );
  }

  Widget _buildDesktopTrackingView() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side - Sender & Receiver Details
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildSenderDetailsSection(),
                    const SizedBox(height: 24),
                    _buildReceiverDetailsSection(),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              // Middle - Timeline
              Expanded(
                flex: 1,
                child: _buildTimelineSection(),
              ),
              const SizedBox(width: 30),
              // Right Side - Map & Status
              Expanded(
                flex: 1,
                child: _buildMapAndStatusSection(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSenderDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SENDER DETAILS',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Date of drop off',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '07 Nov 2022 03H26',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Location code',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _trackedParcel!.senderLocationCode,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sent from',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _trackedParcel!.senderLocation,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sender name',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _trackedParcel!.senderName,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECIPIENT DETAILS',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Predicted arrival',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '13 Nov 2022 14H52',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Location code',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _trackedParcel!.receiverLocationCode,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Arrive to',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _trackedParcel!.receiverLocation,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRACKING TIMELINE',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _trackedParcel!.statuses.length,
            itemBuilder: (context, index) {
              final status = _trackedParcel!.statuses[index];
              final isLast = index == _trackedParcel!.statuses.length - 1;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline marker
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: status.isCompleted
                                  ? AppColors.accentOrange
                                  : AppColors.lightGrey,
                              border: Border.all(
                                color: status.isCompleted
                                    ? AppColors.accentOrange
                                    : AppColors.textLight,
                                width: 2,
                              ),
                            ),
                            child: status.isCompleted
                                ? const Icon(
                                    Icons.check,
                                    color: AppColors.white,
                                    size: 16,
                                  )
                                : Icon(
                                    Icons.local_shipping,
                                    color: AppColors.textLight,
                                    size: 16,
                                  ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 40,
                              color: status.isCompleted
                                  ? AppColors.accentOrange.withOpacity(0.3)
                                  : AppColors.textLight.withOpacity(0.3),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Status info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _formatTime(status.timestamp),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              status.statusName,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!isLast) const SizedBox(height: 8),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapAndStatusSection() {
    return Column(
      children: [
        _buildMapSection(),
        const SizedBox(height: 24),
        _buildStatusInfoSection(),
      ],
    );
  }

  Widget _buildMapSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(AppRadius.md),
        color: AppColors.lightGrey,
      ),
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simplified map representation with location markers
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              color: AppColors.nearWhiteBackground,
              border: Border.all(
                color: AppColors.textLight.withOpacity(0.2),
              ),
            ),
            child: Stack(
              children: [
                // Map background (placeholder)
                Center(
                  child: Text(
                    'MAP VIEW',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ),
                // Route line (simplified)
                CustomPaint(
                  painter: RoutePainter(),
                  size: Size.infinite,
                ),
                // Sender location marker
                Positioned(
                  left: 30,
                  top: 40,
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentOrange,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentOrange.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sender',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Vehicle location marker (current)
                Positioned(
                  right: 60,
                  top: 100,
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryBlue,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          FontAwesomeIcons.truck,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'In Transit',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Receiver location marker
                Positioned(
                  right: 20,
                  bottom: 40,
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.success,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.success.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Receiver',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfoSection() {
    final currentStatus = _trackedParcel!.statuses
        .where((s) => s.isCompleted == false)
        .firstOrNull ?? _trackedParcel!.statuses.last;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.accentOrange),
        borderRadius: BorderRadius.circular(AppRadius.md),
        color: AppColors.accentOrange.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentOrange,
                ),
                child: const Icon(
                  FontAwesomeIcons.truck,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      currentStatus.statusName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Location: ${currentStatus.location}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Last updated: ${_formatTime(currentStatus.timestamp)}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFoundSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Parcel not found',
            style: AppTextStyles.h4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'The waybill number "${_waybillController.text}" could not be found in our system.\nPlease check the number and try again.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasSearched = false;
                _waybillController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentOrange,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: Text(
              'Search Again',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day $month $year $hour$minute';
  }
}

// Custom painter for the route line
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentOrange.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw a curved line from sender to receiver through vehicle
    final path = Path()
      ..moveTo(70, 80)
      ..cubicTo(size.width / 2, size.height / 3, size.width / 2, 2 * size.height / 3, size.width - 60, size.height - 80);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RoutePainter oldDelegate) => false;
}
