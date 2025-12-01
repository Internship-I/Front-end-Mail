class Transaction {
  final String id;
  final String consignmentNote;
  final String senderName;
  final String receiverName;
  final String serviceType;
  final int codValue;
  final String createdAt;

  Transaction({
    required this.id,
    required this.consignmentNote,
    required this.senderName,
    required this.receiverName,
    required this.serviceType,
    required this.codValue,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id']?.toString() ?? '',
      consignmentNote: json['consignment_note']?.toString() ?? '',
      senderName: json['sender_name']?.toString() ?? '',
      receiverName: json['receiver_name']?.toString() ?? '',
      serviceType: json['service_type']?.toString() ?? '',
      codValue: int.tryParse(json['cod_value']?.toString() ?? "0") ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

class AdminModelResponse {
  final String message;
  final String status;
  final Transaction transaction;

  AdminModelResponse({
    required this.message,
    required this.status,
    required this.transaction,
  });

  factory AdminModelResponse.fromJson(Map<String, dynamic> json) {
    return AdminModelResponse(
      message: json['message']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      transaction: Transaction.fromJson(json['transaction'] ?? {}),
    );
  }
}

/// NEW: RESPONSE FOR GET ALL
class TransactionListResponse {
  final List<Transaction> data;

  TransactionListResponse({required this.data});

  factory TransactionListResponse.fromJson(dynamic json) {
    if (json is List) {
      return TransactionListResponse(
        data: json.map((e) => Transaction.fromJson(e)).toList(),
      );
    }
    return TransactionListResponse(data: []);
  }
}

/// ===============================
/// USER MODEL
/// ===============================
class UserModel {
  final String id;
  final String username;
  final String phone;
  final String role;
  final String createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.phone,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

/// ===============================
/// USER LIST RESPONSE
/// ===============================
class UserListResponse {
  final List<UserModel> data;

  UserListResponse({required this.data});

  factory UserListResponse.fromJson(dynamic json) {
    if (json is List) {
      return UserListResponse(
        data: json.map((e) => UserModel.fromJson(e)).toList(),
      );
    }
    return UserListResponse(data: []);
  }
}
