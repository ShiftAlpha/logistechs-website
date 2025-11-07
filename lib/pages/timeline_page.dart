// Timeline Page
// Interactive roadmap showing LOGISTECHS development phases

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/page_banner.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  int? _selectedMilestone;

  final List<Map<String, dynamic>> _phases = [
    {
      'phase': 'Phase 1',
      'milestones': [
        {
          'title': 'Website Launch',
          'date': '25/11/25',
          'description': 'Launch of the official LOGISTECHS website with full feature documentation, '
              'pricing tiers, and company information. Track & trace portal goes live for client access.',
          'icon': Icons.language,
        },
        {
          'title': 'Pre-orders',
          'date': '11/12/25',
          'description': 'Open pre-orders for all licensing tiers with early-bird discounts. '
              'Hardware bundle packages available with Brother QL-800, Pantum printers, and M-LINK scanners.',
          'icon': Icons.shopping_cart,
        },
        {
          'title': 'App Launch',
          'date': '08/01/26',
          'description': 'Full production release of LOGISTECHS platform. All features live including '
              'hardware-integrated scanning, silent printing, ePODs, and multi-role user management. '
              'Ubuntu Linux deployment packages ready.',
          'icon': Icons.rocket_launch,
        },
      ],
    },
    {
      'phase': 'Phase 2',
      'milestones': [
        {
          'title': 'Web3 Integration',
          'date': 'Q1 2026',
          'description': 'Blockchain-based proof of delivery verification. Immutable delivery records, '
              'smart contract automation for payment release, and decentralized dispute resolution.',
          'icon': Icons.link,
        },
        {
          'title': 'End-To-End Cold Chain',
          'date': 'Q2 2026',
          'description': 'Temperature monitoring integration for refrigerated transport. Real-time alerts, '
              'compliance documentation, and automated cold chain integrity reports for pharmaceutical and food logistics.',
          'icon': Icons.ac_unit,
        },
        {
          'title': 'ICO',
          'date': 'Q2 2026',
          'description': 'Initial Coin Offering for LOGISTECHS utility token. Token holders get platform '
              'fee discounts, priority support, and governance voting rights for feature development.',
          'icon': Icons.monetization_on,
        },
        {
          'title': 'Market',
          'date': 'Q4 2026',
          'description': 'LOGISTECHS token listed on major cryptocurrency exchanges. Decentralized logistics '
              'marketplace opens - drivers, carriers, and shippers can transact directly with token-based payments.',
          'icon': Icons.store,
        },
      ],
    },
    {
      'phase': 'Phase 3',
      'milestones': [
        {
          'title': 'African Roadnetwork',
          'date': '2027 TBC',
          'description': 'Pan-African logistics network expansion. Cross-border tracking, multi-currency support, '
              'and integration with African Continental Free Trade Area (AfCFTA) digital systems. Real-time customs clearance status.',
          'icon': Icons.map,
        },
        {
          'title': 'African Seaboard',
          'date': '2027 TBC',
          'description': 'Maritime logistics integration. Container tracking from African ports, vessel scheduling, '
              'port congestion alerts, and intermodal transport coordination between road freight and shipping lines.',
          'icon': Icons.directions_boat,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.timeline),
            PageBanner(
              title: 'Development Roadmap',
              centered: true,
              description: 'Our vision for revolutionizing African logistics - from launch to continental integration',
            ),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildTimelineContent(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineContent(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: AppSpacing.xxxl,
      ),
      child: isMobile ? _buildVerticalTimeline() : _buildHorizontalTimeline(),
    );
  }

  Widget _buildVerticalTimeline() {
    int globalIndex = 0;
    
    return Column(
      children: _phases.asMap().entries.map((phaseEntry) {
        final phaseIndex = phaseEntry.key;
        final phase = phaseEntry.value;
        final milestones = phase['milestones'] as List;
        
        return Column(
          children: [
            // Phase Header
            FadeInUp(
              duration: AppConstants.mediumAnimation,
              delay: Duration(milliseconds: phaseIndex * 200),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Text(
                  phase['phase'],
                  style: AppTextStyles.h3.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            
            // Milestones in single column with vertical line connecting them
            ...milestones.asMap().entries.map((entry) {
              final milestoneIndex = entry.key;
              final milestone = entry.value;
              final currentGlobalIndex = globalIndex++;
              final isLastInPhase = milestoneIndex == milestones.length - 1;
              
              return Column(
                children: [
                  // Card (full width)
                  _buildMilestoneCard(
                    milestone: milestone,
                    index: currentGlobalIndex,
                    delay: (phaseIndex * 4 + milestoneIndex) * 150,
                    alignment: Alignment.centerLeft,
                    isLeft: false,
                  ),
                  // Vertical connector (line and dot) - skip for last card in phase
                  if (!isLastInPhase) ...[
                    const SizedBox(height: AppSpacing.lg),
                    // Vertical line
                    Container(
                      width: 2,
                      height: AppSpacing.xl,
                      color: Colors.grey.shade700,
                    ),
                    // Dot
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                    // Vertical line
                    Container(
                      width: 2,
                      height: AppSpacing.xl,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ],
              );
            }).toList(),
            
            if (phaseIndex < _phases.length - 1)
              const SizedBox(height: AppSpacing.xxxl * 2),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildHorizontalTimeline() {
    int globalIndex = 0;
    
    return Column(
      children: _phases.asMap().entries.map((phaseEntry) {
        final phaseIndex = phaseEntry.key;
        final phase = phaseEntry.value;
        final milestones = phase['milestones'] as List;
        
        return Column(
          children: [
            // Phase Header
            FadeInDown(
              duration: AppConstants.mediumAnimation,
              delay: Duration(milliseconds: phaseIndex * 200),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxxl,
                  vertical: AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Text(
                  phase['phase'],
                  style: AppTextStyles.h3.copyWith(color: AppColors.white),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            
            // Milestones with center line down the middle
            ...milestones.asMap().entries.map((entry) {
              final milestoneIndex = entry.key;
              final milestone = entry.value;
              final isLeft = milestoneIndex.isEven;
              final currentGlobalIndex = globalIndex++;
              final isLastInPhase = milestoneIndex == milestones.length - 1;
              final isFirstInPhase = milestoneIndex == 0;
              
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Horizontal line to card (half width from center)
                      if (!isFirstInPhase || isLeft)
                        Positioned(
                          left: isLeft ? null : MediaQuery.of(context).size.width / 2,
                          right: isLeft ? MediaQuery.of(context).size.width / 2 : null,
                          child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width / 2 - AppSpacing.xl - 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      // Horizontal line from phase to first card's center dot
                      if (isFirstInPhase && !isLeft)
                        Positioned(
                          right: MediaQuery.of(context).size.width / 2,
                          top: -AppSpacing.xxxl,
                          child: Container(
                            height: AppSpacing.xxxl + 12,
                            width: 2,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      // Card on left or right
                      Row(
                        children: [
                          // Left side
                          Expanded(
                            child: isLeft
                                ? Padding(
                                    padding: const EdgeInsets.only(right: AppSpacing.xl),
                                    child: _buildMilestoneCard(
                                      milestone: milestone,
                                      index: currentGlobalIndex,
                                      delay: (phaseIndex * 4 + milestoneIndex) * 150,
                                      alignment: Alignment.centerRight,
                                      isLeft: true,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          // Center dot
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                          ),
                          // Right side
                          Expanded(
                            child: !isLeft
                                ? Padding(
                                    padding: const EdgeInsets.only(left: AppSpacing.xl),
                                    child: _buildMilestoneCard(
                                      milestone: milestone,
                                      index: currentGlobalIndex,
                                      delay: (phaseIndex * 4 + milestoneIndex) * 150,
                                      alignment: Alignment.centerLeft,
                                      isLeft: false,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Vertical line down from center (skip for last card in phase)
                  if (!isLastInPhase)
                    Container(
                      width: 2,
                      height: AppSpacing.xxxl * 1.5,
                      color: Colors.grey.shade700,
                    ),
                ],
              );
            }).toList(),
            
            if (phaseIndex < _phases.length - 1)
              const SizedBox(height: AppSpacing.xxxl * 2),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildMilestoneCard({
    required Map<String, dynamic> milestone,
    required int index,
    required int delay,
    required bool isLeft,
    Alignment? alignment,
  }) {
    final isSelected = _selectedMilestone == index;
    
    return FadeInUp(
      duration: AppConstants.mediumAnimation,
      delay: Duration(milliseconds: delay),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedMilestone = isSelected ? null : index;
          });
        },
        child: AnimatedContainer(
          duration: AppConstants.mediumAnimation,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: isSelected ? AppColors.accentOrange : Colors.grey.shade700,
              width: isSelected ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.2 : 0.1),
                blurRadius: isSelected ? 20 : 10,
                offset: Offset(0, isSelected ? 10 : 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon on left for left cards
              if (isLeft) ...[
                Icon(
                  milestone['icon'] ?? Icons.event,
                  size: 100,
                  color: isSelected ? AppColors.accentOrange : Colors.grey.shade700,
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: alignment == Alignment.centerRight 
                      ? CrossAxisAlignment.end 
                      : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: alignment == Alignment.centerRight
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.accentOrange : Colors.black,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Text(
                            milestone['date'],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      milestone['title'],
                      style: AppTextStyles.h4.copyWith(
                        color: isSelected ? AppColors.accentOrange : Colors.black,
                      ),
                      textAlign: alignment == Alignment.centerRight 
                          ? TextAlign.right 
                          : TextAlign.left,
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: AppSpacing.md),
                      FadeInUp(
                        duration: AppConstants.mediumAnimation,
                        child: Text(
                          milestone['description'],
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textLight,
                          ),
                          textAlign: alignment == Alignment.centerRight 
                              ? TextAlign.right 
                              : TextAlign.left,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Icon(
                      isSelected ? Icons.expand_less : Icons.expand_more,
                      color: isSelected ? AppColors.accentOrange : Colors.black,
                    ),
                  ],
                ),
              ),
              // Icon on right for right cards
              if (!isLeft) ...[
                const SizedBox(width: AppSpacing.md),
                Icon(
                  milestone['icon'] ?? Icons.event,
                  size: 100,
                  color: isSelected ? AppColors.accentOrange : Colors.grey.shade700,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
