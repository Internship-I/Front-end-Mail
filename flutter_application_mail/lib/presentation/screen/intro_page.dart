import 'dart:async'; // ⚠️ untuk Timer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer; // 🔹 Timer yang bisa dibatalkan

  final List<Map<String, String>> slides = [
    {
      "title": "Aplikasi Untuk Kurir Pengiriman Paket",
      "subtitle":
          "Safe, and reliable courier service.\nEasy to order – anytime, anywhere.",
      "image": "assets/images/kurir.jpg",
    },
    {
      "title": "Aplikasi Untuk Kurir Komunikasi Paket",
      "subtitle":
          "Safe, and reliable courier service.\nEasy to order – anytime, anywhere.",
      "image": "assets/images/komunikasi.png",
    },
    {
      "title": "Aplikasi Untuk Kurir Terintegrasi Paket",
      "subtitle":
          "Safe, and reliable courier service.\nEasy to order – anytime, anywhere.",
      "image": "assets/images/integrasi.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel(); // Batalkan timer sebelumnya kalau ada
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_pageController.hasClients) return;
      int nextPage = _currentPage + 1;
      if (nextPage >= slides.length) nextPage = 0;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = nextPage);
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel(); // Hentikan timer saat page di dispose
    _pageController.dispose();
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

            // 🔹 Slider utama
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                        _startAutoSlide(); // Restart timer saat user swipe manual
                      },
                      itemCount: slides.length,
                      itemBuilder: (context, index) {
                        final slide = slides[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              slide["title"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              slide["subtitle"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            Image.asset(
                              slide["image"]!,
                              width: 230,
                              height: 230,
                              fit: BoxFit.contain,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // 🔹 Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF0B1650)
                              : Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40), // Jarak sebelum tombol

                  // 🔹 Tombol Start Now
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B1650),
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

                  const SizedBox(height: 60), // Jarak antar tombol & footer
                ],
              ),
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
