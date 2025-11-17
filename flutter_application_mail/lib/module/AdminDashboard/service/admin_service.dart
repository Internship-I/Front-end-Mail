import 'package:dio/dio.dart';
import '../../../../config/network/api_client.dart';
import '../../../../config/network/endpoint.dart';
import '../../../../config/network/code_request.dart';
import '../model/request/admin_model_request.dart';
import '../model/response/admin_model_response.dart';

class AdminService {
  final Dio _dio = ApiClient().dio;

  // =====================================================
  // 🔹 INSERT TRANSACTION
  // =====================================================
  Future<AdminModelResponse?> insertTransaction(
      AdminModelRequest request) async {
    try {
      final response = await _dio.post(
        Endpoint.insertTransaction,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AdminModelResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Gagal menambahkan data (status: ${response.statusCode})");
      }
    } catch (error) {
      throw Exception(CodeRequest.handleError(error));
    }
  }

  // =====================================================
  // 🔹 GET ALL TRANSACTIONS
  // =====================================================
  Future<List<Transaction>> getAllTransaction() async {
    try {
      final response = await _dio.get(Endpoint.getAllTransaction);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => Transaction.fromJson(e)).toList();
      } else {
        throw Exception("Gagal memuat daftar transaksi");
      }
    } catch (error) {
      throw Exception(CodeRequest.handleError(error));
    }
  }

  // =====================================================
  // 🔹 GET ALL SENDERS (for dropdown)
  // =====================================================
  Future<List<String>> getAllSender() async {
    try {
      final response = await _dio.get(Endpoint.getAllSender);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];

        // ambil kolom sender_name dari API
        final senderNames = data
            .map((e) => e['sender_name']?.toString().trim() ?? '')
            .where((name) => name.isNotEmpty)
            .toSet() // biar gak ada duplikat
            .toList();

        return senderNames;
      } else {
        throw Exception(
            "Gagal memuat data pengirim (status: ${response.statusCode})");
      }
    } on DioException catch (dioErr) {
      throw Exception(CodeRequest.handleError(dioErr));
    } catch (error) {
      throw Exception("Kesalahan tak terduga: ${error.toString()}");
    }
  }
}
