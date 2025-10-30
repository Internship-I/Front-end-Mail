import 'package:flutter/foundation.dart';
import '../../../config/network/api_client.dart';
import '../../../config/network/endpoint.dart';
import '../model/response/transaction_response.dart';

class TransactionService {
  final ApiClient _apiClient = ApiClient();

  Future<List<TransactionResponse>> fetchTransactions() async {
    try {
      final response =
          await _apiClient.getRequest(Endpoints.getAllTransactions);

      // Debug print respons mentah
      debugPrint("✅ Response API: $response");

      if (response["status"] == "success") {
        final List data = response["data"];

        // Pastikan data bukan null atau kosong
        if (data.isEmpty) {
          debugPrint("⚠️ Data kosong dari API.");
          return [];
        }

        return data.map((json) {
          // Debug tiap elemen
          debugPrint("🟢 Item JSON: $json"  );

          // Pastikan semua key ada agar gak null error
          return TransactionResponse.fromJson({
            "id": json["id"] ?? "",
            "consignment_note":
                json["consignment_note"] ?? json["consigment_note"] ?? "",
            "sender_name": json["sender_name"] ?? "",
            "sender_phone": json["sender_phone"] ?? json["sender_telp"] ?? "",
            "receiver_name": json["receiver_name"] ?? "",
            "receiver_phone":
                json["receiver_phone"] ?? json["receiver_telp"] ?? "",
            "address_receiver": json["address_receiver"] ?? "",
            "item_content": json["item_content"] ?? "",
            "service_type": json["service_type"] ?? "",
            "cod_value": json["cod_value"] ?? 0,
            "created_at": json["created_at"] ?? "",
            "updated_at": json["updated_at"] ?? "",
          });
        }).toList();
      } else {
        throw Exception(
            "❌ Gagal mengambil data transaksi: ${response["message"]}");
      }
    } catch (e) {
      debugPrint("🚨 Error fetchTransactions: $e");
      rethrow;
    }
  }
}
