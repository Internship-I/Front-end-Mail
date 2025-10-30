import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/CourierDashboard/index_courier_dashboard.dart';
import '../../module/Dashboard/controller/transaction_controller.dart';

class CourierDashboard extends StatefulWidget {
  const CourierDashboard({super.key});

  @override
  State<CourierDashboard> createState() => _CourierDashboardState();
}

class _CourierDashboardState extends State<CourierDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  Future<void> _openWhatsApp(
    String phone,
    String consignmentNote,
    String receiverName,
    String price,
    String senderName, // 🔹 Tambah parameter sender
  ) async {
    // Pesan berbeda tergantung COD atau Non-COD
    final isNonCod = price == "Non-COD";
    final message = isNonCod
        ? "Hai Sahabat Pos 👋, atas nama $receiverName, paket Non-COD Anda sedang dalam pengantaran 🚚📦 oleh kurir $senderName."
        : "Hai Sahabat Pos 👋, atas nama $receiverName, paket COD Anda dengan resi $consignmentNote senilai $price sedang dalam pengantaran 🚚📦 oleh kurir $senderName.";

    final encoded = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/$phone?text=$encoded");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak bisa membuka WhatsApp");
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionController>(context, listen: false)
          .loadTransactions();
    });

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: Stack(
          children: [
            // HEADER PUTIH
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
            ),

            Consumer<TransactionController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const IntroLoadingPage();
                }

                // Filter pencarian
                final filteredTransactions = controller.transactions.where((t) {
                  final receiver = t.receiverName.toLowerCase();
                  final phone = t.receiverPhone.toLowerCase();
                  final note = t.consignmentNote.toLowerCase();
                  final address = t.addressReceiver.toLowerCase();
                  final sender = t.senderName.toLowerCase();
                  return receiver.contains(searchQuery) ||
                      phone.contains(searchQuery) ||
                      note.contains(searchQuery) ||
                      address.contains(searchQuery) ||
                      sender.contains(searchQuery);
                }).toList();

                // === KONVERSI DATA KE FORMAT TABLE ===
                final recipients = filteredTransactions.map((t) {
                  final formattedDate = t.createdAt.split('T').first;

                  // Tambahkan titik ribuan dan Non-COD
                  final codDisplay = (t.codValue == 0)
                      ? "Non-COD"
                      : "Rp ${t.codValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}";

                  // Tambahkan status lengkap dengan kurir
                  final deliveryStatus = (t.codValue == 0)
                      ? "Paket Non-COD akan dikirimkan oleh kurir ${t.senderName}"
                      : "Paket COD (${codDisplay}) akan dikirimkan oleh kurir ${t.senderName}";

                  return {
                    "ID": t.id,
                    "ConsignmentNote": t.consignmentNote,
                    "SenderName": t.senderName,
                    "SenderPhone": t.senderPhone,
                    "ReceiverName": t.receiverName,
                    "ReceiverPhone": t.receiverPhone,
                    "AddressReceiver": t.addressReceiver,
                    "ItemContent": t.itemContent,
                    "ServiceType": t.serviceType,
                    "CODValue": codDisplay,
                    "CreatedAt": formattedDate,
                    "DeliveryStatus": deliveryStatus,
                  };
                }).toList();

                return Column(
                  children: [
                    const SizedBox(height: 20),

                    // Logo Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/poslogo.png",
                                  width: 45, height: 45),
                              const SizedBox(width: 10),
                              Image.asset("assets/images/danantara.png",
                                  width: 45, height: 45),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Judul
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Shipping Dashboard",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: GoogleFonts.poppins(fontSize: 14),
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            hintText:
                                "Cari penerima, pengirim, resi, nomor HP, atau alamat...",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13.5,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // TABEL
                    Expanded(
                      child: recipients.isEmpty
                          ? Center(
                              child: Text(
                                "Tidak ada hasil ditemukan",
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ExclusiveTable(
                                recipients: recipients,
                                onWhatsAppPressed:
                                    (phone, note, receiver, cod) {
                                  final sender = recipients.firstWhere((r) =>
                                      r["ReceiverPhone"] ==
                                      phone)["SenderName"];
                                  _openWhatsApp(phone, note, receiver, cod,
                                      sender ?? "-");
                                },
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
