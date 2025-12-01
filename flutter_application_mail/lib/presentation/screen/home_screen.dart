import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Pastikan import ini sesuai dengan struktur project Anda
import '../../routes/router.dart';
import '../../shared/widget/botttom_navbar.dart';
import '../../presentation/screen/profile_screen.dart';

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
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Background sedikit abu biar elegan
      body: SafeArea(
        top: false, // Biarkan konten naik ke status bar
        bottom: false,
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

// ==========================================
// ISI HALAMAN HOME (FINAL DESIGN)
// ==========================================
class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

// ==========================================
// ISI HALAMAN HOME (FIXED APPBAR ERROR)
// ==========================================
class _HomePageState extends State<_HomePage> {
  bool _isInfoExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // Gunakan Stack agar AppBar transparan bisa di atas Banner
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. BANNER UTAMA (MENTOK ATAS)
                const _PromoBanner(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // 2. HEADER MENU DASHBOARD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Menu Dashboard",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0B1650),
                                ),
                              ),
                              Text(
                                "Akses cepat pengelolaan",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: const Icon(
                                Icons.dashboard_customize_outlined,
                                size: 18,
                                color: Color(0xFF0B1650)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 3. KARTU DASHBOARD
                      const _QuickAccessList(),

                      const SizedBox(height: 30),

                      // 4. LAYANAN UTAMA
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF4901),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Eksplorasi Layanan",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0B1650),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const _CategoriesSection(),

                      const SizedBox(height: 30),

                      // 5. BANNER IKLAN COMPACT
                      const RoundedBannerCompact(
                        title: "MaillApp Aja! Mobile",
                        subtitle: "Komunikasi makin mudah.",
                        imagePath: "assets/images/logo.png",
                      ),

                      const SizedBox(height: 30),

                      // 6. INFORMASI TERKINI
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Informasi Terkini",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          // Tombol Lihat Semua / Tutup
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isInfoExpanded = !_isInfoExpanded;
                              });
                            },
                            child: Text(
                              _isInfoExpanded ? "Tutup" : "Lihat Semua",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFFF4901),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // --- INFO CARD 1 ---
                      const _InfoCard(
                        title: "Jadwal Operasional Lebaran",
                        desc:
                            "Cek perubahan jam operasional selama libur nasional.",
                        date: "Senin, 20 Nov",
                        icon: Icons.calendar_today_outlined,
                      ),

                      // --- INFO CARD 2 ---
                      const _InfoCard(
                        title: "Tips Packing Aman",
                        desc:
                            "Panduan mengemas barang elektronik agar tidak rusak.",
                        date: "Minggu, 19 Nov",
                        icon: Icons.inventory_2_outlined,
                      ),

                      // --- INFO CARD 3 (Expandable) ---
                      if (_isInfoExpanded)
                        const _InfoCard(
                          title: "Waspada Penipuan",
                          desc:
                              "Hati-hati terhadap pesan palsu mengatasnamakan Pos Indonesia.",
                          date: "Sabtu, 18 Nov",
                          icon: Icons.warning_amber_rounded,
                        ),

                      const SizedBox(height: 40),

                      // 7. FOOTER SUPPORTED BY
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Supported By",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/images/poslogo.png",
                              width: 26,
                              height: 26,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // APP BAR CUSTOM TRANSPARAN (OVERLAY)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// KOMPONEN WIDGETS
