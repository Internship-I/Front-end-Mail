import 'package:flutter/material.dart';
import '../model/request/admin_model_request.dart';
import '../model/response/admin_model_response.dart';
import '../service/admin_service.dart';
import 'snackbar_helper.dart';

class AdminController extends ChangeNotifier {
  final AdminService _service = AdminService();

  bool isLoading = false;

  // 🔹 Data transaksi
  List<Transaction> transactions = [];

  // 🔹 List jenis layanan (fix/static)
  final List<String> serviceTypes = [
    "Same Day",
    "Next Day",
    "Reguler",
    "Shopee",
  ];

  String? selectedServiceType;

  // =====================================================
  // 🔹 Pilih jenis layanan dari dropdown
  // =====================================================
  void selectServiceType(String? type) {
    selectedServiceType = type;
    notifyListeners();
  }

  // =====================================================
  // 🔹 Insert transaksi baru
  // =====================================================
  Future<void> insertTransaction(
      BuildContext context, AdminModelRequest request) async {
    try {
      final result = await _service.insertTransaction(request);
      SnackbarHelper.showSuccess(
        context,
        result?.message ?? "✅ Transaksi berhasil ditambahkan",
      );
    } catch (e) {
      SnackbarHelper.showError(
        context,
        "❌ Gagal menambah transaksi: $e",
      );
    }
    // =====================================================
    // 🔹 Ambil semua transaksi
    // =====================================================
    Future<void> fetchAllTransactions() async {
      try {
        transactions = await _service.getAllTransaction();
        notifyListeners();
      } catch (e) {
        debugPrint("❌ Error fetch transactions: $e");
      }
    }
  }
}
