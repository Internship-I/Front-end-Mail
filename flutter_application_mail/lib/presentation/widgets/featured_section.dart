import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_routes.dart';
import 'course_card.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Featured",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180, // biar card muat bagus
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              CourseCard(
                title: "Data Penerima",
                subtitle: "Kurir",
                imagePath: "assets/images/kurirhome.png",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.dashboard);
                },
              ),
              const SizedBox(width: 12),
              CourseCard(
                title: "Dashboard",
                subtitle: "Admin",
                imagePath: "assets/images/admin.png",
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