// ==========================================

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    // Menghitung tinggi area Status Bar + AppBar untuk batas aman teks
    final double appBarHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    return SizedBox(
      // Gunakan SizedBox atau Container
      width: double.infinity,
      height: 290, // Tinggi banner yang pas (compact)

      child: Stack(
        children: [
          // ==============================================
          // LAYER 1: BACKGROUND GAMBAR & GRADIENT
          // ==============================================
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0B1650),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundmail4.jpg"),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
          ),

          // Gradient Overlay agar teks & logo terbaca jelas
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black
                      .withOpacity(0.4), // Gelap di atas (biar AppBar jelas)
                  Colors.black.withOpacity(0.7), // Gelap di bawah
                ],
              ),
            ),
          ),

          // ==============================================
          // LAYER 2: KONTEN TEKS (NAMA & STATUS)
          // ==============================================
          Padding(
            // 🔥 PENTING: Padding Top disesuaikan agar teks TEPAT di bawah AppBar
            padding: EdgeInsets.only(
                top: appBarHeight + 10, // Turun di bawah AppBar
                left: 24,
                right: 24,
                bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center, // Pusatkan vertikal di sisa ruang
              children: [
                // 1. Badge Status
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified,
                          color: Color.fromARGB(255, 64, 255, 0), size: 14),
                      const SizedBox(width: 6),
                      Text(
                        "Petugas Kurir",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 2. Greeting
                Text(
                  "Selamat Datang,",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                // 3. Nama User
                Flexible(
                  child: Text(
                    "Muhammad\nQinthar",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==============================================
          // LAYER 3: APP BAR CUSTOM (FIX DI ATAS)
          // ==============================================
          // Menggunakan Positioned agar menimpa background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent, // Transparan
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: false, // Pastikan logo rata kiri
              titleSpacing: 24, // Jarak dari pinggir kiri layar

              // --- LOGO (POS & DANANTARA) ---
              title: Row(
                mainAxisSize:
                    MainAxisSize.min, // Agar Row tidak memakan tempat search
                children: [
                  // Logo 1: Pos Indonesia (Pakai Container putih agar lebih pop-up)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/poslogo.png",
                      height: 35, // Ukuran logo
                      width: 35,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Garis Pemisah Tipis
                  Container(height: 24, width: 1, color: Colors.white70),

                  const SizedBox(width: 12),

                  // Logo 2: Danantara
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/danantara.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const SizedBox(width: 28),
                    ),
                  ),
                ],
              ),

              // --- ICON KANAN (SEARCH & NOTIF) ---
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined,
                      color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessList extends StatefulWidget {
  const _QuickAccessList();

  @override
  State<_QuickAccessList> createState() => _QuickAccessListState();
}

class _QuickAccessListState extends State<_QuickAccessList> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    const Color navyBg = Color(0xFF001F3F);
    const Color textWhite = Colors.white;
    const Color textOrange = Color(0xFFFF6600);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: navyBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === HEADER SECTION ===
          Padding(
            // 🔥 UBAH 1: Padding kiri dikurangi (24 -> 20) agar geser ke kiri
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 18,
                      decoration: BoxDecoration(
                        color: textOrange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Akses Cepat",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textWhite,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showAll = !_showAll;
                    });
                  },
                  child: Text(
                    _showAll ? "Tutup" : "Lihat Semua",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: textOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // === LIST HORIZONTAL ===
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),

              // 🔥 UBAH 2: Padding Left dikurangi (24 -> 20)
              // Ini yang membuat kartu mulai lebih awal (geser kiri)
              padding: const EdgeInsets.only(left: 25, right: 20, bottom: 20),

              clipBehavior: Clip.none,
              children: [
                // CARD 1
                _MenuCard(
                  imagePath:
                      "https://plus.unsplash.com/premium_photo-1665203442280-1118daf3de38?q=80&w=1170&auto=format&fit=crop",
                  title: "Data Pengiriman",
                  subtitle: "Kelola Resi",
                  tagLabel: "KURIR",
                  icon: Icons.local_shipping_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.dashboard),
                ),

                const SizedBox(width: 12),

                // CARD 2
                _MenuCard(
                  imagePath:
                      "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?q=80&w=1169&auto=format&fit=crop",
                  title: "Admin Panel",
                  subtitle: "Laporan & User",
                  tagLabel: "ADMIN",
                  icon: Icons.admin_panel_settings_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.adminDashboard),
                ),

                // CARD 3 (Hidden Logic)
                if (_showAll) ...[
                  const SizedBox(width: 12),
                  _MenuCard(
                    imagePath: "assets/images/poslogo.png",
                    title: "Website Resmi",
                    subtitle: "Info Terbaru",
                    tagLabel: "INFO",
                    icon: Icons.language,
                    isAsset: true,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Membuka Website...")),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 3. DESAIN KARTU MENU (COMPACT VERSION)
class _MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String tagLabel;
  final IconData icon;
  final VoidCallback onTap;
  final bool isAsset;

  const _MenuCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.tagLabel,
    required this.icon,
    required this.onTap,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 🔥 PERBAIKAN 2: Lebar dikurangi (160 -> 135) biar lebih ramping
      width: 140,
      margin: const EdgeInsets.only(
          right: 12), // Margin antar kartu dikurangi (16 -> 12)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // Radius dikurangi (20 -> 12)
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B1650).withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0xFFFF4901).withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- BAGIAN GAMBAR ---
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: isAsset
                            ? Container(
                                color: Colors.grey.shade50,
                                padding: const EdgeInsets.all(20),
                                child:
                                    Image.asset(imagePath, fit: BoxFit.contain),
                              )
                            : Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: Colors.grey.shade200),
                              ),
                      ),
                    ),
                    // Tag Label (Compact)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4)
                          ],
                        ),
                        child: Text(
                          tagLabel,
                          style: GoogleFonts.poppins(
                            fontSize: 8, // Font tag dikurangi (9 -> 8)
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFF4901),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- BAGIAN TEKS ---
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(
                      10), // Padding dalam dikurangi (14 -> 10)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 12, // Font judul dikurangi (13 -> 12)
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0B1650),
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 9, // Font sub dikurangi (10 -> 9)
                              color: Colors.grey.shade500,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          icon,
                          size: 16, // Icon dikurangi (18 -> 16)
                          color: const Color(0xFFFF4901).withOpacity(0.5),
                        ),
                      )
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
}

