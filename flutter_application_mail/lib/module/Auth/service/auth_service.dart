import '../../../config/network/api_client_login.dart';
import '../../../config/network/endpoint.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

class AuthService {
  // gunakan singleton saja
  final ApiClient _client = ApiClient.instance;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _client.public.post(
        Endpoint.login,
        data: request.toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw Exception("Login gagal: $e");
    }
  }
}
