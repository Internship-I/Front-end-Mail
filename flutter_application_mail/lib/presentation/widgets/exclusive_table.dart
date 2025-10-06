import 'package:flutter/material.dart';

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
    return ListView.separated(
      itemCount: recipients.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final data = recipients[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Atas: Nama & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data["ReceiverName"]!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: data["DeliveryStatus"] == "Delivered"
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data["DeliveryStatus"]!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: data["DeliveryStatus"] == "Delivered"
                              ? Colors.green.shade800
                              : Colors.orange.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Detail Info
                Text("Sender: ${data["SenderName"]}"),
                Text("Consignment: ${data["ConsigmentNote"]}"),
                Text("Phone: ${data["PhoneNumber"]}"),
                Text("Item: ${data["ItemContent"]}"),
                const SizedBox(height: 6),

                // Harga + Tombol WA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp ${data["Price"]}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        "assets/images/walogo.png",
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () {
                        onWhatsAppPressed(
                          data["PhoneNumber"]!,
                          data["ConsigmentNote"]!,
                          data["ReceiverName"]!,
                          data["Price"]!,
                        );
                      },
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
}
