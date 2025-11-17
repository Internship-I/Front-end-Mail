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
      id: json['id'] ?? '',
      consignmentNote: json['consignment_note'] ?? '',
      senderName: json['sender_name'] ?? '',
      receiverName: json['receiver_name'] ?? '',
      serviceType: json['service_type'] ?? '',
      codValue: json['cod_value'] ?? 0,
      createdAt: json['created_at'] ?? '',
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
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      transaction: Transaction.fromJson(json['transaction']),
    );
  }
}
