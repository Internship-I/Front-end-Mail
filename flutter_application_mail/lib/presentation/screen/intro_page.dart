import 'dart:async';
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
  Timer? _autoSlideTimer;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_pageController.hasClients) return;

      int nextPage = (_currentPage + 1) % slides.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800), // 🔹 lebih lama = smooth
        curve: Curves.easeInOutCubic, // 🔹 transisi halus
      );

      setState(() => _currentPage = nextPage);
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isSmall = size.width < 360;

    // 🔹 Ukuran sedikit dikecilkan
    double titleSize = isTablet ? 26 : (isSmall ? 18 : 22);
    double subtitleSize = isTablet ? 16 : (isSmall ? 12 : 14);
    double imageSize = isTablet ? 300 : (isSmall ? 160 : 200);
    double buttonFont = isTablet ? 18 : 15;
    double buttonPadding = isTablet ? 100 : 70;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFE),
      body: SafeArea(
        child: Stack(
          children: [
            // 🔹 Logo di atas
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/poslogo.png",
                      width: 42, height: 42),
                  const SizedBox(width: 8),
                  Image.asset("assets/images/danantara.png",
                      width: 60, height: 60),
                ],
              ),
            ),

            // 🔹 Konten utama
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      _startAutoSlide();
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      final slide = slides[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              slide["title"]!,
                              style: GoogleFonts.poppins(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              slide["subtitle"]!,
                              style: GoogleFonts.poppins(
                                fontSize: subtitleSize,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 25),
                            Image.asset(
                              slide["image"]!,
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 🔹 Page indicator (lebih kecil)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == index ? 14 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF0B1650)
                            : Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Tombol "Start Now"
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1650),
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      "Start Now!",
                      style: GoogleFonts.poppins(
                        fontSize: buttonFont,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 60 : 50),
              ],
            ),

            // 🔹 Footer kecil
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Supported By",
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      "assets/images/poslogo.png",
                      width: 24,
                      height: 24,
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
