import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Ukuran proporsional rapi & kecil
    final iconSize = screenWidth * 0.07;
    final circleSize = screenWidth * 0.15;
    final fontSize = screenWidth * 0.032;

    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.inventory_2_rounded,
        'label': 'Data Penerima',
        'onTap': () {
          Navigator.pushNamed(context, AppRoutes.dashboard);
        },
      },
      {
        'icon': Icons.dashboard_customize_rounded,
        'label': 'Dashboard',
        'onTap': () {},
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.045,
        horizontal: screenWidth * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Garis/banner navy yang lebih pendek & menarik
          Center(
            child: Container(
              width: screenWidth * 0.75, // 🔸 lebih pendek (75% dari layar)
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.025,
                horizontal: screenWidth * 0.035,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0C196F),
                    Color(0xFF1E2FA2),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "There are Featured Services",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenWidth * 0.06),

          // 🔹 Dua tombol utama
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: features.map((item) {
              return _buildFeatureItem(
                icon: item['icon'],
                label: item['label'],
                onTap: item['onTap'],
                circleSize: circleSize,
                iconSize: iconSize,
                fontSize: fontSize,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 🔹 Item Fitur
  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double circleSize,
    required double iconSize,
    required double fontSize,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 255, 98, 1),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: const Color.fromARGB(255, 9, 16, 91),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
