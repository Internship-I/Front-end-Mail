import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router.dart';
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
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkInput);
    _passwordController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 2),
        content: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, opacity, _) {
            return Opacity(
              opacity: opacity,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 5, 42, 107),
                      Color.fromARGB(255, 36, 53, 141),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Login Berhasil Selamat datang',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: 0.2,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isTablet = screen.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFE),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 420 : double.infinity,
            ),
            child: Stack(
              children: [
                // 🔹 Logo
                Padding(
                  padding: EdgeInsets.all(isTablet ? 20 : 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/poslogo.png",
                          width: isTablet ? 50 : 42,
                          height: isTablet ? 50 : 42),
                      const SizedBox(width: 8),
                      Image.asset("assets/images/danantara.png",
                          width: isTablet ? 70 : 60,
                          height: isTablet ? 70 : 60),
                    ],
                  ),
                ),

                // 🔹 Form Login
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 50 : 30,
                      vertical: isTablet ? 40 : 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                fontSize: isTablet ? 28 : 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0B1650),
                              ),
                            ),
                            SizedBox(height: isTablet ? 35 : 25),

                            // 🔹 Username
                            TextFormField(
                              controller: _usernameController,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.person,
                                    color: Color(0xFF0B1650), size: 20),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                              ),
                              validator: LoginValidator.validateUsername,
                            ),
                            const SizedBox(height: 16),

                            // 🔹 Password
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.lock,
                                    color: Color(0xFF0B1650), size: 20),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                              ),
                              validator: LoginValidator.validatePassword,
                            ),
                            const SizedBox(height: 25),

                            // 🔹 Tombol Login
                            SizedBox(
                              width: double.infinity,
                              height: isTablet ? 50 : 45,
                              child: ElevatedButton(
                                onPressed: _isButtonEnabled ? _onLogin : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isButtonEnabled
                                      ? const Color(0xFF0B1650)
                                      : Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 1.5,
                                ),
                                child: Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
  