import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminShipmentTable extends StatefulWidget {
  const AdminShipmentTable({super.key});

  @override
  State<AdminShipmentTable> createState() => _AdminShipmentTableState();
}

class _AdminShipmentTableState extends State<AdminShipmentTable> {
  DateTime? selectedDate;
  String searchQuery = "";

  final List<Map<String, dynamic>> shipments = [
    {
      "resi": "P301025930715",
      "sender": "Nida Sakina",
      "receiver": "Qinthar",
      "address": "Jl. Sariasih No.12, Bandung",
      "service": "Express",
      "cod": "109.000",
      "courier": "Firgi",
      "wa_on_delivery_sent": true,
      "wa_delivered_sent": false,
      "date": DateTime(2025, 11, 10),
    },
    {
      "resi": "P301025930716",
      "sender": "Hafiz",
      "receiver": "Rina",
      "address": "Jl. Setiabudi No.88, Bandung",
      "service": "Reguler",
      "cod": "56.000",
      "courier": "Dika",
      "wa_on_delivery_sent": false,
      "wa_delivered_sent": false,
      "date": DateTime(2025, 11, 9),
    },
    {
      "resi": "P301025930717",
      "sender": "Lina",
      "receiver": "Andi",
      "address": "Jl. Sukajadi No.5, Bandung",
      "service": "Express",
      "cod": "75.000",
      "courier": "Rafi",
      "wa_on_delivery_sent": true,
      "wa_delivered_sent": true,
      "date": DateTime(2025, 11, 8),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A2647);

    // ==================== FILTERING DATA ====================
    final filteredShipments = shipments.where((s) {
      final matchDate = selectedDate == null
          ? true
          : s["date"].year == selectedDate!.year &&
              s["date"].month == selectedDate!.month &&
              s["date"].day == selectedDate!.day;

      final query = searchQuery.toLowerCase();
      final matchSearch = s["resi"].toLowerCase().contains(query) ||
          s["courier"].toLowerCase().contains(query) ||
          s["receiver"].toLowerCase().contains(query);

      return matchDate && matchSearch;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== FILTER & SEARCH BAR ====================
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
                    fontSize: 14,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime(2026, 12, 31),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  icon: const Icon(Icons.date_range_rounded, size: 18),
                  label: Text(
                    selectedDate == null
                        ? "Pilih Tanggal"
                        : DateFormat("dd MMM yyyy").format(selectedDate!),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // ==================== SEARCH BAR & RESET BUTTON ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      setState(() => searchQuery = val);
                    },
                    decoration: InputDecoration(
                      hintText: "Cari resi / kurir / penerima...",
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: GoogleFonts.poppins(fontSize: 13),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = null;
                      searchQuery = "";
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: navy,
                    textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  child: const Text("Lihat Semua"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ==================== DAFTAR PENGIRIMAN ====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: filteredShipments.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Tidak ada data pengiriman yang cocok.",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredShipments.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                        thickness: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final s = filteredShipments[index];
                        return _shipmentCard(s);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _shipmentCard(Map<String, dynamic> s) {
    const Color navy = Color(0xFF0A2647);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======= ICON MOTOR =======
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: navy.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.two_wheeler_rounded, color: navy, size: 24),
          ),
          const SizedBox(width: 14),

          // ======= DETAIL DATA =======
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s["resi"],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: navy,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Dari: ${s["sender"]} → Kepada: ${s["receiver"]}",
                  style: GoogleFonts.poppins(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  s["address"],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Layanan: ${s["service"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "Rp ${s["cod"]}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: navy,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // STATUS DIBUAT VERTIKAL AGAR TIDAK OVERFLOW
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kurir: ${s["courier"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _statusCheck("WA On Delivery", s["wa_on_delivery_sent"]),
                    _statusCheck("Delivered", s["wa_delivered_sent"]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCheck(String label, bool value) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: null,
          activeColor: const Color(0xFF0A2647),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
