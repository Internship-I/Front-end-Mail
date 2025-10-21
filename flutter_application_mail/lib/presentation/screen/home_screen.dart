import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/widget/botttom_navbar.dart';
import '../../presentation/screen/profile_screen.dart';
import '../widgets/featured_section.dart';
import '../widgets/logo_section.dart';
import '../components/buttons/whatsapp_button.dart';
import '../components/buttons/notification.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
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
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // === BAGIAN ATAS DENGAN BG NAVY ===
              Stack(
                children: [
                  // === BACKGROUND GRADIENT NAVY ===
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 6, 13, 91),
                          Color.fromARGB(255, 6, 13, 91),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const SizedBox(height: 400),
                  ),

                  // // === HIASAN LINGKARAN ELEGAN ===
                  // Positioned(
                  //   top: -40,
                  //   left: -40,
                  //   child: Container(
                  //     width: 245,
                  //     height: 140,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           const Color.fromARGB(255, 255, 255, 255),
                  //           const Color.fromARGB(255, 255, 255, 255),
                  //         ],
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.blue.withOpacity(0.15),
                  //           blurRadius: 25,
                  //           spreadRadius: 5,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // Positioned(
                  //   bottom: 60,
                  //   right: -40,
                  //   child: Container(
                  //     width: 140,
                  //     height: 140,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           const Color.fromARGB(255, 255, 255, 255),
                  //           const Color.fromARGB(255, 255, 255, 255),
                  //         ],
                  //         begin: Alignment.bottomRight,
                  //         end: Alignment.topLeft,
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.blueAccent.withOpacity(0.1),
                  //           blurRadius: 20,
                  //           offset: const Offset(0, 4),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // Positioned(
                  //   top: 120,
                  //   right: 40,
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(
                  //         color: const Color.fromARGB(255, 255, 255, 255)
                  //             .withOpacity(0.25),
                  //         width: 3,
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: const Color.fromARGB(255, 255, 255, 255)
                  //               .withOpacity(0.1),
                  //           blurRadius: 10,
                  //           offset: const Offset(2, 2),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // === KONTEN DI ATAS BACKGROUND ===
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // === BAR ATAS (LOGO + ICON) ===
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const LogoSection(),
                            NotificationIcon(onTap: _toggleNotifications),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // === SEARCH BAR ===
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search,
                                  color: Colors.white70, size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    hintStyle: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 13,
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

                        Text(
                          "Hola! 👋",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          "Sahabat Pos",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // === PROMO CARD ===
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 255, 255, 255), // biru muda
                                Colors.white, // putih
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PT POS INDONESIA",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0B1650),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Serve with heart.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.65),
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF0B1650),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 10),
                                      ),
                                      child: Text(
                                        "Visit Now",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                "assets/images/poslogo.png",
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // === BAGIAN PUTIH DI BAWAH ===
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

        // === NOTIFICATION PANEL DIPISAH KE FILE ===
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

// 🔹 ROUNDED BANNER
//
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
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Logo elegan
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B1650), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Teks elegan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1650),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.65),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Label “IKLAN”
        Positioned(
          right: 24,
          top: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF00AEEF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "IKLAN",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
