import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget ini menerima data list dan fungsi callback WA
class ShipmentListView extends StatelessWidget {
  final List<dynamic> transactions;
  final Function(
          String phone, String note, String name, String price, String sender)
      onWhatsAppAction;

  const ShipmentListView({
    super.key,
    required this.transactions,
    required this.onWhatsAppAction,
  });

  @override
  Widget build(BuildContext context) {
    // Langsung tampilkan list tanpa grouping tanggal (sesuai request)
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
          20, 20, 20, 20), // Padding atas ditambah dikit
      physics: const BouncingScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final data = transactions[index];
        return _ShipmentCard(
          data: data,
          onWhatsApp: onWhatsAppAction,
        );
      },
    );
  }
}

// ==========================================
// WIDGET KARTU PENGIRIMAN (CARD)
// ==========================================
class _ShipmentCard extends StatelessWidget {
  final dynamic data;
  final Function(String, String, String, String, String) onWhatsApp;

  const _ShipmentCard({required this.data, required this.onWhatsApp});

  @override
  Widget build(BuildContext context) {
    final bool isCOD = data.codValue > 0;
    final String priceDisplay = isCOD
        ? "Rp ${data.codValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}"
        : "Lunas";

    // Format Tanggal Cantik (Ambil YYYY-MM-DD saja)
    final String dateString = data.createdAt.toString().split('T').first;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. HEADER KARTU (RESI & STATUS)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isCOD ? const Color(0xFFFFF8E1) : const Color(0xFFE8F5E9),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.confirmation_number_outlined,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      data.consignmentNote,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                // BADGE STATUS
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isCOD ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isCOD ? "COD" : "NON-COD",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. BODY KARTU (INFO PENERIMA)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Timeline
                Column(
                  children: [
                    const Icon(Icons.person_pin_circle,
                        color: Color(0xFF0B1650), size: 22),
                    Container(
                      width: 2,
                      height: 40, // Diperpanjang sedikit karena ada tanggal
                      color: Colors.grey.shade200,
                    ),
                    const Icon(Icons.home_work_outlined,
                        color: Colors.grey, size: 18),
                  ],
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Penerima
                      Text(
                        data.receiverName,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1650),
                        ),
                      ),
                      const SizedBox(height: 2),
                      // No HP
                      Text(
                        data.receiverPhone,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      // Alamat
                      Text(
                        data.addressReceiver,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // 🔥 TANGGAL (DITAMBAHKAN DI SINI)
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            dateString,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. FOOTER (SLIDE BUTTON)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tagihan",
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.grey)),
                        Text(
                          priceDisplay,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color:
                                isCOD ? const Color(0xFFFF4901) : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    // TOMBOL GESER (ANDROID SLIDE STYLE)
                    _AndroidSlideButton(
                      onComplete: () {
                        onWhatsApp(
                          data.receiverPhone,
                          data.consignmentNote,
                          data.receiverName,
                          isCOD ? priceDisplay : "Non-COD",
                          data.senderName,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET TOMBOL GESER (SLIDE TO ACT)
// ==========================================
class _AndroidSlideButton extends StatefulWidget {
  final VoidCallback onComplete;
  const _AndroidSlideButton({required this.onComplete});

  @override
  State<_AndroidSlideButton> createState() => _AndroidSlideButtonState();
}

class _AndroidSlideButtonState extends State<_AndroidSlideButton> {
  double _dragValue = 0.0;
  final double _maxWidth = 140.0; // Lebar area geser
  final double _handleSize = 40.0; // Ukuran bulatan

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _maxWidth,
      height: _handleSize,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          // Teks Background
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Geser WA >>",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
          // Progress Hijau
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            width: _dragValue + _handleSize,
            height: _handleSize,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 33, 216, 54).withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          // Handle Geser
          Positioned(
            left: _dragValue,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragValue += details.delta.dx;
                  _dragValue = _dragValue.clamp(0.0, _maxWidth - _handleSize);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragValue > (_maxWidth - _handleSize) * 0.8) {
                  // Jika geser > 80%, trigger action
                  widget.onComplete();
                  setState(() => _dragValue = _maxWidth - _handleSize);
                  // Reset setelah 1 detik
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) setState(() => _dragValue = 0.0);
                  });
                } else {
                  // Balik ke awal
                  setState(() => _dragValue = 0.0);
                }
              },
              child: Container(
                width: _handleSize,
                height: _handleSize,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255), // Warna WA
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Image.asset(
                  "assets/images/walogo.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
