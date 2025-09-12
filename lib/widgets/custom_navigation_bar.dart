import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/blind_mixer_screen.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 'assets/icons/nav_icon/Mixer (1).png',
              selectedIndex == 0, 0),
          _buildNavItem(context, 'assets/icons/nav_icon/Your-Mix.png',
              selectedIndex == 1, 1),
          _buildNavItem(context, 'assets/icons/nav_icon/Events.png',
              selectedIndex == 2, 2),
          _buildNavItem(context, 'assets/icons/nav_icon/Blind-Mix.png',
              selectedIndex == 3, 3),
          _buildNavItem(context, 'assets/icons/nav_icon/Profile.png',
              selectedIndex == 4, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, String iconPath, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(index);
        } else {
          _handleNavigation(context, index);
        }
      },
      child: Container(
        width: 70,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                iconPath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    size: 24,
                    color: Colors.red,
                  );
                },
              ),
            ),
            if (isSelected)
              Positioned(
                bottom: 8,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5E1053),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to Home/Mixer
        Navigator.popUntil(context, (route) => route.isFirst);
        break;
      case 1:
        // Navigate to Your Mix
        break;
      case 2:
        // Navigate to Events
        break;
      case 3:
        // Navigate to Blind Mix
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BlindMixerScreen()),
        );
        break;
      case 4:
        // Navigate to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}
