import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/Profile/index_profile.dart'; // Import statistik dan item

class ProfileScreenNew extends StatefulWidget {
  const ProfileScreenNew({super.key});

  @override
  State<ProfileScreenNew> createState() => _ProfileScreenNewState();
}

class _ProfileScreenNewState extends State<ProfileScreenNew> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!mounted) return;
      if (!_pageController.hasClients) return;

      _currentPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
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
    const Color navy = Color(0xFF0A1D37);
    const Color white = Colors.white;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/poslogo.png",
                          width: 50, height: 50, fit: BoxFit.contain),
                      const SizedBox(width: 10),
                      Image.asset("assets/images/danantara.png",
                          width: 60, height: 60, fit: BoxFit.contain),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Hi,",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400)),
                          Text("Muhammad Qinthar",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: navy)),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/images/qin.jpg'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: Text(
                  "Profile Page",
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700, color: navy),
                ),
              ),

              const SizedBox(height: 20),

              // ===== CATEGORY BUTTONS =====
              Row(
                children: [
                  _buildCategoryButton("Connection", _currentPage == 0, navy),
                  const SizedBox(width: 8),
                  _buildCategoryButton("Statistics", _currentPage == 1, navy),
                  const SizedBox(width: 8),
                  _buildCategoryButton("Item", _currentPage == 2, navy),
                ],
              ),
              const SizedBox(height: 20),

              // ===== PAGEVIEW SECTION =====
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildConnectionPage(navy),
                    const StatisticsWidget(), // dari file statistics.dart
                    const ItemWidget(), // dari file item.dart
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text, bool isActive, Color navy) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? navy : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.poppins(
                  color: isActive ? Colors.white : navy,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _buildConnectionPage(Color navy) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: navy.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Attendance for courier",
                style: GoogleFonts.poppins(
                    color: navy, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Scan the device’s QR to connect",
                    style: GoogleFonts.poppins(
                        color: Colors.black54, fontSize: 12)),
                const Icon(Icons.qr_code_rounded, color: Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('assets/images/logo.png',
                  height: 230, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text("For Couriers",
                style: GoogleFonts.poppins(
                    color: Colors.black54, fontSize: 13, letterSpacing: 2)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15), // posisi agak naik ke atas
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // === ICON SOSMED ===
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 22, color: Colors.black54),
                const SizedBox(width: 16),
                Icon(Icons.chat_bubble, size: 22, color: Colors.black54),
                const SizedBox(width: 16),
                Icon(Icons.camera_alt, size: 22, color: Colors.black54),
              ],
            ),
            const SizedBox(height: 15),

            // === SUPPORTED BY ===
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Supported By",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 6), // jarak lebih rapat ke logo
                Image.asset(
                  "assets/images/poslogo.png",
                  width: 26,
                  height: 26,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
