import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screen/dashboard.dart'; // Halaman tujuan

class NotificationPanel extends StatelessWidget {
  final List<String> notifications;
  final VoidCallback onClose;
  final Function(String nama) onTapNotification;

  const NotificationPanel({
    super.key,
    required this.notifications,
    required this.onClose,
    required this.onTapNotification,
  });

  void _openPenerimaDetail(BuildContext context, String nama) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CourierDashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 270,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Header Panel
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifikasi",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1650),
                    ),
                  ),
                  GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.black54,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade300, height: 1),
              const SizedBox(height: 6),

              // 🔹 Daftar Notifikasi
              if (notifications.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Tidak ada notifikasi baru",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                )
              else
                ...notifications.map((notif) {
                  return Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_active_rounded,
                            color: Colors.orange,
                            size: 18,
                          ),
                        ),
                        title: Text(
                          notif,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                        onTap: () {
                          _openPenerimaDetail(context, notif);
                          onTapNotification(notif);
                          onClose();
                        },
                      ),
                      Divider(color: Colors.grey.shade200, height: 8),
                    ],
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
