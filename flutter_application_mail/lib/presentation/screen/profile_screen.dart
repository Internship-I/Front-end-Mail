// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeHeader;
  late Animation<double> _fadeAvatar;
  late Animation<double> _fadeName;
  late Animation<double> _fadeBox;
  late Animation<double> _fadeButton;
  late Animation<double> _fadeSocial;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _fadeHeader = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.15, curve: Curves.easeOut));
    _fadeAvatar = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.3, curve: Curves.easeOut));
    _fadeName = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.45, curve: Curves.easeOut));
    _fadeBox = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.7, curve: Curves.easeOut));
    _fadeButton = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 0.85, curve: Curves.easeOut));
    _fadeSocial = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xFF0B1650);
    const goldAccent = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Background gradient lembut
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF9F9FB), Color(0xFFEFEFF3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔹 Siluet logo transparan besar
          Positioned.fill(
            child: Opacity(
              opacity: 0.04,
              child: Center(
                child: Image.asset(
                  "assets/images/poslogo.png",
                  width: 500,
                  height: 500,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 Header Logo
                    FadeTransition(
                      opacity: _fadeHeader,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/poslogo.png",
                              width: 55, height: 55),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/danantara.png",
                              width: 55, height: 55),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20), // ⬆️ dikurangi dari 40

                    // 🔹 Avatar Elegan
                    FadeTransition(
                      opacity: _fadeAvatar,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.9, end: 1.0)
                            .animate(_fadeAvatar),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: goldAccent.withOpacity(0.3),
                                blurRadius: 25,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 58,
                            backgroundImage:
                                AssetImage("assets/images/qin.jpg"),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10), // ⬆️ lebih rapat dari 18

                    // 🔹 Nama dan Jabatan
                    FadeTransition(
                      opacity: _fadeName,
                      child: Column(
                        children: [
                          Text(
                            "Muhammad Qinthar",
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: mainColor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "Kurir Profesional | PT Pos Indonesia",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25), // ⬆️ dikurangi dari 35

                    // 🔹 Info Card
                    FadeTransition(
                      opacity: _fadeBox,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.08)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                _infoCard(Icons.badge_outlined, "Jabatan",
                                    "Ketua Kurir", mainColor),
                                const SizedBox(height: 14),
                                _infoCard(Icons.phone_outlined, "Nomor Telepon",
                                    "+62 821 2785 4156", goldAccent),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25), // ⬆️ lebih kecil dari 35

                    // 🔹 Tombol Logout Premium
                    FadeTransition(
                      opacity: _fadeButton,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            elevation: 5,
                            shadowColor: mainColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                "Keluar",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🔹 Social Media Icons Modern
                    FadeTransition(
                      opacity: _fadeSocial,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _SocialIcon(icon: Icons.chat, label: "Chat"),
                          SizedBox(width: 18),
                          _SocialIcon(icon: Icons.code, label: "GitHub"),
                          SizedBox(width: 18),
                          _SocialIcon(
                              icon: Icons.alternate_email, label: "Email"),
                          SizedBox(width: 18),
                          _SocialIcon(
                              icon: Icons.business_center, label: "LinkedIn"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
      IconData icon, String title, String value, Color highlightColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: highlightColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [highlightColor, highlightColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                    color: highlightColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black54)),
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SocialIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 255, 255, 255);
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 9, 21, 109), Color(0xFF223A7A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 5, 5, 124).withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
