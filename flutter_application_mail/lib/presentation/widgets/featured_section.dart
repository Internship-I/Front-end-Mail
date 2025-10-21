import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
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
        'onTap': () {
          // Navigasi lain bisa ditambahkan di sini
        },
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Banner biru elegan di atas
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 25, 111),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.sticky_note_2_outlined,
                    color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "There are Featured Services",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 🔹 Dua tombol utama
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: features.map((item) {
              return _buildFeatureItem(
                icon: item['icon'],
                label: item['label'],
                onTap: item['onTap'],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // 🔹 Icon Button dengan border elegan
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    const Color.fromARGB(255, 8, 20, 76), // garis biru elegan
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 32,
              color: const Color(0xFF0B1650),
            ),
          ),
          const SizedBox(height: 8),

          // 🔹 Label di bawah ikon
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
