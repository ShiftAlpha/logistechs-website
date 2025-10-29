// Company Page
// Our Story section with alternating text/images, Vision and Mission

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/section_title.dart';
import '../utils/constants.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: AppRoutes.company),
            _buildOurStorySection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            _buildVisionMissionSection(context),
            SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildOurStorySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: ResponsiveHelper.getVerticalSpacing(context),
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Our Story',
            subtitle: 'Building the future of African logistics',
          ),
          SizedBox(height: ResponsiveHelper.getVerticalSpacing(context)),
          
          // Story paragraphs with alternating images
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.left,
            icon: Icons.local_shipping,
            text: 'LOGISTECHS was born from a vision to revolutionize the African logistics industry. '
                'We recognized the unique challenges faced by road freight operators across the continent '
                'and set out to create a comprehensive digital solution that addresses these needs.',
            delay: 0,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.right,
            icon: Icons.memory,
            text: 'Our platform integrates cutting-edge technology with deep industry expertise to deliver '
                'a solution that truly understands the complexities of road freight operations. From real-time '
                'tracking to advanced analytics, we provide the tools you need to stay competitive.',
            delay: 200,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.left,
            icon: Icons.public,
            text: 'Sea and air freight logistics have long benefited from digital transformation, but road '
                'freight has lagged behind. LOGISTECHS bridges this gap, bringing world-class digital capabilities '
                'to road freight operators across Africa.',
            delay: 400,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.right,
            icon: Icons.tune,
            text: 'We understand that every logistics operation is unique. That\'s why LOGISTECHS is highly '
                'customizable, adapting to your specific workflows and requirements. Our solution grows with your '
                'business, scaling seamlessly as your operations expand.',
            delay: 600,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.left,
            icon: Icons.handshake,
            text: 'Through partnerships with leading logistics companies and continuous innovation, we stay at '
                'the forefront of industry developments. Our commitment to excellence drives us to constantly improve '
                'and expand our platform\'s capabilities.',
            delay: 800,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          
          _buildStoryParagraph(
            context,
            imagePosition: ImagePosition.right,
            icon: Icons.public,
            text: 'Today, LOGISTECHS serves logistics operators across Africa, helping them streamline operations, '
                'reduce costs, and improve service delivery. Join us on our journey to transform African logistics, '
                'one depot at a time.',
            delay: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildStoryParagraph(
    BuildContext context, {
    required ImagePosition imagePosition,
    required IconData icon,
    required String text,
    required int delay,
  }) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    if (isMobile) {
      return Column(
        children: [
          _buildStoryImage(icon: icon, delay: delay),
          const SizedBox(height: AppSpacing.lg),
          _buildStoryText(text: text, delay: delay + 200),
        ],
      );
    }
    
    final textWidget = Expanded(
      child: _buildStoryText(text: text, delay: delay),
    );
    
    final imageWidget = Expanded(
      child: _buildStoryImage(icon: icon, delay: delay + 200),
    );
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: imagePosition == ImagePosition.left
          ? [imageWidget, const SizedBox(width: AppSpacing.xxxl), textWidget]
          : [textWidget, const SizedBox(width: AppSpacing.xxxl), imageWidget],
    );
  }

  Widget _buildStoryText({required String text, required int delay}) {
    return FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay),
      child: Text(
        text,
        style: AppTextStyles.bodyLarge,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildStoryImage({required IconData icon, required int delay}) {
    return FadeInUp(
      duration: AppConstants.longAnimation,
      delay: Duration(milliseconds: delay),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: 100,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildVisionMissionSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildVisionCard(),
                const SizedBox(height: AppSpacing.xl),
                _buildMissionCard(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildVisionCard()),
                const SizedBox(width: AppSpacing.xl),
                Expanded(child: _buildMissionCard()),
              ],
            ),
    );
  }

  Widget _buildVisionCard() {
    return FadeInLeft(
      duration: AppConstants.longAnimation,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.visibility,
                  size: 36,
                  color: Color(0xFF1E3A8A),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Our Vision',
                  style: AppTextStyles.h3.copyWith(color: Color(0xFF1E3A8A)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.vision,
              style: AppTextStyles.bodyLarge.copyWith(color: const Color(0xFF1E3A8A)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionCard() {
    return FadeInRight(
      duration: AppConstants.longAnimation,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.flag,
                  size: 36,
                  color: AppColors.accentOrange,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Our Mission',
                  style: AppTextStyles.h3.copyWith(color: AppColors.accentOrange),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.mission,
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.accentOrange),
            ),
          ],
        ),
      ),
    );
  }
}

enum ImagePosition { left, right }
