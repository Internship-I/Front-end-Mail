import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_routes.dart';
import '../widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama
            Column(
              children: [
                const SizedBox(height: 70), // ruang untuk logo
                // Greeting
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 60, 58, 58),
                          ),
                        ),
                        Text(
                          "Kurir",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Muhammad Qinthar",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 Horizontal scroll card pakai gambar
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      buildImageCard(
                        title: "PT Pos Indonesia",
                        imagePath: "assets/images/poslogo.png",
                      ),
                      const SizedBox(width: 16),
                      buildImageCard(
                        title: "Danantara",
                        imagePath: "assets/images/danantara.png",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Featured section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Featured",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Horizontal scroll card gaya kursus (ada tombol +)
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      buildCourseCard(
                        title: "Data Penerima",
                        subtitle: "Kurir",
                        imagePath: "assets/images/kurir.jpg",
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.dashboard);
                        },
                      ),
                      const SizedBox(width: 16),
                      buildCourseCard(
                        title: " + Penerima",
                        subtitle: "Admin",
                        imagePath: "assets/images/kurir.jpg",
                        onTap: () {
                          // aksi tambah penerima
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),

            //logout
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ),
            // Logo di pojok kiri atas
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/poslogo.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/danantara.png",
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Card dengan foto
  Widget buildImageCard({required String title, required String imagePath}) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gambar di atas
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          // Judul di bawah
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Fungsi card gaya kursus (tetap dipakai di bagian Featured)
  Widget buildCourseCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 3, 7, 125).withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            // Subjudul
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color.fromARGB(255, 28, 27, 27),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 12),
            // Gambar ilustrasi di bawah
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
