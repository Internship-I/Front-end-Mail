import 'package:flutter/material.dart';
import '../model/response/transaction_response.dart';
import '../service/transaction_service.dart';

class TransactionController extends ChangeNotifier {
  final TransactionService _service = TransactionService();

  List<TransactionResponse> transactions = []; // semua data asli
  List<TransactionResponse> filteredTransactions = []; // data hasil filter
  bool isLoading = false;
  String? selectedDate; // untuk menyimpan tanggal yang sedang difilter

  Future<void> loadTransactions() async {
    // Cegah pemanggilan ganda
    if (isLoading) return;

    isLoading = true;
    if (hasListeners) notifyListeners();

    try {
      final result = await _service.fetchTransactions();

      // Antisipasi hasil null agar tidak error
      transactions = result ?? [];
      filteredTransactions = transactions; // tampilkan semua data awal
    } catch (e) {
      debugPrint("Error loadTransactions: $e");
    } finally {
      isLoading = false;

      // Cek apakah listener masih aktif sebelum panggil notify
      if (hasListeners) notifyListeners();
    }
  }

  // 🔹 Filter data berdasarkan tanggal (format sesuai field CreatedAt)
  void filterByDate(String date) {
    selectedDate = date;
    filteredTransactions = transactions.where((tx) {
      // pastikan CreatedAt tidak null dan cocok dengan tanggal
      return tx.createdAt?.startsWith(date) ?? false;
    }).toList();
    if (hasListeners) notifyListeners();
  }

  // 🔹 Hapus filter dan tampilkan semua data lagi
  void clearFilter() {
    selectedDate = null;
    filteredTransactions = transactions;
    if (hasListeners) notifyListeners();
  }
}
