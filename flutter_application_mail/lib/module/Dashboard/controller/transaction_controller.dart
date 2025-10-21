import 'package:flutter/material.dart';
import '../model/response/transaction_response.dart';
import '../service/transaction_service.dart';

class TransactionController extends ChangeNotifier {
  final TransactionService _service = TransactionService();
  List<TransactionResponse> transactions = [];
  bool isLoading = false;

  Future<void> loadTransactions() async {
    // Cegah pemanggilan ganda
    if (isLoading) return;

    isLoading = true;
    if (hasListeners) notifyListeners();

    try {
      final result = await _service.fetchTransactions();

      // Antisipasi hasil null agar tidak error
      transactions = result ?? [];
    } catch (e) {
      debugPrint("Error loadTransactions: $e");
    } finally {
      isLoading = false;

      // Cek apakah listener masih aktif sebelum panggil notify
      if (hasListeners) notifyListeners();
    }
  }
}
