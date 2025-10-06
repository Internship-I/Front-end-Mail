import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_routes.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 254, 255),
      body: SafeArea(
        child: Stack(
          children: [
            // Logo di pojok kiri atas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    width: 70,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            // Konten utama di tengah layar
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bagian teks (pindah ke atas gambar kurir)
                  Column(
                    children: [
                      Text(
                        "Aplikasi Untuk Kurir Pengiriman Paket",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Safe, and reliable courier service.\nEasy to order – anytime, anywhere.",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color.fromARGB(179, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Bagian gambar kurir/logo
                  Image.asset(
                    "assets/images/kurir.jpg",
                    width: 230,
                    height: 230,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 50),

                  // Bagian tombol
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 22, 80),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: Text(
                        "Start Now!",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bagian Supported By di bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Supported By",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8), // jarak teks dan logo
                    Image.asset(
                      "assets/images/poslogo.png",
                      width: 30,
                      height: 30,
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
}
