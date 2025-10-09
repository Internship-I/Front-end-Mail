import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/CourierDashboard/index_courier_dashboard.dart';
import '../widgets/greeting_section.dart'; // ✅ tinggal import index

class CourierDashboard extends StatefulWidget {
  const CourierDashboard({super.key});

  @override
  State<CourierDashboard> createState() => _CourierDashboardState();
}

class _CourierDashboardState extends State<CourierDashboard> {
  static const List<Map<String, String>> recipients = [
    {
      "ReceiverName": "Nida Sakina Aulia",
      "SenderName": "Pak Joko",
      "ConsigmentNote": "CN001",
      "PhoneNumber": "6283174603834",
      "Price": "50.000",
      "ItemContent": "Dokumen",
      "DeliveryStatus": "Delivered"
    },
    {
      "ReceiverName": "Muhammad Qinthar",
      "SenderName": "Pak Budi",
      "ConsigmentNote": "CN002",
      "PhoneNumber": "6282127854156",
      "Price": "6.0000",
      "ItemContent": "Paket Elektronik",
      "DeliveryStatus": "In Progress"
    },
    {
      "ReceiverName": "Pak Agus Komarudin",
      "SenderName": "Pak Budi",
      "ConsigmentNote": "CN003",
      "PhoneNumber": "6281997940005",
      "Price": "70.000",
      "ItemContent": "Makanan Sehat",
      "DeliveryStatus": "In Progress"
    },
  ];

  List<Map<String, String>> filteredRecipients = recipients;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipients);
  }

  void _filterRecipients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecipients = recipients.where((data) {
        return data["ReceiverName"]!.toLowerCase().contains(query) ||
            data["SenderName"]!.toLowerCase().contains(query) ||
            data["ConsigmentNote"]!.toLowerCase().contains(query) ||
            data["PhoneNumber"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _openWhatsApp(String phone, String consignmentNote,
      String receiverName, String price) async {
    final message =
        "Hai Sahabat Pos, Atas Nama $receiverName, Paket COD Anda Dengan Resi $consignmentNote Dengan Harga $price Akan Segera Datang ";
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/$phone?text=$encodedMessage");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak bisa membuka WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    var headerLogos = Positioned(
      top: 0,
      left: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/poslogo.png", width: 50, height: 50),
              const SizedBox(width: 10),
              Image.asset("assets/images/danantara.png", width: 50, height: 50),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recipient List",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by name, consignment, or phone...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // ✅ Pakai widget dari exclusive_table.dart
                Expanded(
                  child: ExclusiveTable(
                    recipients: filteredRecipients,
                    onWhatsAppPressed: _openWhatsApp,
                  ),
                ),
              ],
            ),
            headerLogos,
          ],
        ),
      ),
    );
  }
}
