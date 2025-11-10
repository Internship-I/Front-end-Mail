import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouriersPanel extends StatelessWidget {
  const CouriersPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> kurirs = [
      {"name": "Firgi", "area": "Bandung"},
      {"name": "Rafi", "area": "Cimahi"},
      {"name": "Dika", "area": "Lembang"},
      {"name": "Naufal", "area": "Ujungberung"},
      {"name": "Aziee", "area": "Antapani"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Daftar Kurir",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kurirs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 120,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, idx) {
            final k = kurirs[idx];
            return Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF0A2647).withOpacity(0.08),
                  child: Text(k["name"]![0],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87)),
                ),
                const SizedBox(height: 8),
                Text(k["name"]!,
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text(k["area"]!,
                    style: GoogleFonts.poppins(fontSize: 12)),
              ],
            );
          },
        ),
      ],
    );
  }
}
