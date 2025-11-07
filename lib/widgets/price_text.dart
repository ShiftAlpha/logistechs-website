// Price Display Widget
// Displays prices with automatic currency conversion

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/currency_converter.dart';
import '../providers/currency_provider.dart';

class PriceText extends StatelessWidget {
  final double amountInZar;
  final TextStyle? style;
  final bool showCurrency;
  final String suffix;

  const PriceText({
    Key? key,
    required this.amountInZar,
    this.style,
    this.showCurrency = true,
    this.suffix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, currencyProvider, child) {
        final currency = currencyProvider.selectedCurrency;
        final formattedPrice = CurrencyConverter.formatConverted(
          amountInZar,
          currency,
        );
        
        return Text(
          '$formattedPrice$suffix',
          style: style,
        );
      },
    );
  }
}

class PriceDisplay extends StatelessWidget {
  final double amountInZar;
  final TextStyle? style;
  final bool showFullName;

  const PriceDisplay({
    Key? key,
    required this.amountInZar,
    this.style,
    this.showFullName = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, currencyProvider, child) {
        final currency = currencyProvider.selectedCurrency;
        final converted = CurrencyConverter.convert(amountInZar, currency);
        final name = CurrencyConverter.getName(currency);
        
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: CurrencyConverter.format(converted, currency),
                style: style ?? DefaultTextStyle.of(context).style,
              ),
              if (showFullName)
                TextSpan(
                  text: ' $name',
                  style: (style ?? DefaultTextStyle.of(context).style).copyWith(
                    fontSize: (style?.fontSize ?? 14) * 0.7,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
