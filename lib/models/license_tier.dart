// License Tier Configuration
// Defines all subscription tiers, pricing, and features

enum LicenseTier {
  starter,
  professional,
  enterprise,
  custom,
}

class LicenseTierConfig {
  final LicenseTier tier;
  final String name;
  final String displayName;
  final int basePrice; // in cents (99 = $0.99)
  final int perUserPrice; // in cents
  final int includedUsers;
  final int maxUsers;
  final String description;
  final List<String> features;
  final LicenseLimits limits;
  final bool highlighted;

  LicenseTierConfig({
    required this.tier,
    required this.name,
    required this.displayName,
    required this.basePrice,
    required this.perUserPrice,
    required this.includedUsers,
    required this.maxUsers,
    required this.description,
    required this.features,
    required this.limits,
    this.highlighted = false,
  });

  factory LicenseTierConfig.starter() => LicenseTierConfig(
    tier: LicenseTier.starter,
    name: 'STARTER',
    displayName: 'Starter Plan',
    basePrice: 79900, // R799/mo
    perUserPrice: 0, // No additional users
    includedUsers: 1,
    maxUsers: 1,
    description: 'Perfect for solo traders',
    features: [
      'Web App Only',
      '1 User Maximum',
      'Basic Waybill Generation',
      'Read-Only Client Book',
      'Basic Invoice API',
      '5GB Storage',
      '1,000 API Calls/Day',
    ],
    limits: const LicenseLimits(
      maxUsers: 1,
      maxStorage: 5368709120, // 5GB in bytes
      maxApiCallsPerDay: 1000,
      waybillGeneration: LicenseFeatureLevel.basic,
      clientBook: LicenseFeatureLevel.basic,
      invoiceApi: LicenseFeatureLevel.basic,
      multiLocation: false,
      scannerIntegration: false,
      printerIntegration: false,
      analytics: LicenseFeatureLevel.basic,
    ),
  );

  factory LicenseTierConfig.professional() => LicenseTierConfig(
    tier: LicenseTier.professional,
    name: 'PROFESSIONAL',
    displayName: 'Professional Plan',
    basePrice: 299900, // R2,999/mo
    perUserPrice: 30000, // R300/user
    includedUsers: 1,
    maxUsers: 20,
    description: 'For small to medium teams',
    features: [
      'Web App + Hardware',
      'DIY Setup',
      'Advanced Waybill Generation',
      'Full Client Book',
      'Advanced Invoice API',
      'Multi-User Support',
      'Thermal Printer Included',
      'Barcode Scanner Included',
      '50GB Storage',
      '10,000 API Calls/Day',
    ],
    limits: const LicenseLimits(
      maxUsers: 20,
      maxStorage: 53687091200, // 50GB in bytes
      maxApiCallsPerDay: 10000,
      waybillGeneration: LicenseFeatureLevel.advanced,
      clientBook: LicenseFeatureLevel.full,
      invoiceApi: LicenseFeatureLevel.advanced,
      multiLocation: false,
      scannerIntegration: true,
      printerIntegration: true,
      analytics: LicenseFeatureLevel.advanced,
    ),
    highlighted: true,
  );

  factory LicenseTierConfig.enterprise() => LicenseTierConfig(
    tier: LicenseTier.enterprise,
    name: 'ENTERPRISE',
    displayName: 'Enterprise Plan',
    basePrice: 7500000, // R75,000/mo - Premium white-glove service
    perUserPrice: 20000, // R200/user - Volume discount
    includedUsers: 3,
    maxUsers: 20,
    description: 'For large operations',
    features: [
      'Everything in Professional',
      'On-Site Setup Included',
      '3 Users Included',
      'Multi-Location Support',
      'Advanced Analytics',
      'Custom Workflows',
      'Priority Support',
      'Dedicated Account Manager',
      '500GB Storage',
      'Unlimited API Calls',
    ],
    limits: const LicenseLimits(
      maxUsers: 20,
      maxStorage: 536870912000, // 500GB in bytes
      maxApiCallsPerDay: 999999999, // Essentially unlimited
      waybillGeneration: LicenseFeatureLevel.unlimited,
      clientBook: LicenseFeatureLevel.full,
      invoiceApi: LicenseFeatureLevel.unlimited,
      multiLocation: true,
      scannerIntegration: true,
      printerIntegration: true,
      analytics: LicenseFeatureLevel.unlimited,
    ),
  );

