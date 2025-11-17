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

    final inputStyle =
        GoogleFonts.poppins(fontSize: 13.5, color: Colors.black87);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "create transaction",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0A2647),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A2647),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.add_rounded,
                          color: Colors.white, size: 22),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 1, color: Color(0xFFE9EEF3)),
                const SizedBox(height: 20),

                // 🔸 Form Fields
                _buildField(
                  controller: senderNameController,
                  label: "Nama Pengirim",
                  icon: Icons.person_outline,
                  style: inputStyle,
                  validatorText: "Nama pengirim wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: senderPhoneController,
                  label: "Nomor HP Pengirim",
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  style: inputStyle,
                  validatorText: "Nomor HP pengirim wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildDropdown<String>(
                  label: "Jenis Layanan",
                  icon: Icons.local_shipping_outlined,
                  value: selectedServiceType,
                  items: serviceTypes,
                  onChanged: (val) => setState(() => selectedServiceType = val),
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: receiverNameController,
                  label: "Nama Penerima",
                  icon: Icons.person_outline,
                  style: inputStyle,
                  validatorText: "Nama penerima wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: receiverPhoneController,
                  label: "Nomor HP Penerima",
                  icon: Icons.phone_android_outlined,
                  keyboardType: TextInputType.phone,
                  style: inputStyle,
                  validatorText: "Nomor HP penerima wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: addressController,
                  label: "Alamat Penerima",
                  icon: Icons.home_outlined,
                  style: inputStyle,
                  maxLines: 2,
                  validatorText: "Alamat wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: itemContentController,
                  label: "Isi Barang",
                  icon: Icons.inventory_2_outlined,
                  style: inputStyle,
                  validatorText: "Isi barang wajib diisi",
                ),
                const SizedBox(height: 16),
                _buildField(
                  controller: codValueController,
                  label: "Nilai COD",
                  icon: Icons.monetization_on_outlined,
                  keyboardType: TextInputType.number,
                  style: inputStyle,
                  validatorText: "Nilai COD wajib diisi",
                ),
                const SizedBox(height: 28),

                // 🔹 Tombol Simpan
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedServiceType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Pilih jenis layanan terlebih dahulu."),
                                  ),
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
                            }
                          },
                    icon: controller.isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save_rounded,
                            color: Colors.white, size: 18),
                    label: Text(
                      controller.isLoading ? "Menyimpan..." : "Simpan",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2647),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black26,
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

  // =================== COMPONENTS ===================

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextStyle style,
    required String validatorText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (val) => val == null || val.isEmpty ? validatorText : null,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0A2647)),
        labelText: label,
        labelStyle: GoogleFonts.poppins(
            fontSize: 13, color: const Color.fromARGB(255, 0, 0, 0)),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0A2647), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: const Color.fromARGB(255, 6, 24, 97)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required IconData icon,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e.toString(),
                  style:
                      GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0A2647)),
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0A2647), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: const Color.fromARGB(255, 3, 20, 94)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
