import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A1D37);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE =====
          Text(
            "Item Overview",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: navy,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Courier item records by date",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // ===== LIST ITEM =====
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildItemCard(
                    "Dokumen Rahasia", "Rp 250.000", "14 Oct 2025", navy),
                _buildItemCard(
                    "Paket Elektronik", "Rp 90.000", "13 Oct 2025", navy),
                _buildItemCard(
                    "Makanan Sehat", "Rp 120.000", "12 Oct 2025", navy),
                _buildItemCard(
                    "Buku & Arsip", "Rp 45.000", "11 Oct 2025", navy),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(String name, String price, String date, Color navy) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: navy.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: navy.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ===== ICON + TEXT =====
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: navy.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.inventory_2_rounded,
                        color: Color(0xFF0A1D37), size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
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
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // ===== DATE =====
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: navy.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date,
                  style: GoogleFonts.poppins(
                    color: navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
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
