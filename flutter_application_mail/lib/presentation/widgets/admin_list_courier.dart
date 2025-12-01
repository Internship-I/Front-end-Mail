import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '..../../../../module/AdminDashboard/model/response/admin_model_response.dart'; // pastikan path sesuai

class CouriersPanel extends StatelessWidget {
  final List<UserModel> couriers; // ← ambil dari API controller

  const CouriersPanel({
    super.key,
    required this.couriers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar Kurir",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 12),

        // Jika masih loading atau kosong
        if (couriers.isEmpty)
          Center(
            child: Text(
              "Tidak ada kurir",
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: couriers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 120,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, idx) {
            final u = couriers[idx];

            return Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF0A2647).withOpacity(0.08),
                  child: Text(
                    u.username.isNotEmpty ? u.username[0].toUpperCase() : "?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Username
                Text(
                  u.username,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Phone
                Text(
                  u.phone,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                // Role (opsional)
                Text(
                  u.role,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black45,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
