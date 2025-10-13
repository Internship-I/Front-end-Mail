import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home/index_home_screen.dart';
import '../../shared/widget/botttom_navbar.dart';
import '../../presentation/screen/profile_screen.dart';
import '../widgets/greeting_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    _HomePage(),
    ProfileScreenNew(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

//
// ✅ Tab Pertama (Home)
//
class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Scroll agar tidak overflow
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const GreetingSection(),

              // 🔹 Horizontal scroll image card
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    ImageCard(
                      title: "PT Pos Indonesia",
                      imagePath: "assets/images/postempat.jpg",
                    ),
                    SizedBox(width: 16),
                    ImageCard(
                      title: "Danantara",
                      imagePath: "assets/images/danantaratempat.jpg",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Featured Section
              const FeaturedSection(),

              // 🔹 Banner di bawah Featured Section
              const SizedBox(height: 20),
              const RoundedBanner(
                title: "Aplikasi Untuk Kurir Pengiriman Paket",
                subtitle: "Safe and reliable service.",
                imagePath: "assets/images/logo.png",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),

        // 🔹 Logo section tetap di atas
        const LogoSection(),
      ],
    );
  }
}

//
// 🔹 Banner Eksklusif
//
class RoundedBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const RoundedBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 Banner utama
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // 🔹 Logo elegan
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B1650), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // 🔹 Teks elegan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1650),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.65),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 🔹 Kotak kecil "IKLAN" di pojok kanan atas
        Positioned(
          right: 28,
          top: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF00AEEF), // biru elegan
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "IKLAN",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
