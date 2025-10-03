import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CourierDashboard extends StatefulWidget {
  const CourierDashboard({super.key});

  @override
  State<CourierDashboard> createState() => _CourierDashboardState();
}

class _CourierDashboardState extends State<CourierDashboard> {
  // Data sementara
  static const List<Map<String, String>> recipients = [
    {
      "ReceiverName": "Nida Sakina Aulia",
      "SenderName": "Pak Joko",
      "ConsigmentNote": "CN001",
      "PhoneNumber": "6283174603834",
      "Price": "50000",
      "ItemContent": "Dokumen",
      "DeliveryStatus": "Delivered"
    },
    {
      "ReceiverName": "Muhammad Qinthar",
      "SenderName": "Pak Budi",
      "ConsigmentNote": "CN002",
      "PhoneNumber": "6282127854156",
      "Price": "60000",
      "ItemContent": "Paket Elektronik",
      "DeliveryStatus": "In Progress"
    },
    {
      "ReceiverName": "Pak Agus Komarudin",
      "SenderName": "Pak Budi",
      "ConsigmentNote": "CN003",
      "PhoneNumber": "6281997940005",
      "Price": "70000",
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

  // Fungsi Helpdesk WhatsApp
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
              Image.asset(
                "assets/images/poslogo.png",
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Image.asset(
                "assets/images/danantara.png",
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
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

                // Judul
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recipient List",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Search Bar
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

                // Tabel Data
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 12,
                        horizontalMargin: 16,
                        columns: const [
                          DataColumn(label: Text("Recipient")),
                          DataColumn(label: Text("Sender")),
                          DataColumn(label: Text("Consignment")),
                          DataColumn(label: Text("Phone")),
                          DataColumn(label: Text("Item")),
                          DataColumn(label: Text("Price")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("WA")),
                        ],
                        rows: filteredRecipients.map<DataRow>((data) {
                          return DataRow(
                            cells: [
                              DataCell(Text(data["ReceiverName"]!)),
                              DataCell(Text(data["SenderName"]!)),
                              DataCell(Text(data["ConsigmentNote"]!)),
                              DataCell(Text(data["PhoneNumber"]!)),
                              DataCell(Text(data["ItemContent"]!)),
                              DataCell(Text(data["Price"]!)),
                              DataCell(Text(data["DeliveryStatus"]!)),
                              DataCell(
                                IconButton(
                                  icon: Image.asset(
                                    "assets/images/walogo.png", // ✅ icon WA custom
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    _openWhatsApp(
                                      data["PhoneNumber"]!,
                                      data["ConsigmentNote"]!,
                                      data["ReceiverName"]!,
                                      data["Price"]!,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
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
