class TransactionResponse {
  final String id;
  final String consignmentNote;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String addressReceiver;
  final String itemContent;
  final String serviceType;
  final int codValue;
  final String createdAt;
  final String updatedAt;

  TransactionResponse({
    required this.id,
    required this.consignmentNote,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.addressReceiver,
    required this.itemContent,
    required this.serviceType,
    required this.codValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      id: json["_id"]?.toString() ?? '', // ✅ ambil dari _id
      consignmentNote: json["consignment_note"]?.toString() ?? '-',
      senderName: json["sender_name"]?.toString() ?? '-',
      senderPhone: json["sender_phone"]?.toString() ?? '-',
      receiverName: json["receiver_name"]?.toString() ?? '-',
      receiverPhone: json["receiver_phone"]?.toString() ?? '-',
      addressReceiver: json["address_receiver"]?.toString() ?? '-',
      itemContent: json["item_content"]?.toString() ?? '-',
      serviceType: json["service_type"]?.toString() ?? '-',
      codValue: int.tryParse(json["cod_value"]?.toString() ?? '0') ?? 0,
      createdAt: json["created_at"]?.toString() ?? '-',
      updatedAt: json["updated_at"]?.toString() ?? '-',
    );
  }
}
