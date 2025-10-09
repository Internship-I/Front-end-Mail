import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExclusiveTable extends StatelessWidget {
  final List<Map<String, String>> recipients;
  final Function(String, String, String, String) onWhatsAppPressed;

  const ExclusiveTable({
    super.key,
    required this.recipients,
    required this.onWhatsAppPressed,
  });

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF0B1650);

    return ListView.separated(
      itemCount: recipients.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final data = recipients[index];
        final isDelivered = data["DeliveryStatus"] == "Delivered";

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header: Nama Penerima + Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data["ReceiverName"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: mainColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDelivered
                            ? Colors.green.withOpacity(0.15)
                            : Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDelivered
                              ? Colors.green.shade300
                              : Colors.orange.shade300,
                        ),
                      ),
                      child: Text(
                        data["DeliveryStatus"]!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: isDelivered
                              ? Colors.green.shade800
                              : Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 🔹 Detail Info
                _buildDetailRow(
                    Icons.person_outline, "Sender", data["SenderName"] ?? "-"),
                _buildDetailRow(Icons.confirmation_number_outlined,
                    "Consignment", data["ConsigmentNote"] ?? "-"),
                _buildDetailRow(
                    Icons.phone_android, "Phone", data["PhoneNumber"] ?? "-"),
                _buildDetailRow(Icons.inventory_2_outlined, "Item",
                    data["ItemContent"] ?? "-"),

                const SizedBox(height: 10),
                const Divider(height: 1, color: Colors.black12),
                const SizedBox(height: 10),

                // 🔹 Harga + Tombol WA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF0B1650), Color(0xFF536DFE)],
                      ).createShader(bounds),
                      child: Text(
                        "Rp ${data["Price"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onWhatsAppPressed(
                          data["PhoneNumber"]!,
                          data["ConsigmentNote"]!,
                          data["ReceiverName"]!,
                          data["Price"]!,
                        );
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/walogo.png",
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔸 Baris Detail dengan ikon
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
