import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  // Simulasi index tanggal yang dipilih (misal index 0 = hari ini)
  int _selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A1D37);
    const Color softGrey = Color(0xFFF5F7FA);

    return Container(
      // Padding dihilangkan bagian bawah agar list mentok ke bawah (kesan padat)
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================
          // 1. FILTER TANGGAL (POSISI DI ATAS JUDUL)
          // ============================================
          SizedBox(
            height: 60, // Tinggi area tanggal
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 7, // Tampilkan 7 hari
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                // Logika tampilan tanggal (Dummy date generator)
                final dayName = [
                  "Sen",
                  "Sel",
                  "Rab",
                  "Kam",
                  "Jum",
                  "Sab",
                  "Min"
                ];
                final dateNum = [(24 + index).toString(), "Oct"];
                bool isSelected = index == _selectedDateIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      // Warna Navy pekat jika dipilih, abu sangat muda jika tidak
                      color: isSelected ? navy : softGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName[index % 7],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          (24 + index).toString(), // Contoh tanggal
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isSelected ? Colors.white : navy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20), // Jarak pemisah

          // ============================================
          // 2. JUDUL SECTION (ITEM OVERVIEW)
          // ============================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Overview",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: navy,
                ),
              ),
              // Indikator jumlah item hari ini
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD), // Biru sangat muda
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "4 Items",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2)), // Garis pemisah header

          // ============================================
          // 3. LIST ITEM (PADAT SAMPAI BAWAH)
          // ============================================
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  top: 0, bottom: 16), // Padding bawah agar scroll enak
              children: [
                _buildCompactItem(
                    "Dokumen Rahasia", "Rp 250.000", "09:30 AM", navy, true),
                _buildCompactItem(
                    "Paket Elektronik", "Rp 90.000", "10:15 AM", navy, false),
                _buildCompactItem(
                    "Makanan Sehat", "Rp 120.000", "11:00 AM", navy, true),
                _buildCompactItem(
                    "Buku & Arsip", "Rp 45.000", "13:45 PM", navy, false),
                _buildCompactItem(
                    "Aksesoris Motor", "Rp 75.000", "14:20 PM", navy, false),
                _buildCompactItem(
                    "Surat Dinas", "Rp 15.000", "15:00 PM", navy, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactItem(
      String name, String price, String time, Color navy, bool isPriority) {
    return Container(
      // Desain "List Tile" yang rapat tanpa margin besar
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        // Garis pemisah halus di bawah setiap item
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          // 1. Status Indicator Bar (Garis tegak di kiri)
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: isPriority ? const Color(0xFFFF9800) : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Icon (Simple & Clean)
          Icon(
            isPriority ? Icons.star_rounded : Icons.inventory_2_outlined,
            color: isPriority ? const Color(0xFFFF9800) : Colors.grey[400],
            size: 20,
          ),
          const SizedBox(width: 12),

          // 3. Info Item
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: navy,
                  ),
                ),
                Text(
                  time, // Menampilkan JAM bukan tanggal (karena filter tanggal sudah di atas)
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // 4. Harga
          Text(
            price,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }
}
