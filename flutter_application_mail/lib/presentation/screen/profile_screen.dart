import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/Profile/index_profile.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER COMPACT =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/poslogo.png",
                          height: 24, fit: BoxFit.contain),
                      const SizedBox(width: 8),
                      Container(
                          height: 16, width: 1, color: Colors.grey.shade300),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/images/danantara.png",
                        height: 28,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const SizedBox(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Muhammad Qinthar",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: navy)),
                          Text("kurir - ID: 882190", // Tambah ID biar pro
                              style: GoogleFonts.poppins(
                                  fontSize: 10, // Font diperkecil
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/qin.jpg'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: navy.withOpacity(0.04), // Background sangat tipis
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Agar lebar menyesuaikan konten
                  children: [
                    Icon(Icons.insights_rounded, size: 14, color: navy),
                    const SizedBox(width: 8),
                    Text(
                      "Your Daily Activity Overview",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: navy,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),

              // ===============================================
              // 1. TAMBAHAN: LIVE STATUS BAR (Work Shift Info)
              // ===============================================
              // Ganti Container 'Live Status Bar' dengan ini:
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kiri: Progress Harian
                    Row(
                      children: [
                        const Icon(Icons.local_shipping_outlined,
                            color: navy, size: 16),
                        const SizedBox(width: 6),
                        Text("Delivered: ",
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.grey[600])),
                        Text("18/25",
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: navy)),
                      ],
                    ),
                    // Kanan: Sisa Waktu/Paket
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 14, color: Colors.orange[800]),
                        const SizedBox(width: 4),
                        Text("7 Remaining",
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange[800])),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===== CATEGORY BUTTONS COMPACT =====
              Row(
                children: [
                  _buildCategoryButton("Connection", _currentPage == 0, navy),
                  const SizedBox(width: 6),
                  _buildCategoryButton("Statistics", _currentPage == 1, navy),
                  const SizedBox(width: 6),
                  _buildCategoryButton("Item", _currentPage == 2, navy),
                ],
              ),
              const SizedBox(height: 14),

              // ===== PAGEVIEW SECTION =====
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildConnectionPage(navy),
                    const StatisticsWidget(),
                    const ItemWidget(),
                  ],
                ),
              ),

              const SizedBox(height: 8),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? navy : Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 11,
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
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Page
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Attendance for courier",
                        style: GoogleFonts.poppins(
                            color: navy,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                    Text("Scan the device’s QR to connect",
                        style: GoogleFonts.poppins(
                            color: Colors.black54, fontSize: 10)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: navy.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.qr_code_scanner_rounded,
                      color: Colors.black, size: 20),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Gambar Utama
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Radius sedikit diperhalus
              child: Image.asset('assets/images/backgroundmail5.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover), // Tinggi dikembalikan ke 180 agar compact
            ),

            const SizedBox(height: 12),

            // ===============================================
            // 2. TAMBAHAN: DEVICE DIAGNOSTICS (Panel Hardware)
            // ===============================================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.perm_device_information_rounded,
                          size: 16, color: navy),
                      const SizedBox(width: 8),
                      Text("Connected Device Status",
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: navy)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(4)),
                        child: Text("Synced",
                            style: GoogleFonts.poppins(
                                fontSize: 9,
                                color: Colors.green,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDeviceInfoItem("Device ID", "POS-2210"),
                      _buildDeviceInfoItem("Battery", "85%"),
                      _buildDeviceInfoItem("Signal", "4G LTE"),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk info device
  Widget _buildDeviceInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(fontSize: 9, color: Colors.grey[500])),
        const SizedBox(height: 2),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0A1D37))),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email_outlined,
                    size: 18, color: Colors.black54),
                const SizedBox(width: 12),
                const Icon(Icons.chat_bubble_outline_rounded,
                    size: 18, color: Colors.black54),
                const SizedBox(width: 12),
                const Icon(Icons.camera_alt_outlined,
                    size: 18, color: Colors.black54),
              ],
            ),
            const SizedBox(height: 8),
            Row(
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
                const SizedBox(width: 4),
                Image.asset(
                  "assets/images/poslogo.png",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
