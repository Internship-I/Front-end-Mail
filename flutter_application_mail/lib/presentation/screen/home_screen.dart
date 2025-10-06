import 'package:flutter/material.dart';
import '../../../config/app_routes.dart';
import '../widgets/home/index_home_screen.dart';
import '../components/buttons/whatsapp_button.dart'; // ✅ import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const WhatsAppButton(
        phoneNumber: "6282127854156",
        phone: '6282127854156', // ganti dengan nomor admin
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 70),
                const GreetingSection(),

                // Horizontal scroll image card
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
                const FeaturedSection(),
              ],
            ),

            // Logout button
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ),

            // Logo section
            const LogoSection(),
          ],
        ),
      ),
    );
  }
}