// 4. KATEGORI LAYANAN (MINIMALIST ICON ONLY)
class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {"label": "Pick Up", "image": "assets/images/kurir.jpg"},
      {"label": "Receiver", "image": "assets/images/data_icon.png"},
      {"label": "Tarif", "image": "assets/images/logo.png"},
      {"label": "Bantuan", "image": "assets/images/dashboardicon1.png"},
      {"label": "Lainnya", "image": "assets/images/integrasi.jpg"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: services.map((item) {
          return Column(
            children: [
              Container(
                width: 45,
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(
                      Icons.broken_image_rounded,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item['label'],
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0B1650),
                ),
                textAlign: TextAlign.center,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

// 5. BANNER IKLAN COMPACT
class RoundedBannerCompact extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const RoundedBannerCompact({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0B1650), Color(0xFF2C3E50)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B1650).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -40,
            child: CircleAvatar(
                radius: 50, backgroundColor: Colors.white.withOpacity(0.05)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFF4901),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text("IKLAN",
                            style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 6),
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      Text(subtitle,
                          style: GoogleFonts.poppins(
                              fontSize: 10, color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 6. INFO CARD (COMPACT VERSION)
class _InfoCard extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final IconData icon;

  const _InfoCard({
    super.key, // Tambahkan super.key biar best practice
    required this.title,
    required this.desc,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Jarak antar kartu dikurangi (12 -> 10)
      margin: const EdgeInsets.only(bottom: 10),

      // Padding dalam dikurangi drastis (16 -> 12) agar lebih tipis
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.grey.shade200), // Warna border lebih halus
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03), // Shadow lebih tipis
                blurRadius: 6,
                offset: const Offset(0, 2))
          ]),
      child: Row(
        children: [
          // Bagian Icon Kotak
          Container(
            padding:
                const EdgeInsets.all(8), // Padding icon dikurangi (10 -> 8)
            decoration: BoxDecoration(
              color: const Color(0xFF0B1650).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            // Ukuran icon dikurangi (24 -> 18)
            child: Icon(icon, color: const Color(0xFF0B1650), size: 18),
          ),

          const SizedBox(width: 12), // Jarak icon ke teks dikurangi (16 -> 12)

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 13, // Font dikurangi (14 -> 13)
                        color: const Color(
                            0xFF0B1650))), // Warna biru gelap biar tegas

                const SizedBox(height: 2), // Spasi dikurangi (4 -> 2)

                // Deskripsi
                Text(desc,
                    style: GoogleFonts.poppins(
                        fontSize: 10, // Font dikurangi (11 -> 10)
                        color: Colors.grey.shade600,
                        height: 1.2), // Line height diatur biar rapi
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),

                const SizedBox(height: 4), // Spasi dikurangi (6 -> 4)

                // Tanggal
                Text(date,
                    style: GoogleFonts.poppins(
                        fontSize: 9, // Font dikurangi (10 -> 9)
                        fontWeight: FontWeight.w500,
                        color: const Color(
                            0xFFFF4901))), // Ubah warna jadi Orange Pos biar manis
              ],
            ),
          ),

          // Panah Kanan
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 18),
        ],
      ),
    );
  }
}
