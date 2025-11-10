import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Ukuran umum
    final fontSize = screenWidth * 0.035;

    // 🔹 Daftar fitur
    final List<Map<String, dynamic>> features = [
      {
        'iconPath': 'assets/images/data_icon.png',
        'iconSize': screenWidth * 0.15,
        'onTap': () {
          Navigator.pushNamed(context, AppRoutes.dashboard);
        },
      },
      {
        'iconPath': 'assets/images/dashboardicon1.png',
        'iconSize': screenWidth * 0.15,
        'onTap': () {
          Navigator.pushNamed(context, AppRoutes.adminDashboard);
        },
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.15, // sedikit dikurangi biar bg lebih naik
        horizontal: screenWidth * 0.15,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("assets/images/backgroundmail12.png"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter, // ⬆️ posisi gambar digeser ke atas
          // colorFilter: ColorFilter.mode(
          //   Colors.black.withOpacity(0.2),
          //   BlendMode.darken,
          // ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Judul elegan
          Center(
            child: Container(
              width: screenWidth * 0.75,
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.025,
                horizontal: screenWidth * 0.035,
              ),
              child: Text(
                ".",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 4,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: screenWidth * 0.08),

          // 🔹 Dua ikon tanpa box atau border
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: features.map((item) {
              return GestureDetector(
                onTap: item['onTap'],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      item['iconPath'],
                      width: item['iconSize'],
                      height: item['iconSize'],
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    // Text(
                    //   item['label'],
                    //   style: GoogleFonts.playfairDisplay(
                    //     color: Colors.black87,
                    //     fontSize: fontSize - 1,
                    //     fontWeight: FontWeight.w600,
                    //     letterSpacing: 0.5,
                    //   ),
                    // ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
