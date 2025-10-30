import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroLoadingPage extends StatefulWidget {
  const IntroLoadingPage({super.key});

  @override
  State<IntroLoadingPage> createState() => _IntroLoadingPageState();
}

class _IntroLoadingPageState extends State<IntroLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Map<String, String> slide = {
    "title": "Data Penerima",
    "subtitle": "Safe, and reliable courier service.\n – anytime, anywhere.",
    "image": "assets/images/komunikasi.png",
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFE),
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 Navbar (logo Pos + Danantara)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/poslogo.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/images/danantara.png",
                    width: 70,
                    height: 70,
                  ),
                ],
              ),
            ),

            // 🔹 Konten utama agak di tengah
            Column(
              children: [
                const Spacer(flex: 2), // 🔹 Memberi ruang dari atas

                // 🔹 Judul
                Text(
                  slide["title"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // 🔹 Subjudul
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    slide["subtitle"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),

                // 🔹 Gambar utama
                Image.asset(
                  slide["image"]!,
                  width: 220,
                  height: 220,
                  fit: BoxFit.contain,
                ),

                const Spacer(flex: 1), // 🔹 Dorong loading tetap di bawah

                // 🔹 Kotak loading animasi (tetap di sini)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        double progress =
                            (_controller.value * 5 - index).clamp(0.0, 1.0);
                        double scale = Curves.easeInOut.transform(progress);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              const Color(0xFF0B1650),
                              const Color.fromARGB(255, 255, 255, 255),
                              scale,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 60),
              ],
            ),

            // 🔹 Supported By tetap di bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                    const SizedBox(width: 6),
                    Image.asset(
                      "assets/images/poslogo.png",
                      width: 28,
                      height: 28,
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
