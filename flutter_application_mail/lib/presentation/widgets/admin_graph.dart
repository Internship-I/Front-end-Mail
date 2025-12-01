import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../module/AdminDashboard/service/admin_service.dart';
import '../../module/AdminDashboard/model/response/admin_model_response.dart';

class AdminGraph extends StatefulWidget {
  const AdminGraph({super.key});

  @override
  State<AdminGraph> createState() => _AdminGraphState();
}

class _AdminGraphState extends State<AdminGraph>
    with SingleTickerProviderStateMixin {
  List<double> chartData = [0, 0, 0, 0, 0];
  bool loading = true;

  late AnimationController _controller;
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final List<Transaction> data =
          await AdminService().getAllTransaction(); // ← sama seperti summary

      // Ambil hari Sen–Jum minggu ini
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

      List<double> weekly = [0, 0, 0, 0, 0];

      for (var trx in data) {
        if (trx.createdAt == null) continue;

        final tgl = DateTime.parse(trx.createdAt!);

        for (int i = 0; i < 5; i++) {
          final currentDay = startOfWeek.add(Duration(days: i));

          if (tgl.year == currentDay.year &&
              tgl.month == currentDay.month &&
              tgl.day == currentDay.day) {
            weekly[i] += 1;
          }
        }
      }

      setState(() {
        chartData = weekly;
        loading = false;
      });

      _buildAnimations();
      _controller.forward();
    } catch (e) {
      print("Error chart: $e");
    }
  }

  void _buildAnimations() {
    final maxVal = chartData.reduce((a, b) => a > b ? a : b);

    _animations = chartData.map((val) {
      final percent = (maxVal == 0 ? 0.0 : val / maxVal);
      return Tween<double>(begin: 0, end: percent).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> days = ["Sen", "Sel", "Rab", "Kam", "Jum"];

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final maxVal = chartData.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tren Penerima Mingguan",
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(chartData.length, (i) {
              final barValue = chartData[i];
              final barPercent = ((maxVal == 0) ? 0.0 : barValue / maxVal)
                  .clamp(0.0, 1.0) as double;
              final barHeight = 120.0 * barPercent;

              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: barHeight,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF144272),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      days[i],
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
