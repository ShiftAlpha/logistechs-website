// Currency Provider using ChangeNotifier
// Manages app-wide currency selection state

import 'package:flutter/foundation.dart';

class CurrencyProvider extends ChangeNotifier {
  String _selectedCurrency = 'ZAR'; // Default to ZAR

  String get selectedCurrency => _selectedCurrency;

  void setCurrency(String currency) {
    if (_selectedCurrency != currency) {
      _selectedCurrency = currency;
      notifyListeners();
    }
  }

  bool isZar() => _selectedCurrency == 'ZAR';
  bool isUsd() => _selectedCurrency == 'USD';
  bool isEur() => _selectedCurrency == 'EUR';
  bool isGbp() => _selectedCurrency == 'GBP';
}
