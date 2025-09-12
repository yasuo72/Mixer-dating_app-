import 'package:flutter/material.dart';
import '../widgets/custom_navigation_bar.dart';

class BlindMixerScreen extends StatefulWidget {
  const BlindMixerScreen({super.key});

  @override
  State<BlindMixerScreen> createState() => _BlindMixerScreenState();
}

class _BlindMixerScreenState extends State<BlindMixerScreen> {
  bool hasApplied = false; // Toggle between applied and sign up states
  int selectedTab = 0; // 0: Sign Up, 1: Smart Match, 2: Blind Date
  bool isLoading = false;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 7));
  TimeOfDay selectedTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _buildHeader(),
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildCentralIllustration(),
              const SizedBox(height: 40),
              _buildUpcomingDateSection(),
              const SizedBox(height: 50),
              _buildActionSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 3),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Blind Mixer',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
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
                    padding: const EdgeInsets.all(6.0),
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
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
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
                        padding: const EdgeInsets.all(6.0),
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

  Widget _buildCentralIllustration() {
    return Container(
      width: 200,
      height: 200,
      child: Image.asset(
        'assets/icons/image 71.png',
        width: 200,
        height: 200,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 60,
                    color: Color(0xFF5E1053),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Blind Date\nIllustration',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6E6F73),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUpcomingDateSection() {
    return Column(
      children: [
        const Text(
          'Upcoming Blind Date',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF292D32),
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Let Mixer surprise you with a match.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6E6F73),
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF5E1053),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _selectDateTime,
                child: Text(
                  '${_formatDate(selectedDate)} - ${_formatTime(selectedTime)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF292D32),
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    if (hasApplied) {
      return _buildAppliedSection();
    } else {
      return _buildSignUpSection();
    }
  }

  Widget _buildAppliedSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF5E1053).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF5E1053),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Applied for Blind Mixer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5E1053),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return Column(
      children: [
        // Sign Up options
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 0;
                });
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: selectedTab == 0 ? const Color(0xFF5E1053) : const Color(0xFF6E6F73),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '•',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6E6F73),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 1;
                });
                _showSmartMatchDialog();
              },
              child: Text(
                'Smart Match',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedTab == 1 ? const Color(0xFF5E1053) : const Color(0xFF6E6F73),
                  letterSpacing: -0.2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '•',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6E6F73),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 2;
                });
                _showBlindDateInfo();
              },
              child: Text(
                'Blind Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedTab == 2 ? const Color(0xFF5E1053) : const Color(0xFF6E6F73),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Fill out the Form button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : () {
              _handleFormSubmission();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5E1053),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Fill out the Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  // Date and time formatting methods
  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour ${period}';
  }

  // Date and time selection
  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5E1053),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF5E1053),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  // Handle form submission
  Future<void> _handleFormSubmission() async {
    setState(() {
      isLoading = true;
    });

    // Simulate form processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      hasApplied = true;
    });

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully applied for Blind Mixer!'),
          backgroundColor: Color(0xFF5E1053),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Show Smart Match dialog
  void _showSmartMatchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Smart Match',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292D32),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Our AI will find the perfect match based on:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6E6F73),
                ),
              ),
              const SizedBox(height: 12),
              _buildMatchCriteria('Personality compatibility'),
              _buildMatchCriteria('Shared interests'),
              _buildMatchCriteria('Location proximity'),
              _buildMatchCriteria('Lifestyle preferences'),
            ],
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
                _handleFormSubmission();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E1053),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Enable Smart Match',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMatchCriteria(String criteria) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF5E1053),
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            criteria,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF292D32),
            ),
          ),
        ],
      ),
    );
  }

  // Show Blind Date information
  void _showBlindDateInfo() {
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
              'Blind Date Experience',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF292D32),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'What to expect:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF292D32),
              ),
            ),
            const SizedBox(height: 12),
            _buildBlindDateFeature(
              Icons.visibility_off,
              'Complete anonymity until you meet',
            ),
            _buildBlindDateFeature(
              Icons.restaurant,
              'Curated restaurant experience',
            ),
            _buildBlindDateFeature(
              Icons.security,
              'Safe and verified matches only',
            ),
            _buildBlindDateFeature(
              Icons.favorite,
              'Focus on genuine connection',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFormSubmission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E1053),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Join Blind Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlindDateFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF5E1053).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5E1053),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF292D32),
              ),
            ),
          ),
        ],
      ),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile boosted for 30 minutes!'),
                    backgroundColor: Color(0xFF5E1053),
                  ),
                );
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
              'Blind Mixer Match!',
              'You have a potential match for tonight',
              '5 min ago',
              Icons.favorite,
              const Color(0xFFFF6B9D),
            ),
            _buildNotificationItem(
              'Date Confirmed',
              'Your blind date is confirmed for ${_formatDate(selectedDate)}',
              '1 hour ago',
              Icons.calendar_today,
              const Color(0xFF5E1053),
            ),
            _buildNotificationItem(
              'Profile Boost',
              'Your profile boost is now active',
              '2 hours ago',
              Icons.flash_on,
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
}
