import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/AdminDashboard/index_admin_dashboard.dart';

class AdminDashboardApp extends StatefulWidget {
  const AdminDashboardApp({super.key});

  @override
  State<AdminDashboardApp> createState() => _AdminDashboardAppState();
}

class _AdminDashboardAppState extends State<AdminDashboardApp>
    with TickerProviderStateMixin {
  bool showCouriersPanel = false;
  bool showChartPanel = false;
  bool showAddRecipientPanel = false;

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A2647);
    const Color background = Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          // 🔥 COMPACT: Padding luar dikurangi (20/18 -> 16/12)
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===============================================
              // 1. HEADER COMPACT
              // ===============================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LOGO KIRI

                  Row(
                    children: [
                      Image.asset(
                        "assets/images/poslogo.png",
                        height: 28, // 🔥 COMPACT: 32 -> 28
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          height: 20, width: 1, color: Colors.grey.shade300),
                      const SizedBox(width: 10),
                      Image.asset(
                        "assets/images/danantara.png",
                        height: 24, // 🔥 COMPACT: 28 -> 24
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const SizedBox(),
                      ),
                    ],
                  ),

                  // PROFIL KANAN
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Muhammad Qinthar",
                              style: GoogleFonts.poppins(
                                  fontSize: 13, // 🔥 COMPACT: 15 -> 13
                                  color: const Color(0xFF0B1650),
                                  fontWeight: FontWeight.w600)),
                          Text("Admin",
                              style: GoogleFonts.poppins(
                                  fontSize: 10, // 🔥 COMPACT: 12 -> 10
                                  color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 38, // 🔥 COMPACT: Radius 22 (dia 44) -> 38
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade200),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/qin.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12), // Jarak dikurangi (18 -> 12)

              // ===============================================
              // 2. CARD ATAS (MENU) COMPACT
              // ===============================================
              SizedBox(
                height: 85, // 🔥 COMPACT: Tinggi List 120 -> 85
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _buildTopCard(
                      title: "Tambah Penerima",
                      subtitle: "Input Data",
                      icon: Icons.person_add_alt_1_rounded,
                      color: navy,
                      active: showAddRecipientPanel,
                      onTap: () => setState(
                          () => showAddRecipientPanel = !showAddRecipientPanel),
                    ),
                    const SizedBox(width: 10), // Jarak antar kartu dikurangi
                    _buildTopCard(
                      title: "Daftar Kurir",
                      subtitle: "Detail Kurir",
                      icon: Icons.delivery_dining_rounded,
                      color: navy,
                      active: showCouriersPanel,
                      onTap: () => setState(
                          () => showCouriersPanel = !showCouriersPanel),
                    ),
                    const SizedBox(width: 10),
                    _buildTopCard(
                      title: "Grafik",
                      subtitle: "Analitik Data",
                      icon: Icons.bar_chart_rounded,
                      color: navy,
                      active: showChartPanel,
                      onTap: () =>
                          setState(() => showChartPanel = !showChartPanel),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===============================================
              // 3. SUMMARY SECTION
              // ===============================================
              const AdminSummary(), // Nanti file ini juga harus dikecilkan
              const SizedBox(height: 12),

              // ===============================================
              // 4. PANEL ANIMATED (ISI KONTEN)
              // ===============================================
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    if (showAddRecipientPanel) ...[
                      _panelContainer(child: const AdminAddForm()),
                      const SizedBox(height: 12),
                    ],
                    if (showCouriersPanel) ...[
                      _panelContainer(
                          child: const CouriersPanel(
                        couriers: [],
                      )),
                      const SizedBox(height: 12),
                    ],
                    if (showChartPanel) ...[
                      _panelContainer(child: const AdminGraph()),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),

              // ===============================================
              // 5. TABLE HEADER & TABLE
              // ===============================================
              Text("Data Penerima",
                  style: GoogleFonts.poppins(
                      fontSize: 16, // 🔥 COMPACT: 18 -> 16
                      fontWeight: FontWeight.w600,
                      color: navy)),
              const SizedBox(height: 8),
              const AdminShipmentTable(), // File tabel ini nanti dikecilkan
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- SMALL WIDGETS (COMPACT) ----------
  Widget _buildTopCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        width: 170, // 🔥 COMPACT: Lebar 240 -> 170
        padding: const EdgeInsets.all(10), // 🔥 COMPACT: Padding 14 -> 10
        decoration: BoxDecoration(
            color: active ? color.withOpacity(0.12) : Colors.white,
            borderRadius: BorderRadius.circular(12), // Radius 16 -> 12
            border: Border.all(
              color: active ? color.withOpacity(0.25) : Colors.grey.shade200,
            ),
            boxShadow: [
              if (!active)
                BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, 2))
            ]),
        child: Row(
          children: [
            Container(
              width: 40, // 🔥 COMPACT: Box Icon 54 -> 40
              height: 40,
              decoration: BoxDecoration(
                color: active ? color : color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  color: active ? Colors.white : color,
                  size: 20), // Icon 28 -> 20
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12, // 🔥 COMPACT: 15 -> 12
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1650))),
                  Text(subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 10, // 🔥 COMPACT: 12 -> 10
                          color: Colors.grey.shade600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _panelContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
          12), // Tetap 12 tapi konten di dalamnya nanti dikecilkan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Radius 14 -> 12
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // Shadow lebih tipis
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
