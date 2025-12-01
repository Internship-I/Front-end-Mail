import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

// Sesuaikan import ini
import '../../module/Dashboard/controller/transaction_controller.dart';
import '../../presentation/widgets/exclusive_table.dart';

class CourierDashboard extends StatefulWidget {
  const CourierDashboard({super.key});

  @override
  State<CourierDashboard> createState() => _CourierDashboardState();
}

class _CourierDashboardState extends State<CourierDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  DateTime? _selectedDate;

  // --- FUNGSI WHATSAPP (Tetap sama) ---
  Future<void> _openWhatsApp(
    String phone,
    String consignmentNote,
    String receiverName,
    String price,
    String senderName,
  ) async {
    final isNonCod = price == "Non-COD";
    final message = isNonCod
        ? "Hai Sahabat Pos 👋, paket Non-COD a.n $receiverName sedang dikirim oleh kurir $senderName."
        : "Hai Sahabat Pos 👋, paket COD a.n $receiverName (Resi: $consignmentNote, Rp $price) sedang dikirim oleh kurir $senderName.";

    final encoded = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/$phone?text=$encoded");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal membuka WhatsApp")),
        );
      }
    }
  }

  // --- FUNGSI PILIH TANGGAL (Tetap sama) ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0B1650),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===============================================
            // 1. HEADER COMPACT
            // ===============================================
            Padding(
              // 🔥 COMPACT: Padding dikurangi (16 -> 10)
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // KIRI: LOGO
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/poslogo.png",
                        height: 28, // 🔥 COMPACT: 32 -> 28
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          height: 20, width: 1, color: Colors.grey.shade300),
                      const SizedBox(width: 10),
                      Image.asset(
                        "assets/images/danantara.png",
                        height: 24, // 🔥 COMPACT: 28 -> 24
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const SizedBox(),
                      ),
                    ],
                  ),

                  // KANAN: PROFIL
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Muhammad Qinthar",
                            style: GoogleFonts.poppins(
                              fontSize: 13, // 🔥 COMPACT: 14 -> 13
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0B1650),
                            ),
                          ),
                          Text(
                            "Kurir",
                            style: GoogleFonts.poppins(
                              fontSize: 10, // 🔥 COMPACT: 11 -> 10
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 38, // 🔥 COMPACT: 45 -> 38
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.grey.shade100),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://i.pravatar.cc/150?img=11"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ===============================================
            // 2. AREA KONTROL COMPACT
            // ===============================================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  horizontal: 16), // Margin luar dikurangi
              padding: const EdgeInsets.all(
                  16), // 🔥 COMPACT: Padding dalam 24 -> 16
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 255, 255, 255), // Background abu sangat muda
                borderRadius: BorderRadius.circular(20), // Radius 28 -> 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cari Pengiriman",
                    style: GoogleFonts.poppins(
                      fontSize: 16, // 🔥 COMPACT: 20 -> 16
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 12, 8, 116),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Cari data paket dan filter tanggal",
                    style: GoogleFonts.poppins(
                      fontSize: 11, // 🔥 COMPACT: 12 -> 11
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 12), // Jarak dikurangi

                  Row(
                    children: [
                      // SEARCH BAR
                      Expanded(
                        child: Container(
                          height: 42, // 🔥 COMPACT: Tinggi 52 -> 42
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: GoogleFonts.poppins(fontSize: 13),
                            textAlignVertical:
                                TextAlignVertical.center, // Biar teks tengah
                            decoration: InputDecoration(
                              hintText: "Cari resi / nama...",
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey.shade400, fontSize: 12),
                              prefixIcon: const Icon(Icons.search_rounded,
                                  color: Color(0xFF0B1650),
                                  size: 20), // Icon kecil
                              border: InputBorder.none,
                              isDense: true, // Agar tidak boros tempat
                              contentPadding:
                                  EdgeInsets.zero, // Reset padding default
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // TOMBOL FILTER TANGGAL
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          height: 42, // 🔥 COMPACT: 52 -> 42
                          width: 42,
                          decoration: BoxDecoration(
                            color: _selectedDate != null
                                ? const Color(0xFF0B1650)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: _selectedDate != null
                                ? Colors.white
                                : const Color(0xFF0B1650),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // CHIP TANGGAL TERPILIH
                  if (_selectedDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B1650).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Filter: ${DateFormat('dd MMM').format(_selectedDate!)}", // Format tanggal dipendekkan
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0B1650),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedDate = null),
                                  child: const Icon(Icons.close_rounded,
                                      size: 14, color: Color(0xFF0B1650)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8), // Jarak ke list dikurangi

            // ===============================================
            // 3. LIST PENGIRIMAN
            // ===============================================
            Expanded(
              child: Consumer<TransactionController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // LOGIKA FILTER
                  final filteredList = controller.transactions.where((t) {
                    final q = searchQuery;
                    final matchesSearch =
                        t.receiverName.toLowerCase().contains(q) ||
                            t.consignmentNote.toLowerCase().contains(q) ||
                            t.addressReceiver.toLowerCase().contains(q);

                    bool matchesDate = true;
                    if (_selectedDate != null) {
                      try {
                        final tDate = DateTime.parse(t.createdAt);
                        matchesDate = tDate.year == _selectedDate!.year &&
                            tDate.month == _selectedDate!.month &&
                            tDate.day == _selectedDate!.day;
                      } catch (e) {
                        matchesDate = false;
                      }
                    }
                    return matchesSearch && matchesDate;
                  }).toList();

                  if (filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open_rounded,
                              size: 50, color: Colors.grey.shade300),
                          const SizedBox(height: 8),
                          Text(
                            "Tidak ada data",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    );
                  }

                  return ShipmentListView(
                    transactions: filteredList,
                    onWhatsAppAction: _openWhatsApp,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
