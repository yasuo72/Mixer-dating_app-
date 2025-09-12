import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../widgets/custom_button.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: ResponsiveHelper(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: ResponsiveHelper.getResponsivePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildSubscriptionPlans(context),
          const SizedBox(height: 32),
          _buildFeatures(context),
          const SizedBox(height: 32),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: ResponsiveHelper.getResponsivePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildSubscriptionPlans(context),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildFeatures(context),
                    const SizedBox(height: 32),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Unlock premium features with our subscription plans',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionPlans(BuildContext context) {
    return Column(
      children: [
        _buildPlanCard(
          context,
          title: 'Basic Plan',
          price: '\$9.99',
          period: '/month',
          features: ['Feature 1', 'Feature 2', 'Feature 3'],
          isPopular: false,
        ),
        const SizedBox(height: 16),
        _buildPlanCard(
          context,
          title: 'Premium Plan',
          price: '\$19.99',
          period: '/month',
          features: ['All Basic features', 'Premium Feature 1', 'Premium Feature 2', 'Premium Feature 3'],
          isPopular: true,
        ),
        const SizedBox(height: 16),
        _buildPlanCard(
          context,
          title: 'Pro Plan',
          price: '\$29.99',
          period: '/month',
          features: ['All Premium features', 'Pro Feature 1', 'Pro Feature 2', 'Pro Feature 3'],
          isPopular: false,
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isPopular ? const Color(0xFF5E1053) : Colors.grey[300]!,
          width: isPopular ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isPopular ? const Color(0xFFECD3E8) : Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF5E1053),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isPopular) const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5E1053),
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
                ),
              ),
              Text(
                period,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why Choose Us?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
          ),
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(
          context,
          icon: Icons.security,
          title: 'Secure & Safe',
          description: 'Your data is protected with enterprise-grade security',
        ),
        const SizedBox(height: 12),
        _buildFeatureItem(
          context,
          icon: Icons.support_agent,
          title: '24/7 Support',
          description: 'Get help whenever you need it from our expert team',
        ),
        const SizedBox(height: 12),
        _buildFeatureItem(
          context,
          icon: Icons.update,
          title: 'Regular Updates',
          description: 'Enjoy new features and improvements regularly',
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFECD3E8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF5E1053),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Start Free Trial',
          onPressed: () {},
          isPrimary: true,
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'Learn More',
          onPressed: () {},
          isPrimary: false,
        ),
      ],
    );
  }
}
