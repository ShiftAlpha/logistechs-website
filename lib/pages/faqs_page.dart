/// FAQs Page
/// Frequently Asked Questions with expandable panels

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
    {
      'question': 'CAN LOGISTECHS INTEGRATE INTO MY EXISTING SOFTWARE?',
      'answer': 'LOGISTECHS is able to integrate into any software with A.P.I. capability, including '
          'accounting and tracker solutions.',
    },
    {
      'question': 'CAN I ACCESS LOGISTECHS FROM OUTSIDE MY BUSINESS?',
      'answer': 'LOGISTECHS can be implemented on-site (making it inaccessible from outside your '
          'business\'s walls) or on a secured private cloud server, which will allow you to '
          'manage and monitor your business from anywhere, anytime.',
    },
    {
      'question': 'DOES LOGISTECHS REQUIRE HIGH-PERFORMANCE HARDWARE TO OPERATE?',
      'answer': 'LOGISTECHS can run on any computer with a minimum of 4 GB of RAM and a working '
          'internet connection, via any browser (Edge/Chrome/Firefox).',
    },
    {
      'question': 'DOES MY TEAM REQUIRE EXTENSIVE COMPUTER SKILLS TO OPERATE LOGISTECHS?',
      'answer': 'Basic computer literacy is sufficient to operate LOGISTECHS, thanks to its user-friendly, '
          'logistics-centric interface and intuitive user workflows.',
    },
    {
      'question': 'DOES LOGISTECHS HAVE A DRIVER APP?',
      'answer': 'LOGISTECHS can be configured with or without the Muvyr Driver app.\n\n'
          'The Muvyr Driver app enables your drivers to complete checklists, view all upcoming trips, '
          'be tracked in real-time (outside of your tracking devices) and upload digital proofs of '
          'deliveries (e-signed on the app).',
    },
    {
      'question': 'DOES LOGISTECHS ONLY MANAGE TRIPS?',
      'answer': 'LOGISTECHS provides an integrated solution that allows you to manage your:\n'
          '• Fleet (Prime movers, trailers, equipment)\n'
          '• H.R. (Basic information, documentation, historical data)\n'
          '• S.H.E.Q. (Dynamic digital checklists)\n'
          '• Customers (Customer Portal, Digital S.L.A.\'s, load submission, in-app chat)\n'
          '• Finance (Revenue tracking, cost accounting)',
    },
    {
      'question': 'HOW CUSTOMISABLE IS LOGISTECHS?',
      'answer': 'The LOGISTECHS application is built on a foundation that speaks directly to the Road Freight '
          'industry whilst being highly customizable to your organization\'s unique requirements.\n\n'
          'LOGISTECHS mirrors your team\'s responsibilities and workflows to facilitate a digital, streamlined '
          'version of your existing operating procedures, allowing your human resource pool to focus their '
          'value more effectively.',
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
              color: Colors.black.withOpacity(0.1),
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
