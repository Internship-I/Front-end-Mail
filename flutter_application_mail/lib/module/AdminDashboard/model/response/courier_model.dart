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
      id: json["_id"]?.toString() ?? "",
      username: json["username"]?.toString() ?? "",
      phone: json["phone"]?.toString() ?? "",
      role: json["role"]?.toString() ?? "",
      createdAt: json["created_at"]?.toString() ?? "",
    );
  }
}
