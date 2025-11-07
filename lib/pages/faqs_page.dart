// FAQs Page
// Frequently Asked Questions with expandable panels

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/section_title.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    // Pricing & Packages
    {
      'question': 'What are the pricing tiers and what\'s included?',
      'answer': 'LOGISTECHS offers three tiers:\n\n'
          '• Starter: Web-only access, linear scanning, dialog-based printing. No hardware included. License pricing TBD.\n\n'
          '• Professional: Includes 2 complete machine packages (R23,000), wireless background scanning, silent printing. License pricing TBD.\n\n'
          '• Enterprise: R45,000/month + R33,000 setup (includes R10,000 onboarding + R23,000 for 2 machine packages). Fully managed service.\n\n'
          'Each machine package (R11,500) includes: Ubuntu machine, Brother QL-800 thermal printer, Pantum 2512W A4 printer, and M-LINK DS6100CB scanner.',
    },
    {
      'question': 'What\'s the difference between scanning tiers?',
      'answer': 'Starter tier uses linear scanning - one person scans at a time, blocking other system use.\n\n'
          'Professional and Enterprise tiers get concurrent background scanning - multiple users can scan simultaneously '
          'while others use the system for different tasks. Real-time notifications show matched and unmatched scans. '
          'This dramatically improves efficiency in busy depot environments.',
    },
    {
      'question': 'What is silent printing and which tiers include it?',
      'answer': 'Silent printing sends jobs directly to hardware without dialog interruptions. Documents print in the '
          'background while users continue working.\n\n'
          'Starter tier uses dialog-based printing (requires user confirmation each time).\n\n'
          'Professional and Enterprise tiers include silent printing for both thermal labels and A4 documents. '
          'This is critical for high-volume operations where clerks print hundreds of labels daily.',
    },
    {
      'question': 'Can I add more machines after purchase?',
      'answer': 'Yes! Additional machine packages cost R11,500 each and include the full hardware set (Ubuntu machine, '
          'thermal printer, A4 printer, scanner). You can scale up as your operations grow.\n\n'
          'Professional and Enterprise tiers also offer add-ons like additional master users, depot licenses, '
          'inhouse licenses, extra vehicle tracking integrations, and priority support.',
    },
    
    // Features & Functionality
    {
      'question': 'What user roles does LOGISTECHS support?',
      'answer': 'Four main roles:\n\n'
          '• Inhouse Clerks: Deployed at client sites to capture invoices, create waybills, manage pallets, and build the client book.\n\n'
          '• Depot Users: Control hub operations including vehicle assignment, driver management, route planning, and inflow/outflow tracking.\n\n'
          '• Master Users: System administrators who add depots/inhouses, set user preferences, manage routes, and control client books (1 per enterprise).\n\n'
          '• Drivers: Access via mobile app for ePODs with GPS verification and client PIN confirmation.',
    },
    {
      'question': 'How does the pallet management system work?',
      'answer': 'LOGISTECHS provides a visual UI where you can group items based on box structure. Drag and drop items '
          'between pallets, print separate labels for each pallet, and manage the entire consignment floor digitally.\n\n'
          'Perfect for dispatch floors and depot loading/unloading zones. Clerks have complete control over pallet '
          'grouping and individual box management, significantly improving efficiency in warehouse operations.',
    },
    {
      'question': 'What manifest formats can I generate?',
      'answer': 'Generate manifests in PDF, Excel, or CSV formats with multiple layout options:\n\n'
          '• Plain: Standard table view of all data\n'
          '• Filtered by Area: Group by delivery region\n'
          '• Stacked: Organized by pallet grouping\n'
          '• Per Page: One client per page for detailed breakdown\n'
          '• Custom: Define your own filters and layouts\n\n'
          'Manifests can be generated for current day or custom date ranges, showing client details, waybills, invoices, and individual items.',
    },
    {
      'question': 'How does the POD (Proof of Delivery) system work?',
      'answer': 'Traditional system generates 4-copy PODs per waybill: one for client, driver, transportation company, '
          'and receiver signature.\n\n'
          'Modern ePOD system (via driver mobile app): Driver\'s deliver button unlocks only when within GPS radius of '
          'client location. Client provides PIN to sign off digitally. Full job tracking until depot briefing. '
          'This is transitioning the entire POD process to digital with location verification.',
    },
    {
      'question': 'Can I track items in real-time?',
      'answer': 'Yes! Each item gets a unique barcode tracked through the entire logistics pipeline. Scanning happens at key '
          'checkpoints: client pickup, depot arrival, pallet grouping, vehicle loading, and final delivery.\n\n'
          'Inhouse clerks, depot users, and clients (via portal) can view item whereabouts at any time. The scanning system '
          'provides real-time notifications and complete visibility from pickup to final delivery.',
    },
    
    // Technical & Integration
    {
      'question': 'What hardware does LOGISTECHS require?',
      'answer': 'LOGISTECHS runs on Ubuntu Linux machines with:\n'
          '• Brother QL-800 thermal label printers\n'
          '• Pantum 2512W A4 printers\n'
          '• M-LINK DS6100CB barcode scanners\n\n'
          'Professional and Enterprise tiers include 2 complete machine packages. Additional packages available for R11,500 each. '
          'Starter tier is web-only (you provide your own hardware).',
    },
    {
      'question': 'Does LOGISTECHS integrate with other systems?',
      'answer': 'Yes! Two main integration types:\n\n'
          '• Invoice API: Clients can point their systems to your endpoint for automatic invoice import with all details. '
          'No manual data entry required.\n\n'
          '• Vehicle Tracking API: Real-time GPS visibility of your fleet. Clients see vehicle location on map in their portal.\n\n'
          'The architecture is extendable for future integrations with accounting systems, WMS platforms, and custom endpoints.',
    },
    {
      'question': 'How does the Client Portal work?',
      'answer': 'Clients get their own web portal to:\n'
          '• Track waybills in real-time via map view\n'
          '• See scan status at every checkpoint\n'
          '• View vehicle location (via tracking API integration)\n'
          '• Monitor complete logistics pipeline\n\n'
          'Complete visibility without contacting your support team. Reduces inquiry calls and improves client satisfaction.',
    },
    {
      'question': 'What is the Driver Mobile App?',
      'answer': 'Mobile app for drivers and driver assistants with:\n'
          '• ePOD system with GPS verification\n'
          '• Location-based delivery unlock (must be within client radius)\n'
          '• Client PIN requirement for sign-off\n'
          '• Full job tracking until depot briefing\n\n'
          'Each driver/assistant gets unique username and password. App currently in development for production rollout.',
    },
    
    // Implementation & Support
    {
      'question': 'How long does setup take?',
      'answer': 'Starter tier: Immediate access once license is activated. You handle your own setup.\n\n'
          'Professional tier: 2-4 weeks for hardware delivery and setup. Optional R10,000 full setup service available.\n\n'
          'Enterprise tier: 3-5 weeks for complete implementation including hardware, onboarding, training, and configuration. '
          'Fully managed with dedicated support.',
    },
    {
      'question': 'Do you provide training?',
      'answer': 'Training varies by tier:\n\n'
          '• Starter: Self-service documentation and video tutorials\n'
          '• Professional: Basic training session + documentation\n'
          '• Enterprise: Comprehensive onboarding, role-specific training, and ongoing support\n\n'
          'The system is designed to be intuitive - basic computer literacy is sufficient. User-friendly interface '
          'with logistics-centric workflows minimizes learning curve.',
    },
    {
      'question': 'Is LOGISTECHS suitable for small logistics companies?',
      'answer': 'Absolutely! That\'s why we offer the Starter tier. You can start with web-only access and basic features, '
          'then upgrade to Professional or Enterprise as you grow.\n\n'
          'The system scales with your business - from single depot operations to multi-location enterprises with '
          'numerous inhouse deployments. Perfect for African road freight operations of any size.',
    },
    {
      'question': 'What currencies do you support?',
      'answer': 'Pricing is available in:\n'
          '• ZAR (South African Rand) - base currency\n'
          '• USD (US Dollar)\n'
          '• EUR (Euro)\n'
          '• GBP (British Pound)\n\n'
          'Currency converter is available in the navigation bar. All prices automatically convert based on your selection.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.faqs),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildFaqsSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Frequently Asked Questions',
            subtitle: 'Find answers to common questions about LOGISTECHS',
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: _faqs.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _buildFaqItem(
                    question: entry.value['question']!,
                    answer: entry.value['answer']!,
                    index: entry.key,
                    delay: entry.key * 100,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required String question,
    required String answer,
    required int index,
    required int delay,
  }) {
    final isExpanded = _expandedIndex == index;
    
    return FadeInUp(
      duration: AppConstants.mediumAnimation,
      delay: Duration(milliseconds: delay),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          question,
                          style: AppTextStyles.h5.copyWith(
                            color: isExpanded 
                                ? AppColors.primaryBlue 
                                : AppColors.textDark,
                          ),
                        ),
                      ),
                      Icon(
                        isExpanded 
                            ? Icons.keyboard_arrow_up 
                            : Icons.keyboard_arrow_down,
                        color: isExpanded 
                            ? AppColors.primaryBlue 
                            : AppColors.textGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: AppConstants.shortAnimation,
              height: isExpanded ? null : 0,
              child: isExpanded
                  ? Container(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.lg,
                        right: AppSpacing.lg,
                        bottom: AppSpacing.lg,
                      ),
                      child: Text(
                        answer,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
