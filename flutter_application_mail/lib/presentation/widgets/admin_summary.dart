import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module/AdminDashboard/service/admin_service.dart';
import '../../module/AdminDashboard/model/response/admin_model_response.dart';

const Color navy = Color(0xFF001F3F);
const Color softNavy = Color(0xFF0A2E5C);
const Color proGreen = Color(0xFF00C853);
const Color softGreen = Color(0xFFE8F5E9);

// 1. Ubah menjadi StatefulWidget
class AdminSummary extends StatefulWidget {
  const AdminSummary({super.key});

  @override
  State<AdminSummary> createState() => _AdminSummaryState();
}

class _AdminSummaryState extends State<AdminSummary> {
  // 2. Buat variabel untuk menampung Future
  late Future<List<Transaction>> _transactionFuture;

  @override
  void initState() {
    super.initState();
    // 3. Panggil API hanya SEKALI di sini
    _transactionFuture = AdminService().getAllTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: _transactionFuture, // 4. Gunakan variabel, bukan fungsi langsung
      builder: (context, snapshot) {
        final loading = snapshot.connectionState == ConnectionState.waiting;

        if (loading) {
          return _loadingLayout();
        }

        if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Gagal memuat data",
              style: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
            ),
          );
        }

        final data = snapshot.data ?? [];
        final totalPenerima = data.length;

        // === LOGIKA PERHITUNGAN ===
        final today = DateTime.now();
        final yesterday = today.subtract(const Duration(days: 1));

        final penerimaHariIni = data.where((t) {
          try {
            final d = DateTime.parse(t.createdAt);
            return d.year == today.year &&
                d.month == today.month &&
                d.day == today.day;
          } catch (_) {
            return false;
          }
        }).length;

        final penerimaKemarin = data.where((t) {
          try {
            final d = DateTime.parse(t.createdAt);
            return d.year == yesterday.year &&
                d.month == yesterday.month &&
                d.day == yesterday.day;
          } catch (_) {
            return false;
          }
        }).length;

        final bool isTrenNaik = penerimaHariIni > penerimaKemarin;

        return Row(
          children: [
            Expanded(
              child: _summaryCard(
                title: "Total Penerima",
                value: totalPenerima.toString(),
                icon: Icons.people_alt_rounded,
                showArrow: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _summaryCard(
                title: "Hari Ini",
                value: penerimaHariIni.toString(),
                icon: Icons.today_rounded,
                showArrow: isTrenNaik,
              ),
            ),
          ],
        );
      },
    );
  }

  // ... (Fungsi _summaryCard, _loadingLayout, dll biarkan tetap sama seperti sebelumnya)
  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required bool showArrow,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: navy.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: navy, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: navy,
                        height: 1.0,
                      ),
                    ),
                    if (showArrow) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: softGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.trending_up_rounded,
                          color: proGreen,
                          size: 12,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingLayout() {
    return Row(
      children: [
        Expanded(
          child: _loadingCard(
              title: "Total Penerima", icon: Icons.people_alt_rounded),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _loadingCard(title: "Hari Ini", icon: Icons.today_rounded),
        ),
      ],
    );
  }

  Widget _loadingCard({required String title, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: navy.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: navy, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 4),
                _loadingDots(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingDots() {
    return Row(
      children: List.generate(
        3,
        (i) => Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: navy.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