  factory LicenseTierConfig.custom() => LicenseTierConfig(
    tier: LicenseTier.custom,
    name: 'CUSTOM',
    displayName: 'Custom Plan',
    basePrice: 0,
    perUserPrice: 0,
    includedUsers: 0,
    maxUsers: 999, // Unlimited for practical purposes
    description: 'Enterprise solutions',
    features: [
      'White-Label Option',
      'Unlimited Everything',
      'Custom Integrations',
      '24/7 Dedicated Support',
      'SLA Guarantee',
      'Custom Features',
      'Unlimited Users',
      'On-Site Training',
    ],
    limits: const LicenseLimits(
      maxUsers: 999,
      maxStorage: 9223372036854775807, // Max int64
      maxApiCallsPerDay: 9223372036854775807,
      waybillGeneration: LicenseFeatureLevel.unlimited,
      clientBook: LicenseFeatureLevel.full,
      invoiceApi: LicenseFeatureLevel.unlimited,
      multiLocation: true,
      scannerIntegration: true,
      printerIntegration: true,
      analytics: LicenseFeatureLevel.unlimited,
    ),
  );

  static LicenseTierConfig get(LicenseTier tier) {
    switch (tier) {
      case LicenseTier.starter:
        return LicenseTierConfig.starter();
      case LicenseTier.professional:
        return LicenseTierConfig.professional();
      case LicenseTier.enterprise:
        return LicenseTierConfig.enterprise();
      case LicenseTier.custom:
        return LicenseTierConfig.custom();
    }
  }

  static List<LicenseTierConfig> getAll() => [
    LicenseTierConfig.starter(),
    LicenseTierConfig.professional(),
    LicenseTierConfig.enterprise(),
    LicenseTierConfig.custom(),
  ];

  /// Calculate total monthly cost for given user count
  int calculateMonthlyCost(int userCount) {
    if (tier == LicenseTier.custom) return 0; // Custom pricing
    
    final basePrice = this.basePrice;
    final additionalUsers = (userCount - includedUsers).clamp(0, maxUsers);
    final additionalCost = additionalUsers * perUserPrice;
    
    return basePrice + additionalCost;
  }

  /// Format price for display (e.g., $99/mo)
  String formatPrice(int cents) {
    final dollars = (cents / 100).toStringAsFixed(2);
    return '\$$dollars';
  }

  /// Get base price formatted
  String get formattedBasePrice => formatPrice(basePrice);

  /// Get per-user price formatted
  String get formattedPerUserPrice => formatPrice(perUserPrice);

  /// Get total price for specific user count
  String getFormattedTotal(int userCount) {
    if (tier == LicenseTier.custom) return 'Custom Pricing';
    final total = calculateMonthlyCost(userCount);
    return formatPrice(total);
  }
}

/// Feature level enumeration
enum LicenseFeatureLevel {
  disabled,    // Feature not available
  basic,       // Basic version of feature
  advanced,    // Advanced version of feature
  full,        // Full feature access
  unlimited,   // Unlimited access to feature
}

/// License limits and feature restrictions
class LicenseLimits {
  final int maxUsers;
  final int maxStorage; // in bytes
  final int maxApiCallsPerDay;
  final LicenseFeatureLevel waybillGeneration;
  final LicenseFeatureLevel clientBook;
  final LicenseFeatureLevel invoiceApi;
  final bool multiLocation;
  final bool scannerIntegration;
  final bool printerIntegration;
  final LicenseFeatureLevel analytics;

  const LicenseLimits({
    required this.maxUsers,
    required this.maxStorage,
    required this.maxApiCallsPerDay,
    required this.waybillGeneration,
    required this.clientBook,
    required this.invoiceApi,
    required this.multiLocation,
    required this.scannerIntegration,
    required this.printerIntegration,
    required this.analytics,
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() => {
    'maxUsers': maxUsers,
    'maxStorage': maxStorage,
    'maxApiCallsPerDay': maxApiCallsPerDay,
    'waybillGeneration': waybillGeneration.toString(),
    'clientBook': clientBook.toString(),
    'invoiceApi': invoiceApi.toString(),
    'multiLocation': multiLocation,
    'scannerIntegration': scannerIntegration,
    'printerIntegration': printerIntegration,
    'analytics': analytics.toString(),
  };

  /// Create from JSON
  factory LicenseLimits.fromJson(Map<String, dynamic> json) => LicenseLimits(
    maxUsers: json['maxUsers'] ?? 1,
    maxStorage: json['maxStorage'] ?? 5368709120,
    maxApiCallsPerDay: json['maxApiCallsPerDay'] ?? 1000,
    waybillGeneration: _parseFeatureLevel(json['waybillGeneration']),
    clientBook: _parseFeatureLevel(json['clientBook']),
    invoiceApi: _parseFeatureLevel(json['invoiceApi']),
    multiLocation: json['multiLocation'] ?? false,
    scannerIntegration: json['scannerIntegration'] ?? false,
    printerIntegration: json['printerIntegration'] ?? false,
    analytics: _parseFeatureLevel(json['analytics']),
  );

  static LicenseFeatureLevel _parseFeatureLevel(String? value) {
    if (value == null) return LicenseFeatureLevel.basic;
    return LicenseFeatureLevel.values.firstWhere(
      (e) => e.toString() == value,
      orElse: () => LicenseFeatureLevel.basic,
    );
  }
}
