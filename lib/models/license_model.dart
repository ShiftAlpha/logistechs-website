// License Model
// Represents a single customer license

import 'license_tier.dart';

class License {
  final String licenseKey;
  final LicenseTier tier;
  final LicenseStatus status;
  final LicenseOwner owner;
  final LicenseSubscription subscription;
  final LicenseSupabase supabase;
  final LicenseHardware? hardware;
  final LicenseFeatures features;
  final LicenseSetup setup;
  final LicenseBilling billing;
  final DateTime createdAt;
  final DateTime updatedAt;

  License({
    required this.licenseKey,
    required this.tier,
    required this.status,
    required this.owner,
    required this.subscription,
    required this.supabase,
    required this.hardware,
    required this.features,
    required this.setup,
    required this.billing,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create from JSON (Firestore data)
  factory License.fromJson(Map<String, dynamic> json) => License(
    licenseKey: json['licenseKey'] ?? '',
    tier: _parseTier(json['tier']),
    status: _parseStatus(json['status']),
    owner: LicenseOwner.fromJson(json['owner'] ?? {}),
    subscription: LicenseSubscription.fromJson(json['subscription'] ?? {}),
    supabase: LicenseSupabase.fromJson(json['supabase'] ?? {}),
    hardware: json['hardware'] != null ? LicenseHardware.fromJson(json['hardware']) : null,
    features: LicenseFeatures.fromJson(json['features'] ?? {}),
    setup: LicenseSetup.fromJson(json['setup'] ?? {}),
    billing: LicenseBilling.fromJson(json['billing'] ?? {}),
    createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
    updatedAt: _parseDateTime(json['updatedAt']) ?? DateTime.now(),
  );

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() => {
    'tier': tier.toString().split('.').last,
    'status': status.toString().split('.').last,
    'owner': owner.toJson(),
    'subscription': subscription.toJson(),
    'supabase': supabase.toJson(),
    'hardware': hardware?.toJson(),
    'features': features.toJson(),
    'setup': setup.toJson(),
    'billing': billing.toJson(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  bool get isActive => status == LicenseStatus.active && !isExpired;
  bool get isExpired => DateTime.now().isAfter(subscription.expiryDate);
  int get daysRemaining => (subscription.expiryDate.difference(DateTime.now()).inDays).clamp(0, 999);
  bool get autoRenewEnabled => subscription.autoRenew;
  int get currentUsers => subscription.users;
  LicenseTierConfig get tierConfig => LicenseTierConfig.get(tier);

  bool canAddUsers(int newCount) {
    if (tier == LicenseTier.custom) return true;
    final config = LicenseTierConfig.get(tier);
    return newCount <= config.maxUsers;
  }

  int calculateAddUserCost(int newUsers) {
    final config = LicenseTierConfig.get(tier);
    return config.calculateMonthlyCost(newUsers);
  }
}

enum LicenseStatus { pending, active, inactive, expired, suspended, cancelled }

class LicenseOwner {
  final String name;
  final String email;
  final String company;
  final String phone;
  final String? country;

  LicenseOwner({
    required this.name,
    required this.email,
    required this.company,
    required this.phone,
    this.country,
  });

  factory LicenseOwner.fromJson(Map<String, dynamic> json) => LicenseOwner(
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    company: json['company'] ?? '',
    phone: json['phone'] ?? '',
    country: json['country'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'company': company,
    'phone': phone,
    'country': country,
  };
}

class LicenseSubscription {
  final DateTime startDate;
  final DateTime expiryDate;
  final DateTime renewalDate;
  final bool autoRenew;
  final int monthlyRate;
  final int users;
  final int totalMonthlyCost;

  LicenseSubscription({
    required this.startDate,
    required this.expiryDate,
    required this.renewalDate,
    required this.autoRenew,
    required this.monthlyRate,
    required this.users,
    required this.totalMonthlyCost,
  });

  factory LicenseSubscription.fromJson(Map<String, dynamic> json) => LicenseSubscription(
    startDate: _parseDateTime(json['startDate']) ?? DateTime.now(),
    expiryDate: _parseDateTime(json['expiryDate']) ?? DateTime.now().add(const Duration(days: 30)),
    renewalDate: _parseDateTime(json['renewalDate']) ?? DateTime.now().add(const Duration(days: 30)),
    autoRenew: json['autoRenew'] ?? true,
    monthlyRate: json['monthlyRate'] ?? 0,
    users: json['users'] ?? 1,
    totalMonthlyCost: json['totalMonthlyCost'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'startDate': startDate.toIso8601String(),
    'expiryDate': expiryDate.toIso8601String(),
    'renewalDate': renewalDate.toIso8601String(),
    'autoRenew': autoRenew,
    'monthlyRate': monthlyRate,
    'users': users,
    'totalMonthlyCost': totalMonthlyCost,
  };
}

class LicenseSupabase {
  final String projectId;
  final String apiKey;
  final String url;
  final String status;
  final String? errorMessage;
  final DateTime? provisionedAt;

  LicenseSupabase({
    required this.projectId,
    required this.apiKey,
    required this.url,
    required this.status,
    this.errorMessage,
    this.provisionedAt,
  });

  factory LicenseSupabase.fromJson(Map<String, dynamic> json) => LicenseSupabase(
    projectId: json['projectId'] ?? '',
    apiKey: json['apiKey'] ?? '',
    url: json['url'] ?? '',
    status: json['status'] ?? 'pending',
    errorMessage: json['errorMessage'],
    provisionedAt: _parseDateTime(json['provisionedAt']),
  );

  Map<String, dynamic> toJson() => {
    'projectId': projectId,
    'apiKey': apiKey,
    'url': url,
    'status': status,
    'errorMessage': errorMessage,
    'provisionedAt': provisionedAt?.toIso8601String(),
  };

  bool get isProvisioned => status == 'provisioned';
  bool get isProvisioning => status == 'provisioning';
  bool get hasFailed => status == 'failed';
}

class LicenseHardware {
  final List<String> serialNumbers;
  final String trackingNumber;
  final DateTime? estimatedDelivery;
  final String status;

  LicenseHardware({
    required this.serialNumbers,
    required this.trackingNumber,
    this.estimatedDelivery,
    required this.status,
  });

  factory LicenseHardware.fromJson(Map<String, dynamic> json) => LicenseHardware(
    serialNumbers: List<String>.from(json['serialNumbers'] ?? []),
    trackingNumber: json['trackingNumber'] ?? '',
    estimatedDelivery: _parseDateTime(json['estimatedDelivery']),
    status: json['status'] ?? 'pending',
  );

  Map<String, dynamic> toJson() => {
    'serialNumbers': serialNumbers,
    'trackingNumber': trackingNumber,
    'estimatedDelivery': estimatedDelivery?.toIso8601String(),
    'status': status,
  };
}

class LicenseFeatures {
  final bool waybillGeneration;
  final bool clientBook;
  final bool invoiceApi;
  final bool multiUser;
  final bool scannerIntegration;
  final bool printerIntegration;
  final bool multiLocation;
  final bool analytics;

  LicenseFeatures({
    required this.waybillGeneration,
    required this.clientBook,
    required this.invoiceApi,
    required this.multiUser,
    required this.scannerIntegration,
    required this.printerIntegration,
    required this.multiLocation,
    required this.analytics,
  });

  factory LicenseFeatures.fromJson(Map<String, dynamic> json) => LicenseFeatures(
    waybillGeneration: json['waybillGeneration'] ?? true,
    clientBook: json['clientBook'] ?? true,
    invoiceApi: json['invoiceApi'] ?? true,
    multiUser: json['multiUser'] ?? false,
    scannerIntegration: json['scannerIntegration'] ?? false,
    printerIntegration: json['printerIntegration'] ?? false,
    multiLocation: json['multiLocation'] ?? false,
    analytics: json['analytics'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'waybillGeneration': waybillGeneration,
    'clientBook': clientBook,
    'invoiceApi': invoiceApi,
    'multiUser': multiUser,
    'scannerIntegration': scannerIntegration,
    'printerIntegration': printerIntegration,
    'multiLocation': multiLocation,
    'analytics': analytics,
  };
}

class LicenseSetup {
  final String status;
  final int currentStep;
  final String setupUrl;
  final DateTime? videoWatchedAt;
  final DateTime? completedAt;

  LicenseSetup({
    required this.status,
    required this.currentStep,
    required this.setupUrl,
    this.videoWatchedAt,
    this.completedAt,
  });

  factory LicenseSetup.fromJson(Map<String, dynamic> json) => LicenseSetup(
    status: json['status'] ?? 'pending',
    currentStep: json['currentStep'] ?? 0,
    setupUrl: json['setupUrl'] ?? '',
    videoWatchedAt: _parseDateTime(json['videoWatchedAt']),
    completedAt: _parseDateTime(json['completedAt']),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'currentStep': currentStep,
    'setupUrl': setupUrl,
    'videoWatchedAt': videoWatchedAt?.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
  };

  bool get isCompleted => status == 'completed';
  bool get isInProgress => status == 'in_progress';
}

class LicenseBilling {
  final String stripeCustomerId;
  final String stripeSubscriptionId;
  final DateTime? lastPaymentDate;
  final String? lastPaymentId;
  final String paymentStatus;
  final List<String> invoiceIds;

  LicenseBilling({
    required this.stripeCustomerId,
    required this.stripeSubscriptionId,
    this.lastPaymentDate,
    this.lastPaymentId,
    required this.paymentStatus,
    required this.invoiceIds,
  });

  factory LicenseBilling.fromJson(Map<String, dynamic> json) => LicenseBilling(
    stripeCustomerId: json['stripeCustomerId'] ?? '',
    stripeSubscriptionId: json['stripeSubscriptionId'] ?? '',
    lastPaymentDate: _parseDateTime(json['lastPaymentDate']),
    lastPaymentId: json['lastPaymentId'],
    paymentStatus: json['paymentStatus'] ?? 'pending',
    invoiceIds: List<String>.from(json['invoiceIds'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'stripeCustomerId': stripeCustomerId,
    'stripeSubscriptionId': stripeSubscriptionId,
    'lastPaymentDate': lastPaymentDate?.toIso8601String(),
    'lastPaymentId': lastPaymentId,
    'paymentStatus': paymentStatus,
    'invoiceIds': invoiceIds,
  };
}

LicenseTier _parseTier(dynamic value) {
  if (value == null) return LicenseTier.starter;
  if (value is String) {
    return LicenseTier.values.firstWhere(
      (e) => e.toString() == 'LicenseTier.$value',
      orElse: () => LicenseTier.starter,
    );
  }
  return LicenseTier.starter;
}

LicenseStatus _parseStatus(dynamic value) {
  if (value == null) return LicenseStatus.pending;
  if (value is String) {
    return LicenseStatus.values.firstWhere(
      (e) => e.toString() == 'LicenseStatus.$value',
      orElse: () => LicenseStatus.pending,
    );
  }
  return LicenseStatus.pending;
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}
