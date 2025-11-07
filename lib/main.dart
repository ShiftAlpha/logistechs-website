// Main entry point for the Logistechs Website
// a digital logistics platform for African road freight operations.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/constants.dart';
import 'utils/routes.dart';
import 'providers/currency_provider.dart';

void main() {
  runApp(const LogistechsWebsite());
}

class LogistechsWebsite extends StatelessWidget {
  const LogistechsWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CurrencyProvider(),
      child: MaterialApp(
        title: 'Logistechs - Digital Logistics Platform',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryBlue,
            primary: AppColors.primaryBlue,
            secondary: AppColors.accentOrange,
          ),
          scaffoldBackgroundColor: AppColors.nearWhiteBackground,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
