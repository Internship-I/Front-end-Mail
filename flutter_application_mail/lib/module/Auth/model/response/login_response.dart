class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final String? username;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "token": token,
      "username": username,
    };
  }
}
