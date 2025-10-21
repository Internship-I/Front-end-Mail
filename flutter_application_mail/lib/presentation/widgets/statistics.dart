import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A1D37);
    const Color softNavy = Color(0xFF102A54);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFF9FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE =====
          Text(
            "Delivery Statistics",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: navy,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Daily performance overview",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 18),

          // ===== LIST =====
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildStatRow(context, "14 Oct 2025", 24, 2, 1, navy),
                _buildStatRow(context, "13 Oct 2025", 19, 1, 0, navy),
                _buildStatRow(context, "12 Oct 2025", 22, 3, 1, navy),
                _buildStatRow(context, "11 Oct 2025", 18, 2, 0, navy),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== ROW SETIAP TANGGAL =====
  Widget _buildStatRow(BuildContext context, String date, int success,
      int pending, int failed, Color navy) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showTransactionDetail(context, date, navy),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: navy.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: navy.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Tanggal
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: navy.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // Tag status
            Row(
              children: [
                _buildSmallTag("✅ $success", Colors.green[700]!),
                const SizedBox(width: 6),
                _buildSmallTag("⏳ $pending", Colors.amber[800]!),
                const SizedBox(width: 6),
                _buildSmallTag("❌ $failed", Colors.red[700]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===== SMALL TAG =====
  Widget _buildSmallTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===== DETAIL TRANSAKSI (BOTTOM SHEET) =====
  void _showTransactionDetail(BuildContext context, String date, Color navy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (_, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Color(0xFFF3F5F8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Text(
                      "📅 Transaksi - $date",
                      style: GoogleFonts.poppins(
                        color: navy,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Detail pengiriman & penerimaan hari ini",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildTransactionCard(
                            name: "Nida Sakinah",
                            item: "Dokumen Cepat",
                            price: "Rp 35.000",
                            resi: "POS123456789",
                            navy: navy,
                          ),
                          _buildTransactionCard(
                            name: "Rizky Aditya",
                            item: "Paket Elektronik",
                            price: "Rp 90.000",
                            resi: "POS987654321",
                            navy: navy,
                          ),
                          _buildTransactionCard(
                            name: "Sarah Putri",
                            item: "Fashion & Aksesoris",
                            price: "Rp 125.000",
                            resi: "POS555333222",
                            navy: navy,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ===== KARTU DETAIL =====
  Widget _buildTransactionCard({
    required String name,
    required String item,
    required String price,
    required String resi,
    required Color navy,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: navy.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: navy.withOpacity(0.08),
            child: const Icon(Icons.person_rounded, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: navy)),
                Text(item,
                    style: GoogleFonts.poppins(
                        color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 6),
                Text("Resi: $resi",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[600], fontSize: 11)),
              ],
            ),
          ),
          Text(price,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: navy,
                  fontSize: 13,
                  letterSpacing: 0.2)),
        ],
      ),
    );
  }
}
