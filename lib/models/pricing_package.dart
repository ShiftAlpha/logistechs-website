// Pricing Package Data Model
// Used to pass selected configuration from pricing page to checkout

class PricingPackage {
  final String tierName;
  final String tierDisplayName;
  final int machineCount;
  final double basePrice;
  final double setupFee;
  final double machinePrice;
  final Map<String, int> addOns;
  final String billingPeriod; // 'monthly', 'quarterly', 'annual'
  final double recurringTotal;
  final double oneTimeTotal;

  PricingPackage({
    required this.tierName,
    required this.tierDisplayName,
    required this.machineCount,
    required this.basePrice,
    required this.setupFee,
    required this.machinePrice,
    required this.addOns,
    required this.billingPeriod,
    required this.recurringTotal,
    required this.oneTimeTotal,
  });
}
