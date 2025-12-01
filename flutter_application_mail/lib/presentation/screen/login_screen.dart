import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';
import '../../module/Auth/controller/auth_controller.dart';
import '../../module/Auth/validator/login_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Instance Controller
  final AuthController _authController = AuthController();

  bool _isButtonEnabled = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkInput);
    _passwordController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _usernameController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
    });
  }

  // ==========================================
  // CUSTOM NOTIFICATION (Floating White-Navy)
  // ==========================================
  void _showNotification({
    required BuildContext context,
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    final Color accentColor =
        isSuccess ? const Color(0xFF0B1650) : const Color(0xFFB71C1C);
    final IconData icon =
        isSuccess ? Icons.check_circle_outline : Icons.error_outline;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B1650).withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1650),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // LOGIKA LOGIN
  // ==========================================
  Future<void> _onLogin() async {
    // 1. Tutup keyboard
    FocusScope.of(context).unfocus();

    // 2. Validasi Form
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // 3. Panggil API Login
    final success = await _authController.login(username, password);

    setState(() => _isLoading = false);

    if (success) {
      if (!mounted) return;
      _showNotification(
        context: context,
        title: "Login Berhasil",
        message: "Selamat datang kembali, $username.",
        isSuccess: true,
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      });
    } else {
      if (!mounted) return;
      _showNotification(
        context: context,
        title: "Gagal Masuk",
        message: "Username atau password salah.",
        isSuccess: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isTablet = screen.width > 600;
    const navyColor = Color(0xFF0B1650);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFE),
      body: SafeArea(
        child: Stack(
          children: [
            // ==========================================
            // 1. LOGO HEADER (KIRI ATAS)
            // ==========================================
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/poslogo.png",
                        height: 30, fit: BoxFit.contain),
                    const SizedBox(width: 12),
                    Container(
                        height: 20, width: 1, color: Colors.grey.shade300),
                    const SizedBox(width: 12),
                    Image.asset(
                      "assets/images/danantara.png",
                      height: 35,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // 2. FORM LOGIN (TENGAH NAIK DIKIT)
            // ==========================================
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: isTablet ? 60 : 30,
                  right: isTablet ? 60 : 30,
                  bottom: 100, // Geser naik visualnya
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 420 : double.infinity,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: isTablet ? 28 : 24,
                            fontWeight: FontWeight.w700,
                            color: navyColor,
                          ),
                        ),
                        SizedBox(height: isTablet ? 35 : 30),

                        // Username Input
                        _buildCompactTextField(
                          controller: _usernameController,
                          label: "Username",
                          icon: Icons.person,
                          validator: LoginValidator.validateUsername,
                        ),

                        const SizedBox(height: 16),

                        // Password Input
                        _buildCompactTextField(
                          controller: _passwordController,
                          label: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                          validator: LoginValidator.validatePassword,
                        ),

                        const SizedBox(height: 30),

                        // Tombol Login
                        SizedBox(
                          width: double.infinity,
                          height: isTablet ? 50 : 45,
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled && !_isLoading
                                ? _onLogin
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isButtonEnabled
                                  ? navyColor
                                  : Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: _isButtonEnabled ? 2 : 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      fontSize: isTablet ? 17 : 15.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ==========================================
            // 3. FOOTER (BAWAH TENGAH)
            // ==========================================
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Versi Aplikasi (Opsional, biar pro)
                    Text(
                      "App Version 1.0.0",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Supported By
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Supported By",
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Image.asset(
                          "assets/images/poslogo.png",
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget Text Field
  Widget _buildCompactTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required String? Function(String?)? validator,
  }) {
    const navyColor = Color(0xFF0B1650);

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      style: GoogleFonts.poppins(color: Colors.black87, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
        prefixIcon: Icon(icon, color: navyColor, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[500],
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              )
            : null,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: navyColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      validator: validator,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}