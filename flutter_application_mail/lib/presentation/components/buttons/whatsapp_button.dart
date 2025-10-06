import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  final String phone; // nomor WA tujuan
  final String message; // pesan default

  const WhatsAppButton({
    super.key,
    required this.phone,
    this.message = "Halo Admin, saya ada kendala dalam pengiriman.",
    required String phoneNumber,
  });

  Future<void> _openWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse("https://wa.me/$phone?text=$encodedMessage");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak bisa membuka WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: GestureDetector(
        onTap: _openWhatsApp,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Image.asset(
            "assets/images/walogo.png", // pastikan ada logo WA
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
