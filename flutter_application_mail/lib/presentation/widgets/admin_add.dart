import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRecipientPanel extends StatelessWidget {
  final BuildContext context;
  const AddRecipientPanel({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final inputStyle = GoogleFonts.poppins(fontSize: 13);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Form Tambah Penerima",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color(0xFF0A2647),
                ),
              ),
              const Icon(Icons.person_add_alt_1, color: Color(0xFF0A2647)),
            ],
          ),
          const SizedBox(height: 16),

          // 🔹 Input fields
          _buildField(
            label: "Nama penerima",
            icon: Icons.person_outline,
            style: inputStyle,
          ),
          const SizedBox(height: 12),
          _buildField(
            label: "Nomor HP",
            icon: Icons.phone_android_outlined,
            keyboardType: TextInputType.phone,
            style: inputStyle,
          ),
          const SizedBox(height: 12),
          _buildField(
            label: "Alamat ringkas",
            icon: Icons.home_outlined,
            maxLines: 2,
            style: inputStyle,
          ),

          const SizedBox(height: 20),

          // 🔹 Tombol Simpan
          Align(
            alignment: Alignment.centerRight,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Penerima berhasil ditambahkan (mock).")),
                  );
                },
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: Text(
                  "Simpan",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 13.5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF205295),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: const Color(0xFF205295).withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextStyle style,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF205295)),
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.grey[700],
        ),
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF205295), width: 1.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      style: style,
    );
  }
}
