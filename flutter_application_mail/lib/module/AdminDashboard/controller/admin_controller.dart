import 'package:flutter/material.dart';
import '../model/request/admin_model_request.dart';
import '../model/response/admin_model_response.dart';
import '../model/response/courier_model.dart' as courier; // ⬅️ TAMBAH INI
import '../service/admin_service.dart';
import '../../../presentation/widgets/utils/snackbar_helper_admin.dart';

class AdminController extends ChangeNotifier {
  final AdminService _service = AdminService();

  bool isLoading = false;

  // =====================================================
  // 🔹 TRANSAKSI SECTION
  // =====================================================

  List<Transaction> transactions = [];

  final List<String> serviceTypes = [
    "Same Day",
    "Next Day",
    "Reguler",
    "Shopee",
  ];

  String? selectedServiceType;

  void selectServiceType(String? type) {
    selectedServiceType = type;
    notifyListeners();
  }

  Future<void> insertTransaction(
      BuildContext context, AdminModelRequest request) async {
    try {
      _setLoading(true);

      final result = await _service.insertTransaction(request);

      SnackbarHelper.showSuccess(
        context,
        result?.message ?? "Transaksi berhasil ditambahkan",
      );

      await fetchAllTransactions();
    } catch (e) {
      SnackbarHelper.showError(
        context,
        "Gagal menambah transaksi: $e",
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchAllTransactions() async {
    try {
      _setLoading(true);

      final resp = await _service.getAllTransaction();
      transactions = resp;

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error fetch transactions: $e");
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // 🔥 USER / KURIR SECTION
  // =====================================================

  List<UserModel> users = [];
  Future<void> fetchAllUsers() async {
    try {
      _setLoading(true);

      final resp = await _service.getAllUsers();

      // 🔥 FILTER HANYA KURIR
      users = resp.where((u) => u.role.toLowerCase() == "kurir").toList();

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error fetch users: $e");
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  // 🔹 SET LOADING
  // =====================================================
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
