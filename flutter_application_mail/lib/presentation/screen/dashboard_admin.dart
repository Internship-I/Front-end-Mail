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

  final List<double> _chartData = [3, 4.2, 3.5, 5.1, 4.4];

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A2647);
    const Color background = Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- HEADER ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/poslogo.png",
                          width: 48, height: 48),
                      const SizedBox(width: 10),
                      Image.asset("assets/images/danantara.png",
                          width: 48, height: 48),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Muhammad Qinthar",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600)),
                          Text("Admin",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/images/qin.jpg"),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ---------- CARD ATAS ----------
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTopCard(
                      title: "Tambah Penerima",
                      subtitle: "Tambah data",
                      icon: Icons.person_add_alt_1_rounded,
                      color: navy,
                      active: showAddRecipientPanel,
                      onTap: () => setState(
                          () => showAddRecipientPanel = !showAddRecipientPanel),
                    ),
                    const SizedBox(width: 14),
                    _buildTopCard(
                      title: "Daftar Kurir",
                      subtitle: "Lihat detail kurir",
                      icon: Icons.delivery_dining_rounded,
                      color: navy,
                      active: showCouriersPanel,
                      onTap: () => setState(
                          () => showCouriersPanel = !showCouriersPanel),
                    ),
                    const SizedBox(width: 14),
                    _buildTopCard(
                      title: "Grafik",
                      subtitle: "Tren penerima per hari",
                      icon: Icons.bar_chart_rounded,
                      color: navy,
                      active: showChartPanel,
                      onTap: () =>
                          setState(() => showChartPanel = !showChartPanel),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ---------- SUMMARY ----------
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      title: "Total Penerima",
                      value: "1.240",
                      icon: Icons.people_rounded,
                      color: navy,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      title: "Penerima Hari Ini",
                      value: "86",
                      icon: Icons.today_rounded,
                      color: navy,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ---------- PANEL ANIMATED ----------
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
                      _panelContainer(child: const CouriersPanel()),
                      const SizedBox(height: 12),
                    ],
                    if (showChartPanel) ...[
                      // ✅ Ganti ChartPanel jadi AdminGraph
                      _panelContainer(child: const AdminGraph()),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),

              Text("Data Penerima",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600, color: navy)),
              const SizedBox(height: 12),
              const AdminShipmentTable(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- SMALL WIDGETS ----------
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
        width: 240,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? color.withOpacity(0.25) : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: active ? color : color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: active ? Colors.white : color, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87)),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.black54)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black54)),
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
