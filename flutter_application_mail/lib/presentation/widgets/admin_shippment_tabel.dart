import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../module/AdminDashboard/model/response/admin_model_response.dart';
import '../../module/AdminDashboard/controller/admin_controller.dart';
import 'package:provider/provider.dart';

class AdminShipmentTable extends StatefulWidget {
  const AdminShipmentTable({super.key});

  @override
  State<AdminShipmentTable> createState() => _AdminShipmentTableState();
}

class _AdminShipmentTableState extends State<AdminShipmentTable> {
  DateTime? selectedDate;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AdminController>(context, listen: false)
          .fetchAllTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A2647);

    final controller = Provider.of<AdminController>(context);
    final List<Transaction> shipments = controller.transactions;

    // ==================== FILTERING DATA ====================
    final filteredShipments = shipments.where((s) {
      final date = DateTime.tryParse(s.createdAt);

      final matchDate = selectedDate == null
          ? true
          : (date != null &&
              date.year == selectedDate!.year &&
              date.month == selectedDate!.month &&
              date.day == selectedDate!.day);

      final q = searchQuery.toLowerCase();
      final matchSearch = s.consignmentNote.toLowerCase().contains(q) ||
          s.receiverName.toLowerCase().contains(q) ||
          s.senderName.toLowerCase().contains(q);

      return matchDate && matchSearch;
    }).toList();

    return SingleChildScrollView(
      // Padding vertikal dikurangi (10 -> 5)
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== FILTER HEADER ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter Tanggal:",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: navy,
                    fontSize: 12, // Font dikurangi (14 -> 12)
                  ),
                ),
                SizedBox(
                  height: 32, // Tinggi tombol dikurangi
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2026),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    icon: const Icon(Icons.date_range_rounded,
                        size: 14), // Icon kecil
                    label: Text(
                      selectedDate == null
                          ? "Pilih Tanggal"
                          : DateFormat("dd MMM yyyy").format(selectedDate!),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 11), // Font kecil
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8), // Jarak dikurangi

          // ==================== SEARCH BAR COMPACT ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38, // Tinggi search bar dikurangi
                    child: TextField(
                      onChanged: (v) => setState(() => searchQuery = v),
                      decoration: InputDecoration(
                        hintText: "Cari resi / pengirim / penerima...",
                        prefixIcon:
                            const Icon(Icons.search, size: 18), // Icon kecil
                        hintStyle: GoogleFonts.poppins(fontSize: 11),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero, // Hapus padding dalam
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ),
                if (selectedDate != null || searchQuery.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 38,
                    child: TextButton(
                      onPressed: () => setState(() {
                        selectedDate = null;
                        searchQuery = "";
                      }),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: navy,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ==================== LIST TRANSAKSI ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16), // Radius dikurangi (20 -> 16)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: controller.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : filteredShipments.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              "Tidak ada data pengiriman.",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12), // Padding list dikurangi
                          itemCount: filteredShipments.length,
                          separatorBuilder: (_, __) => Divider(
                            color: Colors.grey.shade300,
                            thickness: 0.5,
                            height: 12, // Jarak antar item dipersempit
                          ),
                          itemBuilder: (_, i) =>
                              _shipmentCard(filteredShipments[i]),
                        ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // 🔹 CARD ITEM (FORMAT SAMA, UKURAN LEBIH KECIL)
  // ============================================================
  Widget _shipmentCard(Transaction t) {
    const Color navy = Color(0xFF0A2647);
    final bool isCOD = t.codValue > 0;

    return Stack(
      children: [
        Container(
          // Padding & Margin dikurangi
          padding: const EdgeInsets.symmetric(vertical: 4),
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== ICON MOTOR (KECIL) =====
              Container(
                width: 38, // 46 -> 38
                height: 38,
                decoration: BoxDecoration(
                  color: navy.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.two_wheeler_rounded,
                    color: navy, size: 20), // Icon 24 -> 20
              ),
              const SizedBox(width: 10), // Spacing 14 -> 10

              // ===== DETAIL DATA =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // RESI
                    Text(
                      t.consignmentNote,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13, // 15 -> 13
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // PENGIRIM -> PENERIMA
                    Text(
                      "Dari: ${t.senderName} → Kepada: ${t.receiverName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 11), // 13 -> 11
                    ),
                    const SizedBox(height: 2),

                    // LAYANAN
                    Text(
                      "Layanan: ${t.serviceType}",
                      style: GoogleFonts.poppins(
                        fontSize: 10, // 12 -> 10
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 1),

                    // HARGA
                    Text(
                      "Rp ${NumberFormat('#,###').format(t.codValue)}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: navy,
                        fontSize: 12, // 13.5 -> 12
                      ),
                    ),
                    const SizedBox(height: 4),

                    // 🔥 PERBAIKAN: GANTI CHECKBOX DENGAN ICON TOMBOL
                    Row(
                      children: [
                        // 1. Tombol WhatsApp
                        _actionIcon(
                            icon: Icons.chat_bubble_rounded, // Icon mirip WA
                            color: Colors.green,
                            isActive:
                                false, // Ganti dengan logika variable WA kamu
                            onTap: () {
                              // Logika buka WA
                              print("Buka WA");
                            }),

                        const SizedBox(width: 8),

                        // 2. Tombol Ceklis (Delivered)
                        _actionIcon(
                            icon: Icons.check_circle_rounded,
                            color: navy,
                            isActive:
                                false, // Ganti dengan logika variable Delivered kamu
                            onTap: () {
                              // Logika ubah status
                              print("Ubah status delivered");
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // ===== LABEL COD / NON COD (POSISI TETAP) =====
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isCOD ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              isCOD ? "COD" : "Bayar di Tempat",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 9, // Font dikurangi (11 -> 9)
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Checkbox Compact
  Widget _statusCheck(String label, bool value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 18, // Ukuran checkbox dipaksa kecil
          height: 18,
          child: Checkbox(
            value: value,
            onChanged: null,
            activeColor: const Color(0xFF0A2647),
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, // Hilangkan padding bawaan
            side: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 10), // Font 11.5 -> 10
        ),
      ],
    );
  }
}

// ============================================================
// 🔹 HELPER: TOMBOL ICON KECIL
// ============================================================
Widget _actionIcon({
  required IconData icon,
  required Color color,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: 28, // Ukuran tombol (compact)
      height: 28,
      decoration: BoxDecoration(
        // Jika aktif: Background warna muda. Jika tidak: Abu sangat muda
        color: isActive ? color.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          // Jika aktif: Border warna. Jika tidak: Border abu
          color: isActive ? color.withOpacity(0.3) : Colors.grey.shade300,
          width: 0.5,
        ),
      ),
      child: Icon(
        icon,
        // Jika aktif: Warna asli. Jika tidak: Abu-abu
        color: isActive ? color : Colors.grey.shade400,
        size: 16, // Ukuran icon
      ),
    ),
  );
}
