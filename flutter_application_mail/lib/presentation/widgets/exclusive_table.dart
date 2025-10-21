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
    const accentColor = Color(0xFF1E2A78);
    const bgColor = Color(0xFFF4F6FA);

    return Container(
      color: bgColor,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: recipients.length,
        itemBuilder: (context, index) {
          final data = recipients[index];

          // 🔹 Debug log untuk memastikan data unik
          debugPrint(
              "Row $index ➡ Receiver: ${data["ReceiverName"]}, Phone: ${data["PhoneNumber"]}, Item: ${data["ItemContent"]}, Consignment: ${data["ConsignmentNote"]}");

          final isDelivered = data["DeliveryStatus"] == "Delivered";

          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.98),
                  Colors.white.withOpacity(0.90),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data["ReceiverName"] ?? "-",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: mainColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: isDelivered
                                  ? [
                                      Colors.green.shade100,
                                      Colors.green.shade200
                                    ]
                                  : [
                                      Colors.orange.shade100,
                                      Colors.orange.shade200
                                    ],
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isDelivered
                                    ? Icons.check_circle
                                    : Icons.local_shipping_outlined,
                                size: 16,
                                color: isDelivered
                                    ? Colors.green.shade700
                                    : Colors.orange.shade800,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                data["DeliveryStatus"] ?? "-",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: isDelivered
                                      ? Colors.green.shade800
                                      : Colors.orange.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 18, color: Colors.black54),
                        const SizedBox(width: 6),
                        Text(
                          "Sender: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontSize: 13.5,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data["SenderName"] ?? "-",
                            style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontSize: 13.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Divider(color: Colors.grey.shade300),

                    // 🔸 Detail
                    const SizedBox(height: 8),
                    _buildDetailRow(
                        Icons.confirmation_number_outlined,
                        "Consignment",
                        data["ConsignmentNote"] ?? "-",
                        accentColor),
                    _buildDetailRow(Icons.phone_android, "Phone",
                        data["PhoneNumber"] ?? "-", accentColor),
                    _buildDetailRow(Icons.inventory_2_outlined, "Item",
                        data["ItemContent"] ?? "-", accentColor),

                    const SizedBox(height: 12),
                    Divider(color: Colors.grey.shade300),

                    // 🔹 Harga & Tombol WhatsApp
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF0B1650), Color(0xFF3949AB)],
                          ).createShader(bounds),
                          child: Text(
                            "Rp ${data["Price"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onWhatsAppPressed(
                              data["PhoneNumber"] ?? "",
                              data["ConsignmentNote"] ?? "",
                              data["ReceiverName"] ?? "",
                              data["Price"] ?? "",
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.message,
                                color: Colors.white, size: 26),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 🔸 Detail baris elegan
  Widget _buildDetailRow(
      IconData icon, String label, String value, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: accentColor.withOpacity(0.8)),
          const SizedBox(width: 10),
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
