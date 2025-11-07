import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/price_text.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({Key? key}) : super(key: key);

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  String _selectedBilling = 'monthly'; // monthly, quarterly, annual
  String? _selectedTier; // Track which tier is selected
  final Map<String, int> _addOnCounts = {}; // Track add-on quantities

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomNavBar(currentRoute: AppRoutes.pricing),
            _buildPricingHeader(context),
            _buildBillingSelector(isMobile),
            _buildPricingGuide(context, isMobile),
            _buildPricingCards(context, isMobile, isTablet),
            if (_selectedTier != null && _selectedTier != 'CUSTOM') 
              _buildPricingSummary(context, isMobile),
            if (_selectedTier != null && _selectedTier != 'CUSTOM') 
              _buildAddOnsSection(context, isMobile),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingHeader(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

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
        children: [
          FadeInDown(
            child: Text(
              'Logistics Management Simplified',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          FadeInUp(
            child: Text(
              'From warehouse operations to fleet tracking. Choose the plan that fits your business.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingSelector(bool isMobile) {
    return FadeInUp(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 24 : 40,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Text(
              'Choose Your Billing Cycle',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBillingButton('monthly', 'Monthly', 'Standard'),
                  SizedBox(width: 12),
                  _buildBillingButton('quarterly', 'Quarterly', 'Save 7%'),
                  SizedBox(width: 12),
                  _buildBillingButton('annual', 'Annual', 'Save 16%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingButton(String value, String label, String badge) {
    final isSelected = _selectedBilling == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedBilling = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B35) : Colors.white,
          border: Border.all(
            color: const Color(0xFFFF6B35),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFFFF6B35),
                fontSize: 14,
              ),
            ),
            Text(
              badge,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingGuide(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 50,
        horizontal: isMobile ? 16 : 40,
      ),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Pricing Structure Guide',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          Text(
            'All prices in ZAR • Internet access required for all tiers',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 40),
          
          // Machine Package Breakdown
          Container(
            constraints: BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFF6B35), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.box, color: const Color(0xFFFF6B35)),
                    SizedBox(width: 12),
                    Text(
                      'Machine Package Components',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildCostRow('DOKE MP20 Machine (8GB, Intel N150)', 4500),
                _buildCostRow('Brother QL-800 Label Printer', 4000),
                _buildCostRow('Pantum 2512W A4 Printer', 2000),
                _buildCostRow('2.4GHz Wireless Scanner (100m range)', 1000),
                Divider(height: 32),
                _buildCostRow('Base Package Total (per machine)', 11500, isBold: true),
                SizedBox(height: 12),
                Text(
                  '• No monitor, keyboard, or mouse included\n'
                  '• 1 week delivery (local) / 2 weeks (international)\n'
                  '• Each machine supports 1 master, 1 admin, 1 inhouse user',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Consumables
          Container(
            constraints: BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.print, color: const Color(0xFFFF6B35)),
                    SizedBox(width: 12),
                    Text(
                      'Consumables (Available as Add-ons)',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildCostRow('16 Rolls Thermal Paper (30m x 62mm)', 1000),
                _buildCostRow('Printer Toner (Pantum)', 500),
                SizedBox(height: 12),
                Text(
                  '• Paper not included in base packages\n'
                  '• Available as once-off or monthly subscription',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, double priceZar, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isBold ? 16 : 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ),
          PriceText(
            amountInZar: priceZar,
            style: TextStyle(
              fontSize: isBold ? 18 : 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: const Color(0xFFFF6B35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    // LOW TIER (Starter) - Entry level
    final starterTier = _PricingTier(
      name: 'STARTER',
      basePrice: 10000, // R10,000/mo - Inflated to make mid tier attractive
      setupPrice: 0,
      machinePrice: 11500, // Per machine package (setup only, +R1000/mo each)
      includesMachines: false,
      description: 'Web-only, linear scanning',
      icon: FontAwesomeIcons.rocket,
      features: [
        'Full Flutter Web App',
        'Linear scanning (sequential)',
        'Dialog printing (manual)',
        'Label + A4 printing support',
        'Basic POD & Manifest generation',
        'Client portal (track & trace)',
        '1 Master user',
        '1 Inhouse user + admin',
        '1 Depot user + admin',
        'Internet access required',
      ],
      isMonthlyOnly: false,
      preorderNote: 'Preorders on 12/11',
    );

    // MID TIER (Professional) - Full hardware + DIY setup
    final professionalTier = _PricingTier(
      name: 'PROFESSIONAL',
      basePrice: 30000, // R30,000/mo - Inflated to make max tier attractive
      setupPrice: 0, // Setup is OPTIONAL - available as add-on
      machinePrice: 11500, // Per machine package (setup only, +R1000/mo each)
      includesMachines: false, // Machine packages moved to add-ons
      description: 'Full system + setup instructions',
      icon: FontAwesomeIcons.star,
      features: [
        'Everything in Starter',
        'Wireless background scanning',
        'Silent label printing',
        'Silent A4 printing',
        'Agent setup instructions',
        'Convert to Ubuntu required',
        '1 Master user',
        '1 Inhouse user + admin',
        '1 Depot user + admin',
      ],
      isMonthlyOnly: false,
      preorderNote: 'Preorders on 12/11',
    );

    // MAX TIER (Enterprise) - White glove service - PREMIUM PRICING
    final enterpriseTier = _PricingTier(
      name: 'ENTERPRISE',
      basePrice: 45000, // R45,000/mo - Best value when addons included
      setupPrice: 0, // Setup included in first month (no separate fee shown)
      machinePrice: 11500, // Per machine package (setup only, +R1000/mo each)
      includesMachines: false, // Machine packages moved to add-ons
      description: 'Fully managed, pre-configured',
      icon: FontAwesomeIcons.crown,
      features: [
        'Everything in Professional',
        'Full agent setup (pre-configured)',
        'Priority enterprise support',
        '1 Master user (max 1 per enterprise)',
        '2 Admin users',
        '2 Inhouse users + admins',
        '1 Depot user + admin',
      ],
      isMonthlyOnly: false,
      preorderNote: 'Preorders on 12/11',
    );

    final customTier = _PricingTier(
      name: 'CUSTOM',
      basePrice: 0,
      setupPrice: 0,
      machinePrice: 0,
      includesMachines: false,
      description: 'Unlimited possibilities',
      icon: FontAwesomeIcons.handshake,
      features: [
        'Unlimited hardware bundles',
        'Unlimited users & locations',
        'Custom integrations & APIs',
        'White-label options',
        'Dedicated account manager',
        'SLA guarantees',
        '24/7 Priority support',
        'Custom development',
        'On-site training',
      ],
      isMonthlyOnly: false,
      isCustom: true,
    );

    final tiers = [starterTier, professionalTier, enterpriseTier];

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 50,
        horizontal: isMobile ? 16 : 40,
      ),
      child: isMobile || isTablet
          ? Column(
              children: [
                ...tiers
                    .map((tier) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildPricingCard(context, tier),
                        ))
                    .toList(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildPricingCard(context, customTier),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...tiers
                    .map((tier) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: _buildPricingCard(context, tier),
                          ),
                        ))
                    .toList(),
                Expanded(
                  child: _buildPricingCard(context, customTier),
                ),
              ],
            ),
    );
  }

  Widget _buildPricingCard(BuildContext context, _PricingTier tier) {
    final isSelected = _selectedTier == tier.name;
    final monthlyPrice = tier.basePrice;
    final quarterlyCost = monthlyPrice * 3;
    final annualCost = monthlyPrice * 12;
    final quarterlyDiscount = (quarterlyCost * 0.07).round();
    final annualDiscount = (annualCost * 0.16).round();
    final quarterlySaving = quarterlyCost - quarterlyDiscount;
    final annualSaving = annualCost - annualDiscount;

    String getDisplayPrice() {
      if (tier.isCustom) return 'Contact Sales';
      if (tier.basePrice == 0) return 'TBD';
      if (tier.isMonthlyOnly || _selectedBilling == 'monthly') {
        return 'R${monthlyPrice}/mo';
      } else if (_selectedBilling == 'quarterly') {
        return 'R${(quarterlySaving / 3).toStringAsFixed(0)}/mo';
      } else {
        return 'R${(annualSaving / 12).toStringAsFixed(0)}/mo';
      }
    }

    return FadeInUp(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTier = tier.name;
            _addOnCounts.clear(); // Clear add-ons when switching tiers
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFFFF6B35) : Colors.grey.shade300,
              width: isSelected ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFFFF6B35).withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: isSelected ? 20 : 10,
                offset: Offset(0, isSelected ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isSelected
                        ? [const Color(0xFFFF6B35), const Color(0xFFFF8C56)]
                        : [Colors.black87, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      tier.icon,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      tier.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      tier.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Pricing
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      getDisplayPrice(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF6B35),
                          ),
                    ),
                    // REMOVED: Detailed price text (was repeating the license price)
                    if (tier.preorderNote != null) ...[
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.green, width: 1),
                        ),
                        child: Text(
                          tier.preorderNote!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (!tier.isMonthlyOnly && !tier.isCustom && tier.basePrice > 0) ...[
                      SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _selectedBilling == 'quarterly'
                              ? 'Save R${quarterlyDiscount}'
                              : _selectedBilling == 'annual'
                                  ? 'Save R${annualDiscount}'
                                  : 'No discount',
                          style: const TextStyle(
                            color: Color(0xFFFF6B35),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Machine packages removed from tier cards - now in add-ons section

              // CTA Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleTierSelection(tier),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? const Color(0xFFFF6B35) : Colors.black87,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      tier.isCustom ? 'Contact Sales' : isSelected ? 'Preorders on 12/11' : 'Select This Plan',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Features
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tier.features
                      .map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: const Color(0xFFFF6B35),
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingSummary(BuildContext context, bool isMobile) {
    // Find the selected tier
    final tiers = [
      _PricingTier(
        name: 'STARTER',
        basePrice: 10000,
        setupPrice: 0,
        machinePrice: 11500,
        includesMachines: false,
        description: '',
        icon: FontAwesomeIcons.rocket,
        features: [],
        isMonthlyOnly: false,
      ),
      _PricingTier(
        name: 'PROFESSIONAL',
        basePrice: 30000,
        setupPrice: 0,
        machinePrice: 11500,
        includesMachines: false,
        description: '',
        icon: FontAwesomeIcons.star,
        features: [],
        isMonthlyOnly: false,
      ),
      _PricingTier(
        name: 'ENTERPRISE',
        basePrice: 45000,
        setupPrice: 0,
        machinePrice: 11500,
        includesMachines: false,
        description: '',
        icon: FontAwesomeIcons.crown,
        features: [],
        isMonthlyOnly: false,
      ),
      _PricingTier(
        name: 'CUSTOM',
        basePrice: 0,
        setupPrice: 0,
        machinePrice: 0,
        includesMachines: false,
        description: '',
        icon: FontAwesomeIcons.handshake,
        features: [],
        isMonthlyOnly: false,
        isCustom: true,
      ),
    ];

    final selectedTier = tiers.firstWhere((t) => t.name == _selectedTier);
    
    // Get tier-specific add-ons
    final tierAddOns = _getTierAddOns(_selectedTier!);
    
    // Get setup fee for scaling calculation
    int baseSetupFee = 0;
    final setupAddon = _selectedTier == 'STARTER' 
        ? tierAddOns.firstWhere((a) => a['name'] == 'Agent Setup + Ubuntu Conversion', orElse: () => <String, dynamic>{})
        : _selectedTier == 'PROFESSIONAL'
            ? tierAddOns.firstWhere((a) => a['name'] == 'Full Agent Setup (Optional)', orElse: () => <String, dynamic>{})
            : tierAddOns.firstWhere((a) => a['name'] == 'Full Agent Setup (Included)', orElse: () => <String, dynamic>{});
    
    if (setupAddon.isNotEmpty) {
      baseSetupFee = (setupAddon['setup'] as int?) ?? 0;
    }
    
    final machinePackageCount = _addOnCounts['Machine Package'] ?? (_selectedTier == 'STARTER' ? 0 : 2);
    final extraMachines = machinePackageCount > 2 ? machinePackageCount - 2 : 0;
    
    // Calculate costs from add-ons with scaled setup fees
    int addOnSetup = 0;
    int addOnMonthlyRecurring = 0;
    List<String> recurringAddOns = [];
    
    _addOnCounts.forEach((name, count) {
      if (count > 0) {
        final addOn = tierAddOns.firstWhere((a) => a['name'] == name, orElse: () => <String, dynamic>{});
        if (addOn.isNotEmpty) {
          int setupCost = (addOn['setup'] as int?) ?? 0;
          final monthlyCost = (addOn['monthly'] as int?) ?? 0;
          final scalesWithMachines = (addOn['scales_with_machines'] as bool?) ?? false;
          
          // Apply scaled setup cost for machine packages beyond the first 2
          if (name == 'Machine Package' && count > 2) {
            // Base cost for 2 machines
            setupCost = setupCost * 2;
            // Add scaled cost for extra machines (half the setup fee per extra machine)
            setupCost += (extraMachines * (baseSetupFee ~/ 2));
          } else if (name == 'Machine Package') {
            setupCost = setupCost * count;
          } else if (scalesWithMachines && extraMachines > 0 && count > 0) {
            // Setup addons that scale with machines (Ubuntu conversion, Full Agent Setup)
            // Base cost + (half the base cost × extra machines beyond 2)
            setupCost = setupCost + (extraMachines * (setupCost ~/ 2));
          } else {
            setupCost = setupCost * count;
          }
          
          addOnSetup += setupCost;
          addOnMonthlyRecurring += monthlyCost * count;
          
          if (monthlyCost > 0) {
            recurringAddOns.add('$name (${count > 1 ? '$count × ' : ''}R$monthlyCost${count > 1 ? ' = R${monthlyCost * count}' : ''}/mo)');
          }
        }
      }
    });
    
    int monthlyLicense = selectedTier.basePrice;
    int totalMonthly = monthlyLicense + addOnMonthlyRecurring;
    
    // Apply billing cycle discount
    int billingCost = totalMonthly;
    String billingPeriod = 'month';
    if (_selectedBilling == 'quarterly') {
      billingCost = (totalMonthly * 3 * 0.93).round(); // 7% discount
      billingPeriod = 'quarter';
    } else if (_selectedBilling == 'annual') {
      billingCost = (totalMonthly * 12 * 0.84).round(); // 16% discount
      billingPeriod = 'year';
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Colors.white,
      child: FadeInUp(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFFF6B35), const Color(0xFFFF8C56)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B35).withOpacity(0.3),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Configuration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.shopping_cart, color: Colors.white, size: 32),
                ],
              ),
              SizedBox(height: 24),
              Divider(color: Colors.white.withOpacity(0.5)),
              SizedBox(height: 16),
              
              // Tier selection
              _buildSummaryRow('Selected Plan', '${selectedTier.name}', true),
              
              SizedBox(height: 8),
              
              // License fee
              _buildSummaryRow('License Fee', 'R$monthlyLicense/mo', false),
              
              // List recurring add-ons
              if (recurringAddOns.isNotEmpty) ...[
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recurringAddOns.map((addon) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '+ $addon',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ],
              
              SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.5), thickness: 2),
              SizedBox(height: 16),
              
              // Totals
              if (addOnSetup > 0)
                _buildSummaryRow('Once-Off Total', 'R$addOnSetup', true),
              _buildSummaryRow('Recurring Total', 'R$billingCost/$billingPeriod', true),
              
              SizedBox(height: 24),
              
              // Preorder notice (checkout disabled until preorder date)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Column(
                  children: [
                    Icon(Icons.event_available, color: Colors.green, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Preorders Opening Soon!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'December 11th, 2025',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Review your configuration above. Checkout will be available on the preorder date.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Checkout button (DISABLED - uncomment when ready to accept orders)
              /* SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final packageData = PricingPackage(
                      tierName: selectedTier.name,
                      tierDisplayName: selectedTier.name,
                      machineCount: _machineCount,
                      basePrice: monthlyLicense.toDouble(),
                      setupFee: setupTotal.toDouble(),
                      machinePrice: machineTotal.toDouble(),
                      addOns: Map.from(_addOnCounts),
                      billingPeriod: _selectedBilling,
                      recurringTotal: billingCost.toDouble(),
                      oneTimeTotal: totalSetup.toDouble(),
                    );
                    
                    Navigator.pushNamed(
                      context,
                      AppRoutes.checkout,
                      arguments: packageData,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isBold ? 18 : 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isBold ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOnsSection(BuildContext context, bool isMobile) {
    final addOns = _getTierAddOns(_selectedTier!);

    // Initialize add-ons based on tier
    if (!_addOnCounts.containsKey('Machine Package')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // STARTER: Set machine packages to 0 initially (requires Ubuntu conversion first)
          // OTHER TIERS: Set machine packages to 2 by default
          if (_selectedTier == 'STARTER') {
            _addOnCounts['Machine Package'] = 0;
          } else {
            _addOnCounts['Machine Package'] = 2;
          }
          
          // Preset Enterprise tier with included services
          if (_selectedTier == 'ENTERPRISE') {
            _addOnCounts['Full Agent Setup (Included)'] = 1;
            _addOnCounts['Silent Label Printing'] = 1;
            _addOnCounts['Silent A4 Printing'] = 1;
          }
        });
      });
    }

    // Calculate total add-on costs with scaled setup fees
    int totalSetup = 0;
    int totalMonthly = 0;
    
    // Get setup fee for scaling calculation
    int baseSetupFee = 0;
    final setupAddon = _selectedTier == 'STARTER' 
        ? addOns.firstWhere((a) => a['name'] == 'Agent Setup + Ubuntu Conversion', orElse: () => <String, dynamic>{})
        : _selectedTier == 'PROFESSIONAL'
            ? addOns.firstWhere((a) => a['name'] == 'Full Agent Setup (Optional)', orElse: () => <String, dynamic>{})
            : addOns.firstWhere((a) => a['name'] == 'Full Agent Setup (Included)', orElse: () => <String, dynamic>{});
    
    if (setupAddon.isNotEmpty) {
      baseSetupFee = (setupAddon['setup'] as int?) ?? 0;
    }
    
    final machinePackageCount = _addOnCounts['Machine Package'] ?? (_selectedTier == 'STARTER' ? 0 : 2);
    final extraMachines = machinePackageCount > 2 ? machinePackageCount - 2 : 0;
    
    _addOnCounts.forEach((name, count) {
      final addOn = addOns.firstWhere((a) => a['name'] == name, orElse: () => <String, dynamic>{});
      if (addOn.isNotEmpty) {
        int setupCost = (addOn['setup'] as int?) ?? 0;
        final monthlyCost = (addOn['monthly'] as int?) ?? 0;
        final scalesWithMachines = (addOn['scales_with_machines'] as bool?) ?? false;
        
        // Apply scaled setup cost for machine packages beyond the first 2
        if (name == 'Machine Package' && count > 2) {
          // Base cost for 2 machines
          setupCost = setupCost * 2;
          // Add scaled cost for extra machines (half the setup fee per extra machine)
          setupCost += (extraMachines * (baseSetupFee ~/ 2));
        } else if (name == 'Machine Package') {
          setupCost = setupCost * count;
        } else if (scalesWithMachines && extraMachines > 0 && count > 0) {
          // Setup addons that scale with machines (Ubuntu conversion, Full Agent Setup)
          // Base cost + (half the base cost × extra machines beyond 2)
          setupCost = setupCost + (extraMachines * (setupCost ~/ 2));
        } else {
          setupCost = setupCost * count;
        }
        
        totalSetup += setupCost;
        totalMonthly += monthlyCost * count;
      }
    });

    if (addOns.isEmpty) {
      return SizedBox.shrink(); // Don't show section if no tier selected
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'Add-On Services for $_selectedTier Tier',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          Text(
            'Customize your plan with additional services • All prices in ZAR',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          if (_addOnCounts.isNotEmpty) ...[
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFF6B35)),
              ),
              child: Column(
                children: [
                  Text(
                    'Selected Add-Ons Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Setup Fee',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          Text(
                            'R$totalSetup',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: const Color(0xFFFF6B35),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Monthly Cost',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          Text(
                            'R$totalMonthly/mo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: const Color(0xFFFF6B35),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 40),
          // Add-ons displayed as cards similar to machine packages
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: addOns.map((addOn) {
              final name = addOn['name'] as String;
              final isCountable = addOn['countable'] as bool;
              final count = _addOnCounts[name] ?? 0;
              final isSelected = count > 0;
              final setupCost = addOn['setup'] as int;
              final monthlyCost = addOn['monthly'] as int;

              return Container(
                width: isMobile ? double.infinity : 480,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFF8F3) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFF6B35) : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? const Color(0xFFFF6B35).withOpacity(0.15)
                          : Colors.grey.withOpacity(0.08),
                      blurRadius: isSelected ? 12 : 6,
                      offset: Offset(0, isSelected ? 4 : 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isCountable ? Icons.add_shopping_cart : Icons.toggle_on,
                          color: const Color(0xFFFF6B35),
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      addOn['description'] as String,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12),
                    Divider(),
                    SizedBox(height: 12),
                    // Pricing
                    if (setupCost > 0 && monthlyCost > 0) ...[
                      Text(
                        'R$setupCost setup + R$monthlyCost/month',
                        style: TextStyle(
                          color: const Color(0xFFFF6B35),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else if (setupCost > 0) ...[
                      Text(
                        'R$setupCost once-off${(addOn['monthly_option'] == true) ? ' (or monthly)' : ''}',
                        style: TextStyle(
                          color: const Color(0xFFFF6B35),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      Text(
                        'R$monthlyCost/month',
                        style: TextStyle(
                          color: const Color(0xFFFF6B35),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    // Counter or Toggle
                    if (isCountable)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // STARTER: Can remove all machines (goes back to 0)
                                    // OTHER TIERS: Machine packages can't go below 2
                                    if (name == 'Machine Package') {
                                      if (_selectedTier == 'STARTER' && count > 0) {
                                        _addOnCounts[name] = count - 1;
                                      } else if (_selectedTier != 'STARTER' && count > 2) {
                                        _addOnCounts[name] = count - 1;
                                      }
                                    } else if (count > 0) {
                                      _addOnCounts[name] = count - 1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove_circle),
                                color: const Color(0xFFFF6B35),
                                iconSize: 28,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFFF6B35), width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$count',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF6B35),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // STARTER tier: requires Agent Setup to add ANY machines
                                  if (name == 'Machine Package' && _selectedTier == 'STARTER') {
                                    final hasSetup = (_addOnCounts['Agent Setup + Ubuntu Conversion'] ?? 0) > 0;
                                    if (!hasSetup) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Enable "Agent Setup + Ubuntu Conversion" first to add machine packages'),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                      return;
                                    }
                                    
                                    // Auto-set to 2 when first adding
                                    if (count == 0) {
                                      setState(() {
                                        _addOnCounts[name] = 2;
                                      });
                                      return;
                                    }
                                  }
                                  
                                  if (count < 10) {
                                    setState(() {
                                      _addOnCounts[name] = count + 1;
                                    });
                                  }
                                },
                                icon: Icon(Icons.add_circle),
                                color: const Color(0xFFFF6B35),
                                iconSize: 28,
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      SwitchListTile(
                        title: Text(
                          isSelected ? 'Enabled' : 'Disabled',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        value: isSelected,
                        activeColor: const Color(0xFFFF6B35),
                        onChanged: (value) {
                          setState(() {
                            _addOnCounts[name] = value ? 1 : 0;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _handleTierSelection(_PricingTier tier) {
    if (tier.isCustom) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please contact sales for custom solutions'),
          duration: const Duration(seconds: 2),
        ),
      );
      // TODO: Open contact form or email
    } else {
      // Do not navigate. Select the tier and show breakdown in the configuration panel.
      setState(() {
        _selectedTier = tier.name;
        _addOnCounts.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Plan selected — review the full breakdown below.'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Helper method to get tier-specific add-ons
  List<Map<String, dynamic>> _getTierAddOns(String tierName) {
    // PRICING STRATEGY: Inflate lower tier addons to incentivize upgrading
    // Machine packages now include R1,000/mo recurring cost per package
    final Map<String, List<Map<String, dynamic>>> tierAddOns = {
      'STARTER': [
        {'name': 'Machine Package', 'description': 'DOKE MP20 + scanners + printers + users (1 Inhouse/Depot + 1 Admin per package, 1 Master max)', 'setup': 11500, 'monthly': 1000, 'countable': true}, // +R1000/mo per package
        {'name': 'Silent Label Printing', 'description': 'Automated background label printing', 'setup': 0, 'monthly': 6500, 'countable': false}, // More expensive than tier 2 (R3k) + margin
        {'name': 'Silent A4 Printing', 'description': 'Automated background A4 printing', 'setup': 0, 'monthly': 6500, 'countable': false}, // More expensive than tier 2 (R3k) + margin
        {'name': 'Agent Setup + Ubuntu Conversion', 'description': 'Convert your machine to Ubuntu + install agents (required for additional machines)', 'setup': 35000, 'monthly': 0, 'countable': false, 'scales_with_machines': true}, // Same as tier 2 setup, scales with machines
        {'name': 'Wireless Scanner (2.4GHz 100m)', 'description': '2.4GHz wireless barcode scanner', 'setup': 1500, 'monthly': 0, 'countable': true}, // +R500 vs tier 2
        {'name': '16 Thermal Paper Rolls (30mx62mm)', 'description': 'Continuous thermal paper', 'setup': 1200, 'monthly': 0, 'countable': true, 'monthly_option': true}, // +R200 vs tier 2
        {'name': 'Printer Toner', 'description': 'Pantum printer toner', 'setup': 700, 'monthly': 0, 'countable': true, 'monthly_option': true}, // +R200 vs tier 2
        {'name': 'Custom Label Design', 'description': 'Continuous or DIE-CUT', 'setup': 9000, 'monthly': 0, 'countable': true}, // +R3000 vs tier 2
        {'name': 'Label Printer', 'description': 'Brother QL-800 label printer', 'setup': 5000, 'monthly': 0, 'countable': true}, // +R1000 vs tier 2
        {'name': 'A4 Printer', 'description': 'Pantum 2512W printer', 'setup': 2500, 'monthly': 0, 'countable': true}, // +R500 vs tier 2
        {'name': 'Car Tracking API Integration', 'description': 'Integrate with tracking service', 'setup': 9000, 'monthly': 5000, 'countable': true}, // +R3k setup, +R2.5k monthly vs tier 2
        {'name': 'Inhouse API Integration', 'description': 'Custom client invoicing API', 'setup': 9000, 'monthly': 5000, 'countable': true}, // +R3k setup, +R2.5k monthly vs tier 2
      ],
      'PROFESSIONAL': [
        {'name': 'Machine Package', 'description': 'DOKE MP20 + scanners + printers + users (1 Inhouse/Depot + 1 Admin per package, 1 Master max)', 'setup': 11500, 'monthly': 1000, 'countable': true}, // +R1000/mo per package
        {'name': 'Full Agent Setup (Optional)', 'description': 'We set up and configure everything for you', 'setup': 35000, 'monthly': 0, 'countable': false, 'scales_with_machines': true}, // Scales with machines - half per extra
        {'name': 'Silent Label Printing', 'description': 'Automated background label printing', 'setup': 0, 'monthly': 3000, 'countable': false}, // Base pricing
        {'name': 'Silent A4 Printing', 'description': 'Automated background A4 printing', 'setup': 0, 'monthly': 3000, 'countable': false}, // Base pricing
        {'name': 'Wireless Scanner (2.4GHz 100m)', 'description': '2.4GHz wireless barcode scanner', 'setup': 1000, 'monthly': 0, 'countable': true},
        {'name': '16 Thermal Paper Rolls (30mx62mm)', 'description': 'Continuous thermal paper', 'setup': 1000, 'monthly': 0, 'countable': true, 'monthly_option': true},
        {'name': 'Printer Toner', 'description': 'Pantum printer toner', 'setup': 500, 'monthly': 0, 'countable': true, 'monthly_option': true},
        {'name': 'Custom Label Design', 'description': 'Continuous or DIE-CUT', 'setup': 6000, 'monthly': 0, 'countable': true},
        {'name': 'Label Printer', 'description': 'Brother QL-800 (silent)', 'setup': 4000, 'monthly': 0, 'countable': true},
        {'name': 'A4 Printer', 'description': 'Pantum 2512W (silent)', 'setup': 2000, 'monthly': 0, 'countable': true},
        {'name': 'Car Tracking API Integration', 'description': 'Integrate with tracking service', 'setup': 6000, 'monthly': 2500, 'countable': true},
        {'name': 'Inhouse API Integration', 'description': 'Custom client invoicing API', 'setup': 6000, 'monthly': 2500, 'countable': true},
      ],
      'ENTERPRISE': [
        {'name': 'Machine Package', 'description': 'DOKE MP20 + scanners + printers + users (1 Inhouse/Depot + 1 Admin per package, 1 Master max)', 'setup': 11500, 'monthly': 1000, 'countable': true}, // +R1000/mo per package
        {'name': 'Full Agent Setup (Included)', 'description': 'Pre-configured, fully managed setup', 'setup': 15000, 'monthly': 0, 'countable': false}, // Cheaper than mid tier - preselected
        {'name': 'Silent Label Printing', 'description': 'Automated background label printing (included)', 'setup': 0, 'monthly': 0, 'countable': false}, // FREE - preselected
        {'name': 'Silent A4 Printing', 'description': 'Automated background A4 printing (included)', 'setup': 0, 'monthly': 0, 'countable': false}, // FREE - preselected
        {'name': 'Wireless Scanner (2.4GHz 100m)', 'description': '2.4GHz wireless barcode scanner', 'setup': 1000, 'monthly': 0, 'countable': true},
        {'name': '16 Thermal Paper Rolls (30mx62mm)', 'description': 'Continuous thermal paper', 'setup': 1000, 'monthly': 0, 'countable': true, 'monthly_option': true},
        {'name': 'Printer Toner', 'description': 'Pantum printer toner', 'setup': 500, 'monthly': 0, 'countable': true, 'monthly_option': true},
        {'name': 'Custom Label Design', 'description': 'Continuous or DIE-CUT', 'setup': 3000, 'monthly': 0, 'countable': true}, // Best value
        {'name': 'Label Printer', 'description': 'Brother QL-800 with silent printing', 'setup': 4000, 'monthly': 0, 'countable': true},
        {'name': 'A4 Printer', 'description': 'Pantum 2512W with silent printing', 'setup': 2000, 'monthly': 0, 'countable': true},
        {'name': 'Car Tracking API Integration', 'description': 'Additional tracking service', 'setup': 4000, 'monthly': 1500, 'countable': true}, // Best value
        {'name': 'Inhouse API Integration', 'description': 'Additional custom API', 'setup': 4000, 'monthly': 1500, 'countable': true}, // Best value
      ],
    };

    return tierAddOns[tierName] ?? [];
  }
}

class _PricingTier {
  final String name;
  final int basePrice; // Monthly license fee
  final int setupPrice; // One-off setup fee
  final int machinePrice; // Price per machine package (one-off)
  final bool includesMachines; // Whether this tier gets machine packages
  final String description;
  final IconData icon;
  final List<String> features;
  final bool isCustom;
  final bool isMonthlyOnly;
  final String? preorderNote; // Optional preorder note

  _PricingTier({
    required this.name,
    required this.basePrice,
    required this.setupPrice,
    required this.machinePrice,
    required this.includesMachines,
    required this.description,
    required this.icon,
    required this.features,
    this.isCustom = false,
    this.isMonthlyOnly = false,
    this.preorderNote,
  });
}
