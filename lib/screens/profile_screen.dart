import 'package:flutter/material.dart';
import '../widgets/custom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF292D32), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF292D32),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined,
                color: Color(0xFF292D32), size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo Grid Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPhotoGrid(),
            ),

            // Your Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF292D32),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildProfileDetailsList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Discover Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildDiscoverSection(),
            ),

            const SizedBox(height: 20),

            // Take Quiz Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTakeQuizButton(),
            ),

            const SizedBox(height: 80), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 4),
    );
  }

  Widget _buildPhotoGrid() {
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          // Main large photo
          Expanded(
            flex: 3,
            child: _buildPhotoWithCross(
              'assets/icons/profile_icon/Image.png',
              const EdgeInsets.only(right: 6),
              isMain: true,
            ),
          ),

          // Middle column
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: _buildPhotoWithCross(
                    'assets/icons/profile_icon/Image (1).png',
                    const EdgeInsets.only(bottom: 3, right: 3),
                  ),
                ),
                Expanded(
                  child: _buildPhotoWithCross(
                    'assets/icons/profile_icon/Image (2).png',
                    const EdgeInsets.only(top: 3, right: 3),
                  ),
                ),
              ],
            ),
          ),

          // Right column
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: _buildPhotoWithCross(
                    'assets/icons/profile_icon/Image (3).png',
                    const EdgeInsets.only(bottom: 3),
                  ),
                ),
                Expanded(
                  child: _buildPhotoWithCross(
                    'assets/icons/profile_icon/Image (4).png',
                    const EdgeInsets.only(top: 3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithCross(String imagePath, EdgeInsets margin,
      {bool isMain = false}) {
    return Container(
      margin: margin,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (isMain)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF44464B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Main',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: () {
                // Handle photo removal
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF44464B).withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Color(0xFFFFFFFF),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetailsList() {
    final List<Map<String, dynamic>> profileItems = [
      {
        'icon': Icons.person_outline,
        'title': 'About me (Bio)',
        'hasArrow': true
      },
      {
        'icon': Icons.search,
        'title': 'What are you looking for?',
        'hasArrow': true
      },
      {'icon': Icons.location_on_outlined, 'title': 'Gender', 'hasArrow': true},
      {
        'icon': Icons.cake_outlined,
        'title': 'Birthday (Age)',
        'hasArrow': true
      },
      {'icon': Icons.height, 'title': 'Height', 'hasArrow': true},
      {
        'icon': Icons.favorite_outline,
        'title': 'Interested in?',
        'hasArrow': true
      },
      {'icon': Icons.wc_outlined, 'title': 'Sexuality', 'hasArrow': true},
      {
        'icon': Icons.favorite_border,
        'title': 'Relationship',
        'hasArrow': true
      },
      {'icon': Icons.public, 'title': 'Ethnicity', 'hasArrow': true},
      {'icon': Icons.child_care, 'title': 'Kids', 'hasArrow': true},
      {'icon': Icons.local_bar_outlined, 'title': 'Drinking', 'hasArrow': true},
      {
        'icon': Icons.smoking_rooms_outlined,
        'title': 'Smoking',
        'hasArrow': true
      },
      {
        'icon': Icons.local_pharmacy_outlined,
        'title': 'Marijuana',
        'hasArrow': true
      },
      {
        'icon': Icons.church_outlined,
        'title': 'Religious Beliefs',
        'hasArrow': true
      },
      {
        'icon': Icons.how_to_vote_outlined,
        'title': 'Political Views',
        'hasArrow': true
      },
      {
        'icon': Icons.interests_outlined,
        'title': 'Interest and Hobbies',
        'hasArrow': true
      },
      {
        'icon': Icons.diamond_outlined,
        'title': 'Values & Lifestyle',
        'hasArrow': true
      },
    ];

    return Column(
      children: profileItems
          .map((item) => _buildProfileItem(
                icon: item['icon'],
                title: item['title'],
                hasArrow: item['hasArrow'],
              ))
          .toList(),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    bool hasArrow = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFF0F0F0),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6E6F73),
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF292D32),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (hasArrow)
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF6E6F73),
              size: 14,
            ),
        ],
      ),
    );
  }

  Widget _buildDiscoverSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFECD3E8),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Discover your Perfect Match',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF292D32),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: Image.asset(
              'assets/icons/profile_icon/Avatar group (1).png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTakeQuizButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Handle quiz button tap
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5E1053),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Take the quiz again',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
