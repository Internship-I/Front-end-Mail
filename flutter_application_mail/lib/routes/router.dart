import 'package:flutter/material.dart';
import '../presentation/screen/intro_page.dart';
import '../presentation/screen/login_screen.dart';
import '../presentation/screen/home_screen.dart';
import '../presentation/screen/dashboard.dart';
import '../presentation/screen/dashboard_admin.dart';

class AppRoutes {
  static const String intro = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String adminDashboard = '/adminDashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboardApp());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const CourierDashboard());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Halaman tidak ditemukan")),
          ),
        );
    }
  }
}
