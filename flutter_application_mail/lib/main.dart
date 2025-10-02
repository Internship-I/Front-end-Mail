import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/app_routes.dart';
import 'presentation/screen/dashboard.dart';
import 'presentation/screen/intro_page.dart';
import 'presentation/screen/login_screen.dart';
import 'presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mail App",
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: AppRoutes.intro,
      routes: {
        AppRoutes.intro: (context) => const IntroPage(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.dashboard: (context) => const CourierDashboard(),
      },
    );
  }
}
