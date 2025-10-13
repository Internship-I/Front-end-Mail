import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    // Auto-slide PageView setiap 4 detik
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      if (!_pageController.hasClients) return;

      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

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
              // ===== HEADER ATAS =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/poslogo.png",
                          width: 38, height: 38),
                      const SizedBox(width: 8),
                      Image.asset("assets/images/danantara.png",
                          width: 38, height: 38),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_rounded,
                            color: navy, size: 26),
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/qin.jpg'),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ===== TITLE =====
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: Text(
                  "Profile Page\nKurir",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: navy,
                  ),
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
                    _buildStatisticsPage(navy),
                    _buildShopPage(navy),
                  ],
                ),
              ),

              // ===== SOSMED ICONS =====
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                        icon: Icons.email_rounded,
                        color: Colors.black54,
                        onTap: () {}),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                        icon: Icons.chat_rounded,
                        color: Colors.black54,
                        onTap: () {}),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                        icon: Icons.camera_alt_rounded,
                        color: Colors.black54,
                        onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== FOOTER =====
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Supported By",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                      const SizedBox(width: 6),
                      Image.asset("assets/images/poslogo.png",
                          width: 26, height: 26),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== CATEGORY BUTTON =====
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
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
    );
  }

  // ===== PAGE: CONNECTION (Scroll Aktif) =====
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
              borderRadius: BorderRadius.circular(16),
              child: Image.asset('assets/images/katakata.png',
                  height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Text("MailApp.",
                style: GoogleFonts.poppins(
                    color: navy, fontSize: 42, fontWeight: FontWeight.bold)),
            Text("For Couriers",
                style: GoogleFonts.poppins(
                    color: Colors.black54, fontSize: 13, letterSpacing: 2)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // ===== PAGE: STATISTICS =====
  Widget _buildStatisticsPage(Color navy) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delivery Statistics",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, fontSize: 18, color: navy)),
          const SizedBox(height: 16),
          Expanded(
            child: CustomPaint(
              painter: DeliveryCurveChartPainter(),
              child: Container(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("10 Oct",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("11 Oct",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("12 Oct",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("13 Oct",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text("14 Oct",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  // ===== PAGE: SHOP =====
  Widget _buildShopPage(Color navy) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item Section",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700, fontSize: 18, color: navy)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildShopItem("Dokumen", "Rp 250.000", navy),
                _buildShopItem("Paket Elektronik", "Rp 90.000", navy),
                _buildShopItem("Makanan Sehat", "Rp 120.000", navy),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== SHOP ITEM =====
  Widget _buildShopItem(String name, String price, Color navy) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: navy)),
          Text(price,
              style: GoogleFonts.poppins(
                  color: Colors.black54, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  // ===== ICON SOSMED =====
  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}

// ====== CUSTOM CURVE CHART UNTUK STATISTIK ======
class DeliveryCurveChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFF0A1D37)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = const Color(0xFF0A1D37)
      ..style = PaintingStyle.fill;

    // Contoh data jumlah pengiriman per hari
    final List<double> data = [6, 8, 4, 9, 5];
    final double maxY = 10;

    final Path path = Path();
    for (int i = 0; i < data.length; i++) {
      final double x = (i / (data.length - 1)) * size.width;
      final double y = size.height * (1 - (data[i] / maxY));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final double prevX = ((i - 1) / (data.length - 1)) * size.width;
        final double prevY = size.height * (1 - (data[i - 1] / maxY));
        path.quadraticBezierTo((prevX + x) / 2, (prevY + y) / 2, x, y);
      }

      // titik data
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
