import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import '../utils/responsive_helper.dart';
import '../utils/routes.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../models/pricing_package.dart';
import '../widgets/price_text.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form fields
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  // Payment method
  String _paymentMethod = 'card'; // card, bank_transfer
  
  @override
  void dispose() {
    _companyNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final packageData = ModalRoute.of(context)?.settings.arguments as PricingPackage?;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomNavBar(currentRoute: AppRoutes.checkout),
            _buildCheckoutHeader(context, isMobile),
            _buildCheckoutForm(context, isMobile, packageData),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutHeader(BuildContext context, bool isMobile) {
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
            child: Icon(
              FontAwesomeIcons.cartShopping,
              size: isMobile ? 48 : 64,
              color: const Color(0xFFFF6B35),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          FadeInDown(
            child: Text(
              'Complete Your Order',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          FadeInUp(
            child: Text(
              'Just a few steps away from transforming your logistics operations',
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

  Widget _buildCheckoutForm(BuildContext context, bool isMobile, PricingPackage? packageData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Summary Section
                FadeInUp(
                  child: _buildOrderSummary(context, isMobile, packageData),
                ),
                
                SizedBox(height: 40),
                
                // Company Information Section
                FadeInUp(
                  delay: Duration(milliseconds: 100),
                  child: _buildSectionTitle('Company Information'),
                ),
                SizedBox(height: 20),
                
                FadeInUp(
                  delay: Duration(milliseconds: 150),
                  child: _buildTextField(
                    controller: _companyNameController,
                    label: 'Company Name',
                    icon: Icons.business,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your company name';
                      }
                      return null;
                    },
                  ),
                ),
                
                SizedBox(height: 16),
                
                FadeInUp(
                  delay: Duration(milliseconds: 200),
                  child: _buildTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                
                SizedBox(height: 16),
                
                FadeInUp(
                  delay: Duration(milliseconds: 250),
                  child: _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                
                SizedBox(height: 16),
                
                FadeInUp(
                  delay: Duration(milliseconds: 300),
                  child: _buildTextField(
                    controller: _addressController,
                    label: 'Business Address',
                    icon: Icons.location_on,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your business address';
                      }
                      return null;
                    },
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Payment Method Section
                FadeInUp(
                  delay: Duration(milliseconds: 350),
                  child: _buildSectionTitle('Payment Method'),
                ),
                SizedBox(height: 20),
                
                FadeInUp(
                  delay: Duration(milliseconds: 400),
                  child: _buildPaymentMethodSelector(isMobile),
                ),
                
                SizedBox(height: 40),
                
                // Terms and Conditions
                FadeInUp(
                  delay: Duration(milliseconds: 450),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFFFF6B35),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'By proceeding with this purchase, you agree to our Terms of Service and Privacy Policy. Your subscription will auto-renew according to your selected billing cycle.',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Checkout Button
                FadeInUp(
                  delay: Duration(milliseconds: 500),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.lock, size: 18),
                          SizedBox(width: 12),
                          Text(
                            'Complete Purchase',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Security Notice
                FadeInUp(
                  delay: Duration(milliseconds: 550),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.shieldHalved,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Secure checkout powered by Stripe',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, bool isMobile, PricingPackage? packageData) {
    // Handle case where no package was selected
    if (packageData == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFFF6B35), const Color(0xFFFF8C56)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF6B35).withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 48, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'No Package Selected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please select a package from our pricing page',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.pricing),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFF6B35),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Return to Pricing'),
            ),
          ],
        ),
      );
    }

    // Build list of order items
    List<Widget> orderItems = [];
    
    // Selected plan
    orderItems.add(_buildSummaryRowText('Selected Plan', packageData.tierDisplayName, false));
    
    // Machine packages
    if (packageData.machineCount > 0 && packageData.machinePrice > 0) {
      orderItems.add(_buildSummaryRowWidget(
        '${packageData.machineCount} Machine Package${packageData.machineCount > 1 ? 's' : ''}',
        PriceText(amountInZar: packageData.machinePrice),
        false,
      ));
    }
    
    // Setup fee
    if (packageData.setupFee > 0) {
      orderItems.add(_buildSummaryRowWidget(
        'Setup Fee',
        PriceText(amountInZar: packageData.setupFee),
        false,
      ));
    }
    
    // Base license price
    if (packageData.basePrice > 0) {
      String suffix = packageData.billingPeriod == 'monthly' ? '/month' 
                    : packageData.billingPeriod == 'quarterly' ? '/quarter'
                    : '/year';
      orderItems.add(_buildSummaryRowWidget(
        'License Fee',
        PriceText(amountInZar: packageData.basePrice, suffix: suffix),
        false,
      ));
    }
    
    // Add-ons
    if (packageData.addOns.isNotEmpty) {
      packageData.addOns.forEach((name, quantity) {
        if (quantity > 0) {
          orderItems.add(_buildSummaryRowText(
            quantity > 1 ? '$quantity x $name' : name,
            'Included',
            false,
          ));
        }
      });
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF6B35), const Color(0xFFFF8C56)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.5)),
          SizedBox(height: 16),
          
          ...orderItems,
          
          SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.5), thickness: 2),
          SizedBox(height: 16),
          
          if (packageData.oneTimeTotal > 0)
            _buildSummaryRowWidget(
              'One-Time Total',
              PriceText(amountInZar: packageData.oneTimeTotal),
              true,
            ),
          _buildSummaryRowWidget(
            'Recurring Total',
            PriceText(
              amountInZar: packageData.recurringTotal,
              suffix: packageData.billingPeriod == 'monthly' ? '/month' 
                     : packageData.billingPeriod == 'quarterly' ? '/quarter'
                     : '/year',
            ),
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRowText(String label, String value, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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

  Widget _buildSummaryRowWidget(String label, Widget valueWidget, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontSize: isBold ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
            child: valueWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFFFF6B35), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPaymentMethodSelector(bool isMobile) {
    return Column(
      children: [
        _buildPaymentOption(
          value: 'card',
          title: 'Credit / Debit Card',
          subtitle: 'Pay securely with Stripe',
          icon: FontAwesomeIcons.creditCard,
          isMobile: isMobile,
        ),
        SizedBox(height: 16),
        _buildPaymentOption(
          value: 'bank_transfer',
          title: 'Bank Transfer',
          subtitle: 'Direct bank transfer (manual verification)',
          icon: FontAwesomeIcons.buildingColumns,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isMobile,
  }) {
    final isSelected = _paymentMethod == value;
    
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF8F3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B35) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? const Color(0xFFFF6B35) 
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: _paymentMethod,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _paymentMethod = newValue);
                }
              },
              activeColor: const Color(0xFFFF6B35),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCheckout() {
    if (_formKey.currentState!.validate()) {
      // TODO: Integrate Stripe payment
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Processing payment...'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      
      // TODO: Navigate to success page or process payment
    }
  }
}
