import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A1D37);
    const Color accent = Color(0xFF1E3A8A); // biru gelap profesional
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === HEADER ===
          Text(
            "Delivery Overview",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.045,
              color: navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Your recent courier performance",
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.032,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // === LIST DATA ===
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildStatCard(context, "14 Oct 2025", "4 Deliveries", navy,
                    accent, screenWidth),
                _buildStatCard(context, "13 Oct 2025", "3 Deliveries", navy,
                    accent, screenWidth),
                _buildStatCard(context, "12 Oct 2025", "6 Deliveries", navy,
                    accent, screenWidth),
                _buildStatCard(context, "11 Oct 2025", "2 Deliveries", navy,
                    accent, screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String date, String info,
      Color navy, Color accent, double screenWidth) {
    return GestureDetector(
      onTap: () => _showTransactionDetail(context, date, navy, accent),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.036,
                    color: navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  info,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.031,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Colors.black38, size: 22),
          ],
        ),
      ),
    );
  }

  // === DETAIL TRANSAKSI ===
  void _showTransactionDetail(
      BuildContext context, String date, Color navy, Color accent) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions - $date",
                        style: GoogleFonts.poppins(
                          color: navy,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.receipt_long_rounded, color: accent, size: 24),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Shipment details list",
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
        );
      },
    );
  }

  Widget _buildTransactionCard({
    required String name,
    required String item,
    required String price,
    required String resi,
    required Color navy,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.black45, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: navy,
                  ),
                ),
                Text(
                  item,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Resi: $resi",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: navy,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
