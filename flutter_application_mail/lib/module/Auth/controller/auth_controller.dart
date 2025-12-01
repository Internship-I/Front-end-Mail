import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 1. JANGAN LUPA IMPORT INI
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';
import '../service/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _service = AuthService();

  bool isLoading = false;

  String? userRole;
  String? username;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final request = LoginRequest(username: username, password: password);
      final LoginResponse resp = await _service.login(request);

      // Pastikan status sukses (case insensitive)
      final isSuccess = resp.status.toLowerCase() == "success";

      if (isSuccess && resp.user != null) {
        // Update variabel di controller (Memory)
        userRole = resp.user!.role;
        this.username = resp.user!.username;

        // ==========================================================
        // 🔥 BAGIAN PENTING: SIMPAN KE MEMORI HP (SHARED PREFS)
        // ==========================================================
        final prefs = await SharedPreferences.getInstance();
        
        // Simpan Username agar bisa dibaca di Dashboard
        await prefs.setString('username', resp.user!.username);
        
        // Simpan Role (Opsional, berguna jika ingin membedakan menu Admin/Kurir)
        await prefs.setString('role', resp.user!.role);
        
        // Simpan Token (Jika ada di response, sebaiknya disimpan juga)
        // await prefs.setString('token', resp.token); 

        // Tandai bahwa user sudah login (Berguna untuk Splash Screen nanti)
        await prefs.setBool('is_login', true);

        notifyListeners();
      }

      return isSuccess;
    } catch (e) {
      debugPrint("Error Login: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================================
  // 🔥 TAMBAHAN: FUNGSI LOGOUT
  // ==========================================================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Hapus semua data sesi
    await prefs.clear();
    
    // Reset variabel di memory
    username = null;
    userRole = null;
    
    notifyListeners();
  }
}