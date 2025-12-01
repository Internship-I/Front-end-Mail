import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module/AdminDashboard/model/request/admin_model_request.dart';
import '../../module/AdminDashboard/controller/admin_controller.dart';
import 'package:provider/provider.dart';

class AdminAddForm extends StatefulWidget {
  const AdminAddForm({super.key});

  @override
  State<AdminAddForm> createState() => _AdminAddFormState();
}

class _AdminAddFormState extends State<AdminAddForm> {
  final _formKey = GlobalKey<FormState>();

  final senderNameController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverPhoneController = TextEditingController();
  final addressController = TextEditingController();
  final itemContentController = TextEditingController();
  final codValueController = TextEditingController();

  String? selectedServiceType;

  final List<String> serviceTypes = [
    "Same Day",
    "Next Day",
    "Reguler",
    "Shopee"
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminController>(context);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        // 🔥 COMPACT: Padding dikurangi drastis (28/34 -> 20)
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16), // Radius diperkecil (22 -> 16)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header kecil (Opsional)
                Text(
                  "Form Input Data",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0A2647),
                  ),
                ),
                const SizedBox(height: 12),

                // ---------------- FORM FIELDS COMPACT ----------------
                // Saya isi labelnya agar user tahu harus isi apa

                Row(
                  children: [
                    Expanded(
                        child: _field("Nama Pengirim", senderNameController,
                            Icons.person_rounded)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _field("No. HP Pengirim", senderPhoneController,
                            Icons.phone_android_rounded,
                            keyboardType: TextInputType.phone)),
                  ],
                ),
                _gap(),

                _dropdown(
                  label: "Layanan",
                  icon: Icons.local_shipping_rounded,
                  value: selectedServiceType,
                  items: serviceTypes,
                  onChanged: (v) => setState(() => selectedServiceType = v),
                ),
                _gap(),

                Row(
                  children: [
                    Expanded(
                        child: _field("Nama Penerima", receiverNameController,
                            Icons.person_pin_rounded)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _field(
                            "No. HP Penerima",
                            receiverPhoneController,
                            Icons.phone_android_rounded,
                            keyboardType: TextInputType.phone)),
                  ],
                ),
                _gap(),

                _field("Alamat Penerima", addressController, Icons.home_rounded,
                    maxLines: 2), // Maxlines 2 cukup
                _gap(),

                _field("Isi Paket", itemContentController,
                    Icons.inventory_2_rounded),
                _gap(),

                _field("Nilai COD (Rp)", codValueController,
                    Icons.payments_rounded,
                    keyboardType: TextInputType.number),

                const SizedBox(height: 20),

                // ---------------- SAVE BUTTON COMPACT ----------------
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40, // Tinggi tombol fix dan kecil
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) return;

                              if (selectedServiceType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Pilih jenis layanan terlebih dahulu.")),
                                );
                                return;
                              }

                              final req = AdminModelRequest(
                                senderName: senderNameController.text,
                                senderPhone: senderPhoneController.text,
                                receiverName: receiverNameController.text,
                                addressReceiver: addressController.text,
                                receiverPhone: receiverPhoneController.text,
                                itemContent: itemContentController.text,
                                serviceType: selectedServiceType!,
                                codValue:
                                    int.tryParse(codValueController.text) ?? 0,
                              );

                              controller.insertTransaction(context, req);
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: const Color(0xFF0A2647),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              "Simpan Data",
                              style: GoogleFonts.poppins(
                                fontSize: 10, // Font kecil
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────── COMPACT FIELD ─────────────────
  Widget _field(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (v) => v == null || v.isEmpty ? "Wajib diisi" : null,
      style:
          GoogleFonts.poppins(fontSize: 12, color: Colors.black87), // Font 12
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
        prefixIcon:
            Icon(icon, color: const Color(0xFF0A2647), size: 18), // Icon 18
        filled: true,
        fillColor: Colors.grey.shade50,
        isDense: true, // 🔥 PENTING: Agar tidak boros tempat
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Radius 10
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFF0A2647), width: 1.5),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required IconData icon,
    required dynamic value,
    required List items,
    required Function(dynamic) onChanged,
  }) {
    return DropdownButtonFormField(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child:
                    Text(e.toString(), style: GoogleFonts.inter(fontSize: 12)),
              ))
          .toList(),
      onChanged: onChanged,
      style: GoogleFonts.inter(fontSize: 12, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: const Color(0xFF0A2647), size: 18),
        filled: true,
        fillColor: Colors.grey.shade50,
        isDense: true, // 🔥 PENTING
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color(0xFF0A2647), width: 1.5),
        ),
      ),
    );
  }

  // Jarak antar field dikurangi (18 -> 10)
  SizedBox _gap() => const SizedBox(height: 10);
}
