class LoginResponse {
  final String status;
  final String message;
  final UserData? user; // dibuat nullable biar aman

  LoginResponse({
    required this.status,
    required this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"]?.toString() ?? "",
      message: json["message"]?.toString() ?? "",
      user: json["user"] != null ? UserData.fromJson(json["user"]) : null,
    );
  }
}

class UserData {
  final String id;
  final String username;
  final String phone;
  final String role;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.username,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["_id"]?.toString() ?? "",
      username: json["username"]?.toString() ?? "",
      phone: json["phone"]?.toString() ?? "",
      role: json["role"]?.toString() ?? "",
      createdAt: json["created_at"]?.toString() ?? "",
      updatedAt: json["updated_at"]?.toString() ?? "",
    );
  }
}
