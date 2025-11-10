import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../routes/router.dart';
import 'module/Dashboard/controller/transaction_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionController()),
      ],
      child: const MyApp(),
    ),
  );
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

      // ✅ route awal aplikasi
      initialRoute: AppRoutes.intro,

      // ✅ gunakan route generator dari AppRoutes
      onGenerateRoute: AppRoutes.generateRoute,

      // opsional: fallback jika route tidak ditemukan
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Halaman tidak ditemukan")),
          ),
        );
      },
    );
  }
}
