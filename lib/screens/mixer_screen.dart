import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/responsive_helper.dart';

class MixerScreen extends StatefulWidget {
  const MixerScreen({super.key});

  @override
  State<MixerScreen> createState() => _MixerScreenState();
}

class _MixerScreenState extends State<MixerScreen> {
  bool isVipSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveHelper(
          mobile: _buildMobileLayout(context),
          tablet: _buildMobileLayout(context),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildTitle(context),
          const SizedBox(height: 16),
          _buildSubtitle(context),
          const SizedBox(height: 32),
          _buildPlanCards(context),
          const SizedBox(height: 32),
          _buildIncludedSection(context),
          const SizedBox(height: 32),
          _buildContinueButton(context),
          const SizedBox(height: 16),
          _buildFooterText(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Mixer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SizedBox(
        width: 304,
        height: 27,
        child: Text(
          'Level Up Your Mixer Experience',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF8B4B8C),
            height: 1.0,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        'Select a plan',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildPlanCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: _buildPlanCard(
              title: 'Mixer',
              price: '\$24.99',
              subtitle: 'All of the below',
              isSelected: !isVipSelected,
              onTap: () {
                setState(() {
                  isVipSelected = false;
                });
              },
              iconColor: const Color.fromARGB(0, 255, 107, 156),
              iconAsset: 'assets/icons/image 868.png',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildPlanCard(
              title: 'Mixer VIP',
              price: '\$99.99',
              subtitle: isVipSelected
                  ? 'Mixer + VIP seating,\nfood & beverages'
                  : 'All 3 + VIP seating,\nfood, and beverages',
              isSelected: isVipSelected,
              onTap: () {
                setState(() {
                  isVipSelected = true;
                });
              },
              iconColor: const Color.fromARGB(60, 255, 178, 71),
              iconAsset: 'assets/icons/image 873.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required Color iconColor,
    String? iconAsset,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 166,
        height: 146,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B4B8C) : Colors.grey[300]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: iconAsset != null
                      ? Image.asset(
                          iconAsset,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.favorite,
                              color: iconColor,
                              size: 16,
                            );
                          },
                        )
                      : Icon(
                          Icons.favorite,
                          color: iconColor,
                          size: 16,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: title == 'Mixer VIP'
                    ? const Color(0xFFFF8C00)
                    : const Color(0xFF8B4B8C),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncludedSection(BuildContext context) {
    final features = [
      'Unlimited Likes',
      'See who liked you',
      'Find people with wide range',
      'Access to events',
    ];

    if (isVipSelected) {
      features.add('VIP seating, food & beverages');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Included with Mixer VIP',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isVipSelected &&
                                  feature == 'VIP seating, food & beverages'
                              ? const Color(0xFFFF8C00)
                              : const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isVipSelected
                ? [const Color(0xFFFF8C00), const Color(0xFFFFB347)]
                : [const Color(0xFF8B4B8C), const Color(0xFFB565A7)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                child: isVipSelected
                    ? Image.asset(
                        'assets/icons/image 873.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 20,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/icons/image 868.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 20,
                          );
                        },
                      ),
              ),
              const SizedBox(width: 8),
              Text(
                'Continue - ${isVipSelected ? '\$99.99' : '\$24.99'} total',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'By continuing, you agree to be charged, with auto-renewal until cancelled in App Store settings, under Mixer\'s Terms.',
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey[600],
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
