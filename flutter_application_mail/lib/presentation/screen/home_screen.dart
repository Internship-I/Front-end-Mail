import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widget/botttom_navbar.dart';
import '../../presentation/screen/profile_screen.dart';
import '../widgets/featured_section.dart';
import '../widgets/logo_section.dart';
// import '../components/buttons/whatsapp_button.dart';
// import '../components/buttons/notification.dart';
import '../widgets/notification_panel.dart';
import '../screen/dashboard.dart'; // halaman tujuan setelah klik notifikasi

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomePage(),
    const ProfileScreenNew(),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isTablet = screen.width > 600;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 600 : double.infinity,
            ),
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  bool _showNotifications = false;

  final List<String> _notifications = [
    "Ada penerima baru atas nama Muhammad Kibo",
    "Ada penerima baru atas nama Rina Dewi",
    "Ada penerima baru atas nama Agus Santoso",
  ];

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  void _openPenerimaDetail(String nama) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CourierDashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isTablet = screen.width > 600;

    return Stack(
      children: [
        // === 🔶 GRADIENT ORANYE FULL SAMPAI ATAS ===
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255), // oranye lembut di atas
                Color.fromARGB(255, 255, 255, 255), // oranye tua di bawah
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // === 🔹 KONTEN UTAMA ===
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 30 : 0),
            child: Column(
              children: [
                // === BAGIAN ATAS DENGAN GAMBAR ===
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/backgroundmail4.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SizedBox(height: isTablet ? 360 : 345),
                    ),

                    // === ISI DALAM BACKGROUND ===
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 30 : 20,
                        vertical: isTablet ? 20 : 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // === SEARCH BAR ===
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: isTablet ? 50 : 45,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search,
                                    color: Colors.white70, size: 22),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.tune,
                                    color: Colors.white70, size: 22),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // === TEKS HALO ===
                          Stack(
                            children: [
                              Text(
                                "Halo!",
                                style: GoogleFonts.poppins(
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.w700,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(
                                "Halo!",
                                style: GoogleFonts.poppins(
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Stack(
                            children: [
                              Text(
                                "Sahabat Pos",
                                style: GoogleFonts.poppins(
                                  fontSize: isTablet ? 22 : 18,
                                  fontWeight: FontWeight.w700,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(
                                "Sahabat Pos",
                                style: GoogleFonts.poppins(
                                  fontSize: isTablet ? 22 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // === PROMO CARD ===
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isTablet ? 18 : 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PT POS INDONESIA",
                                        style: GoogleFonts.poppins(
                                          fontSize: isTablet ? 16 : 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0B1650),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Serve with heart.",
                                        style: GoogleFonts.poppins(
                                          fontSize: isTablet ? 12 : 11,
                                          color: Colors.black.withOpacity(0.65),
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF0B1650),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: Text(
                                          "Visit Now",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: isTablet ? 13 : 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  "assets/images/poslogo.png",
                                  width: isTablet ? 90 : 75,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const FeaturedSection(),
                const SizedBox(height: 24),
                const RoundedBanner(
                  title: "Aplikasi Untuk Kurir Pengiriman Paket",
                  subtitle: "Safe and reliable service.",
                  imagePath: "assets/images/logo.png",
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        // === PANEL NOTIFIKASI ===
        if (_showNotifications)
          NotificationPanel(
            notifications: _notifications,
            onTapNotification: _openPenerimaDetail,
            onClose: _toggleNotifications,
          ),
      ],
    );
  }
}

// === ROUNDED BANNER ===
class RoundedBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const RoundedBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isTablet = screen.width > 600;

    return Center(
      child: Container(
        width: screen.width * (isTablet ? 0.8 : 0.9),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 22 : 16,
          vertical: isTablet ? 20 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: isTablet ? 65 : 55,
                  height: isTablet ? 65 : 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0B1650), Color(0xFF3949AB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 15 : 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1650),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 13 : 12,
                          color: Colors.black.withOpacity(0.65),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 73, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "IKLAN",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
