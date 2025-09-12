import 'package:flutter/material.dart';
import 'mixer_screen.dart';
import '../widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMixerPopupOnLoad = true;
  
  @override
  void initState() {
    super.initState();
    // Show mixer popup after a delay
    if (_showMixerPopupOnLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          _showMixerPopup();
        });
      });
    }
  }

  void _showMixerPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const MixerScreen(),
      ),
    ).then((_) {
      // Popup was closed
      setState(() {
        _showMixerPopupOnLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilters(),
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mixer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Handle flash/boost action
                  _showBoostDialog();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/flash-circle.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.flash_on,
                          color: Color(0xFF5E1053),
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // Handle notifications
                  _showNotifications();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/notification.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.notifications_outlined,
                              color: Color(0xFF5E1053),
                              size: 24,
                            );
                          },
                        ),
                      ),
                      // Notification badge
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B9D),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            _buildFilterChip('Filters', Icons.tune, const Color(0xFF8B4B8C)),
            const SizedBox(width: 12),
            _buildFilterChip('Age', Icons.keyboard_arrow_down, Colors.grey),
            const SizedBox(width: 12),
            _buildFilterChip('Height', Icons.keyboard_arrow_down, Colors.grey),
            const SizedBox(width: 12),
            _buildFilterChip('Habits', Icons.keyboard_arrow_down, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _handleFilterTap(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color == const Color(0xFF8B4B8C)
              ? color.withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color == const Color(0xFF8B4B8C) ? color : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile images
        SizedBox(
          width: 200,
          height: 80,
          child: Image.asset(
            'assets/icons/Avatar group.png',
            width: 200,
            height: 80,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF5E1053),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFFF6B9D),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFFFB347),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          "You've seen everyone nearby",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'No more profiles in your area. Check back later or expand your location to see more people.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 200,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B4B8C), Color(0xFFB565A7)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: ElevatedButton(
            onPressed: () {
              _adjustLocation();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Adjust Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Handle boost/flash action
  void _showBoostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Boost Your Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292D32),
            ),
          ),
          content: const Text(
            'Get more visibility and matches by boosting your profile for 30 minutes.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6E6F73),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF6E6F73)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showMixerPopup();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E1053),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Boost Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Handle notifications
  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF292D32),
              ),
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'New Match!',
              'You have a new match with Sarah',
              '2 min ago',
              Icons.favorite,
              const Color(0xFFFF6B9D),
            ),
            _buildNotificationItem(
              'Message Received',
              'Emma sent you a message',
              '1 hour ago',
              Icons.message,
              const Color(0xFF5E1053),
            ),
            _buildNotificationItem(
              'Profile View',
              'Someone viewed your profile',
              '3 hours ago',
              Icons.visibility,
              const Color(0xFFFFB347),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E1053),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF292D32),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6E6F73),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6E6F73),
            ),
          ),
        ],
      ),
    );
  }

  // Handle filter taps
  void _handleFilterTap(String filterType) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$filterType Filter',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF292D32),
              ),
            ),
            const SizedBox(height: 16),
            if (filterType == 'Age') ...[
              const Text('Age Range: 18 - 35'),
              Slider(
                value: 25,
                min: 18,
                max: 50,
                divisions: 32,
                activeColor: const Color(0xFF5E1053),
                onChanged: (value) {},
              ),
            ] else if (filterType == 'Height') ...[
              const Text('Height Range: 5\'0" - 6\'5"'),
              Slider(
                value: 5.5,
                min: 4.5,
                max: 7.0,
                divisions: 25,
                activeColor: const Color(0xFF5E1053),
                onChanged: (value) {},
              ),
            ] else if (filterType == 'Habits') ...[
              _buildHabitOption('Non-smoker', true),
              _buildHabitOption('Social drinker', false),
              _buildHabitOption('Fitness enthusiast', true),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Color(0xFF6E6F73)),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5E1053),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitOption(String habit, bool isSelected) {
    return CheckboxListTile(
      title: Text(habit),
      value: isSelected,
      activeColor: const Color(0xFF5E1053),
      onChanged: (value) {},
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  // Handle location adjustment
  void _adjustLocation() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adjust Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF292D32),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Expand your search radius to find more people',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6E6F73),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Search Radius: 25 km'),
            Slider(
              value: 25,
              min: 1,
              max: 100,
              divisions: 99,
              activeColor: const Color(0xFF5E1053),
              label: '25 km',
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Simulate finding new profiles
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location updated! New profiles available.'),
                      backgroundColor: Color(0xFF5E1053),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E1053),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Update Location',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
