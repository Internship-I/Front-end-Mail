import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExclusiveTable extends StatefulWidget {
  final List<Map<String, String>> recipients;
  final Function(String, String, String, String) onWhatsAppPressed;

  const ExclusiveTable({
    super.key,
    required this.recipients,
    required this.onWhatsAppPressed,
  });

  @override
  State<ExclusiveTable> createState() => _ExclusiveTableState();
}

class _ExclusiveTableState extends State<ExclusiveTable> {
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF0B1650);
    const accentColor = Color(0xFF3A4EB7);
    const bgColor = Color(0xFFF5F6FA);

    // 🔹 Kelompokkan data berdasarkan tanggal
    final Map<String, List<Map<String, String>>> groupedByDate = {};
    for (var item in widget.recipients) {
      final date = item["CreatedAt"] ?? "Unknown";
      groupedByDate.putIfAbsent(date, () => []).add(item);
    }

    final sortedDates = groupedByDate.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    final displayedDates = selectedDate == null
        ? sortedDates
        : sortedDates.where((d) => d == selectedDate).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔸 Header dan filter tanggal
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daftar Pengiriman",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: mainColor,
                ),
              ),
              const Icon(Icons.delivery_dining_rounded, color: accentColor),
            ],
          ),
        ),

        // 🔸 Scroll tanggal
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                for (var date in sortedDates)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: selectedDate == date
                              ? Colors.white
                              : mainColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      selected: selectedDate == date,
                      selectedColor: accentColor,
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          selectedDate = selected ? date : null;
                        });
                      },
                    ),
                  ),
                if (selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedDate = null;
                        });
                      },
                      icon: const Icon(Icons.close_rounded,
                          color: Colors.redAccent, size: 18),
                      label: Text(
                        "Semua",
                        style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // 🔹 Daftar data transaksi
        Expanded(
          child: Container(
            color: bgColor,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: displayedDates.length,
              itemBuilder: (context, index) {
                final date = displayedDates[index];
                final items = groupedByDate[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      child: Text(
                        "Tanggal: $date",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: mainColor,
                        ),
                      ),
                    ),
                    for (var data in items)
                      _buildDeliveryCard(data, mainColor, accentColor),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryCard(
      Map<String, String> data, Color mainColor, Color accentColor) {
    final codValue = data["CODValue"] ?? "0";
    final isCOD = codValue != "0";

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔸 Header nama penerima
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data["ReceiverName"] ?? "-",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: mainColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: isCOD ? Colors.green.shade50 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isCOD ? "COD" : "Non COD",
                  style: GoogleFonts.poppins(
                    color: isCOD ? Colors.green.shade700 : Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 🔸 Detail pengiriman
          _buildDetailRow(Icons.location_on_rounded, "Alamat",
              data["AddressReceiver"] ?? "-", accentColor),
          _buildDetailRow(Icons.inventory_2_rounded, "Isi Barang",
              data["ItemContent"] ?? "-", accentColor),
          _buildDetailRow(Icons.delivery_dining_rounded, "Layanan",
              data["ServiceType"] ?? "-", accentColor),
          _buildDetailRow(Icons.person_outline_rounded, "Pengirim",
              "${data["SenderName"]} (${data["SenderPhone"]})", accentColor),

          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade300),

          // 🔸 Bagian bawah (total & tombol WhatsApp)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCOD
                    ? "Total COD: Rp ${codValue}"
                    : "Tidak ada pembayaran (Non COD)",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                  fontSize: 13.5,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onWhatsAppPressed(
                    data["ReceiverPhone"] ?? "",
                    data["ConsignmentNote"] ?? "",
                    data["ReceiverName"] ?? "",
                    codValue,
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF25D366),
                        Color(0xFF128C7E),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.chat_rounded,
                      color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: accentColor.withOpacity(0.85)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$label: ",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 13.5,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
