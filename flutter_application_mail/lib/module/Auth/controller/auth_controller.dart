import 'package:shared_preferences/shared_preferences.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';
import '../service/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<LoginResponse> login(String username, String password) async {
    final request = LoginRequest(username: username, password: password);
    final response = await _authService.login(request);

    if (response.success) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
    }

    return response;
  }

  Future<String?> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}
