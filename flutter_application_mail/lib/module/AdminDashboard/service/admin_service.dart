import 'package:dio/dio.dart';
import '../../../../config/network/api_client.dart';
import '../../../../config/network/endpoint.dart';
import '../../../../config/network/code_request.dart';
import '../model/request/admin_model_request.dart';
import '../model/response/admin_model_response.dart';

class AdminService {
  final Dio _dio = ApiClient().dio;

  /// ============================================
  /// INSERT TRANSACTION
  /// ============================================
  Future<AdminModelResponse?> insertTransaction(
      AdminModelRequest request) async {
    try {
      final response = await _dio.post(
        Endpoint.insertTransaction,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          throw Exception("Response kosong dari server");
        }
        return AdminModelResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Gagal menambahkan data (status: ${response.statusCode})");
      }
    } on DioException catch (dioErr) {
      throw Exception(CodeRequest.handleError(dioErr));
    }
  }

  /// ============================================
  /// GET ALL TRANSACTION
  /// ============================================
  Future<List<Transaction>> getAllTransaction() async {
    try {
      final response = await _dio.get(Endpoint.getAllTransaction);

      if (response.statusCode == 200) {
        if (response.data is! Map || response.data['data'] is! List) {
          throw Exception("Format response transaksi tidak valid");
        }

        final List<dynamic> data = response.data['data'];
        return data.map((e) => Transaction.fromJson(e)).toList();
      } else {
        throw Exception("Gagal memuat daftar transaksi");
      }
    } on DioException catch (dioErr) {
      throw Exception(CodeRequest.handleError(dioErr));
    }
  }

  /// ============================================
  /// GET ALL SENDER
  /// ============================================
  Future<List<String>> getAllSender() async {
    try {
      final response = await _dio.get(Endpoint.getAllSender);

      if (response.statusCode == 200) {
        if (response.data is! Map || response.data['data'] is! List) {
          throw Exception("Format data pengirim tidak valid");
        }

        final List<dynamic> data = response.data['data'];

        final senderNames = data
            .map((e) => e['sender_name']?.toString().trim() ?? '')
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList();

        return senderNames;
      } else {
        throw Exception(
            "Gagal memuat data pengirim (status: ${response.statusCode})");
      }
    } on DioException catch (dioErr) {
      throw Exception(CodeRequest.handleError(dioErr));
    }
  }

  /// ============================================
  /// GET ALL USERS (KURIR)
  /// ============================================
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _dio.get(Endpoint.getAllUsers);

      if (response.statusCode == 200) {
        if (response.data is! List) {
          throw Exception("Format response user tidak valid");
        }

        return response.data
            .map<UserModel>((e) => UserModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "Gagal memuat daftar kurir (status: ${response.statusCode})");
      }
    } on DioException catch (dioErr) {
      throw Exception(CodeRequest.handleError(dioErr));
    }
  }

  // =====================================================================
  // 🔥 FUNGSI TAMBAHAN UNTUK KURIR
  // =====================================================================

  /// ============================================
  /// CREATE / ADD KURIR
  /// ============================================
  // Future<UserModel?> addKurir(Map<String, dynamic> body) async {
  //   try {
  //     final response = await _dio.post(
  //       Endpoint.addUser, // Pastikan endpoint sudah ada
  //       data: body,
  //     );

  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       return UserModel.fromJson(response.data);
  //     } else {
  //       throw Exception("Gagal menambah kurir");
  //     }
  //   } on DioException catch (dioErr) {
  //     throw Exception(CodeRequest.handleError(dioErr));
  //   }
  // }

  /// ============================================
  /// UPDATE KURIR
  /// ============================================
  // Future<UserModel?> updateKurir(String id, Map<String, dynamic> body) async {
  //   try {
  //     final response = await _dio.put(
  //       "${Endpoint.updateUser}/$id",
  //       data: body,
  //     );

  //     if (response.statusCode == 200) {
  //       return UserModel.fromJson(response.data);
  //     } else {
  //       throw Exception("Gagal update kurir");
  //     }
  //   } on DioException catch (dioErr) {
  //     throw Exception(CodeRequest.handleError(dioErr));
  //   }
  // }

  /// ============================================
  /// DELETE KURIR
  /// ============================================
  // Future<bool> deleteKurir(String id) async {
  //   try {
  //     final response = await _dio.delete(
  //       "${Endpoint.deleteUser}/$id",
  //     );

  //     return response.statusCode == 200;
  //   } on DioException catch (dioErr) {
  //     throw Exception(CodeRequest.handleError(dioErr));
  //   }
  // }
}
