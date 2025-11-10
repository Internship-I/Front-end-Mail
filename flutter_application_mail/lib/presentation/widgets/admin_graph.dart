import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminGraph extends StatefulWidget {
  const AdminGraph({super.key});

  @override
  State<AdminGraph> createState() => _AdminGraphState();
}

class _AdminGraphState extends State<AdminGraph>
    with SingleTickerProviderStateMixin {
  final List<double> chartData = [30, 45, 25, 60, 40];
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    final maxVal = chartData.reduce((a, b) => a > b ? a : b);

    _animations = chartData.map((val) {
      final heightPercent = (val / (maxVal == 0 ? 1 : maxVal)).toDouble();
      return Tween<double>(begin: 0, end: heightPercent).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      );
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxVal = chartData.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tren Penerima (minggu ini)",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 12),

        // 🔹 Dibungkus Stack besar agar tooltip tidak terpotong
        SizedBox(
          height: 220, // lebih tinggi supaya tooltip muat
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(chartData.length, (i) {
                        final val = chartData[i];
                        final heightPercent = _animations[i].value;
                        final barHeight = 120 * heightPercent;

                        return Expanded(
                          child: MouseRegion(
                            onEnter: (_) => setState(() => hoveredIndex = i),
                            onExit: (_) => setState(() => hoveredIndex = null),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              clipBehavior: Clip.none,
                              children: [
                                // 🔹 Batang grafik
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  height: barHeight,
                                  decoration: BoxDecoration(
                                    color: hoveredIndex == i
                                        ? const Color(0xFF144272)
                                        : const Color(0xFF205295),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: hoveredIndex == i
                                        ? [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            )
                                          ]
                                        : [],
                                  ),
                                ),

                                // 🔹 Tooltip di atas batang
                                if (hoveredIndex == i)
                                  Positioned(
                                    bottom: barHeight + 20,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      opacity: hoveredIndex == i ? 1 : 0,
                                      child: Transform.scale(
                                        scale: 1.05,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Transaksi: ${val.toInt()}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Berhasil: ${(val * 0.9).toInt()}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              Text(
                                                "Gagal: ${(val * 0.1).toInt()}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                // 🔹 Label hari
                                Positioned(
                                  bottom: -20,
                                  child: Text(
                                    ["Sen", "Sel", "Rab", "Kam", "Jum"][i],
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
        Text(
          "Arahkan kursor ke batang grafik untuk melihat detail.",
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
