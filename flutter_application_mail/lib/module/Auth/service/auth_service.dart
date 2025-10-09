import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

class AuthService {
  Future<LoginResponse> login(LoginRequest request) async {
    // Simulasi delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
    const dummyUsernames = ["admin", "kurir"];
    const dummyPassword = "12345";

    if (dummyUsernames.contains(request.username) &&
        request.password == dummyPassword) {
      return LoginResponse(
        success: true,
        message: "Login berhasil",
        token: "dummy_token_123456",
        username: request.username,
      );
    } else {
      return LoginResponse(
        success: false,
        message: "Username atau password salah",
      );
    }
  }
}
