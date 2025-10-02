import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourierDashboard extends StatelessWidget {
  const CourierDashboard({super.key});

  // Contoh data sementara, nanti akan diganti dari API
  static const List<Map<String, String>> recipients = [
    {
      "ReceiverName": "John Doe",
      "SenderName": "Alice",
      "ConsigmentNote": "CN001",
      "PhoneNumber": "08123456789",
      "ItemContent": "Dokumen",
      "DeliveryStatus": "Delivered"
    },
    {
      "ReceiverName": "Jane Smith",
      "SenderName": "Bob",
      "ConsigmentNote": "CN002",
      "PhoneNumber": "08234567890",
      "ItemContent": "Paket Elektronik",
      "DeliveryStatus": "In Progress"
    },
    {
      "ReceiverName": "Jane Smith",
      "SenderName": "Bob",
      "ConsigmentNote": "CN002",
      "PhoneNumber": "08234567890",
      "ItemContent": "Paket Elektronik",
      "DeliveryStatus": "In Progress"
    },
    {
      "ReceiverName": "Jane Smith",
      "SenderName": "Bob",
      "ConsigmentNote": "CN002",
      "PhoneNumber": "08234567890",
      "ItemContent": "Paket Elektronik",
      "DeliveryStatus": "In Progress"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var positioned = Positioned(
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
                const SizedBox(height: 70), // ruang untuk logo

                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("WA")),
                        ],
                        rows: recipients
                            .map<DataRow>(
                              (data) => DataRow(
                                cells: [
                                  DataCell(Text(data["ReceiverName"]!)),
                                  DataCell(Text(data["SenderName"]!)),
                                  DataCell(Text(data["ConsigmentNote"]!)),
                                  DataCell(Text(data["PhoneNumber"]!)),
                                  DataCell(Text(data["ItemContent"]!)),
                                  DataCell(Text(data["DeliveryStatus"]!)),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        // nanti bisa buka WhatsApp ke nomor di data["PhoneNumber"]
                                      },
                                      child: Image.asset(
                                        "assets/images/walogo.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            positioned,
          ],
        ),
      ),
    );
  }
}
