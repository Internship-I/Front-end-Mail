class AdminModelRequest {
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String addressReceiver;
  final String receiverPhone;
  final String itemContent;
  final String serviceType;
  final int codValue;

  AdminModelRequest({
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.addressReceiver,
    required this.receiverPhone,
    required this.itemContent,
    required this.serviceType,
    required this.codValue,
  });

  /// 🔹 Konversi ke JSON untuk dikirim ke API
  Map<String, dynamic> toJson() {
    return {
      "sender_name": senderName.trim(),
      "sender_phone": senderPhone.trim(),
      "receiver_name": receiverName.trim(),
      "address_receiver": addressReceiver.trim(),
      "receiver_phone": receiverPhone.trim(),
      "item_content": itemContent.trim(),
      "service_type": serviceType.trim(),
      "cod_value": codValue,
    };
  }

  /// 🔹 Factory dari JSON (kalau nanti kamu mau parse balik dari API)
  factory AdminModelRequest.fromJson(Map<String, dynamic> json) {
    return AdminModelRequest(
      senderName: json["sender_name"] ?? "",
      senderPhone: json["sender_phone"] ?? "",
      receiverName: json["receiver_name"] ?? "",
      addressReceiver: json["address_receiver"] ?? "",
      receiverPhone: json["receiver_phone"] ?? "",
      itemContent: json["item_content"] ?? "",
      serviceType: json["service_type"] ?? "",
      codValue: json["cod_value"] ?? 0,
    );
  }
}
