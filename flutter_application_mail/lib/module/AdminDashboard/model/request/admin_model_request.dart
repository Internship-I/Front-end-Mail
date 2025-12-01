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

  /// 🔹 Convert ke JSON untuk dikirim ke API
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

  /// 🔹 Factory dari JSON (jaga-jaga kalau API return data)
  factory AdminModelRequest.fromJson(Map<String, dynamic> json) {
    return AdminModelRequest(
      senderName: (json["sender_name"] ?? "").toString(),
      senderPhone: (json["sender_phone"] ?? "").toString(),
      receiverName: (json["receiver_name"] ?? "").toString(),
      addressReceiver: (json["address_receiver"] ?? "").toString(),
      receiverPhone: (json["receiver_phone"] ?? "").toString(),
      itemContent: (json["item_content"] ?? "").toString(),
      serviceType: (json["service_type"] ?? "").toString(),
      codValue: int.tryParse(json["cod_value"]?.toString() ?? "0") ?? 0,
    );
  }

  /// 🔹 Biar mudah debugging
  @override
  String toString() {
    return """
AdminModelRequest(
  senderName: $senderName,
  senderPhone: $senderPhone,
  receiverName: $receiverName,
  addressReceiver: $addressReceiver,
  receiverPhone: $receiverPhone,
  itemContent: $itemContent,
  serviceType: $serviceType,
  codValue: $codValue
)
""";
  }
}
