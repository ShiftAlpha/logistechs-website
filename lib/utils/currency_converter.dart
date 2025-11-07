// Currency Converter Utility
// Handles conversion between ZAR, USD, EUR, GBP

class CurrencyConverter {
  // Base rates (as of November 2025) - Update these periodically
  static const Map<String, double> exchangeRates = {
    'ZAR': 1.0,      // Base currency
    'USD': 0.055,    // 1 ZAR = 0.055 USD (approx R18.18 per USD)
    'EUR': 0.051,    // 1 ZAR = 0.051 EUR (approx R19.60 per EUR)
    'GBP': 0.043,    // 1 ZAR = 0.043 GBP (approx R23.26 per GBP)
  };

  static const Map<String, String> currencySymbols = {
    'ZAR': 'R',
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
  };

  static const Map<String, String> currencyNames = {
    'ZAR': 'South African Rand',
    'USD': 'US Dollar',
    'EUR': 'Euro',
    'GBP': 'British Pound',
  };

  /// Convert amount from ZAR to target currency
  static double convert(double amountInZar, String targetCurrency) {
    if (!exchangeRates.containsKey(targetCurrency)) {
      return amountInZar; // Return original if currency not supported
    }
    
    return amountInZar * exchangeRates[targetCurrency]!;
  }

  /// Convert amount from any currency to ZAR
  static double toZar(double amount, String fromCurrency) {
    if (!exchangeRates.containsKey(fromCurrency)) {
      return amount; // Return original if currency not supported
    }
    
    if (fromCurrency == 'ZAR') return amount;
    
    return amount / exchangeRates[fromCurrency]!;
  }

  /// Convert between any two currencies
  static double convertBetween(
    double amount,
    String fromCurrency,
    String toCurrency,
  ) {
    // First convert to ZAR, then to target currency
    final amountInZar = toZar(amount, fromCurrency);
    return convert(amountInZar, toCurrency);
  }

  /// Format currency with symbol and proper decimals
  static String format(double amount, String currency) {
    final symbol = currencySymbols[currency] ?? '';
    
    // For ZAR, round to nearest whole number
    if (currency == 'ZAR') {
      return '$symbol${amount.toStringAsFixed(0)}';
    }
    
    // For other currencies, show 2 decimals
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Format and convert in one step
  static String formatConverted(double amountInZar, String targetCurrency) {
    final converted = convert(amountInZar, targetCurrency);
    return format(converted, targetCurrency);
  }

  /// Get list of supported currencies
  static List<String> getSupportedCurrencies() {
    return exchangeRates.keys.toList();
  }

  /// Get currency symbol
  static String getSymbol(String currency) {
    return currencySymbols[currency] ?? '';
  }

  /// Get currency name
  static String getName(String currency) {
    return currencyNames[currency] ?? currency;
  }
}
