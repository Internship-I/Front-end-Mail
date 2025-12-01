import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  int _selectedDateIndex = 0; // State untuk filter tanggal

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0A1D37);
    const Color softGrey = Color(0xFFF5F7FA);
    const Color successGreen = Color(0xFF00C853);

    return Container(
      // Padding bawah 0 agar list mentok ke bawah (padat)
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================
          // 1. FILTER TANGGAL (Sama dengan ItemWidget)
          // ============================================
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final dayName = [
                  "Sen",
                  "Sel",
                  "Rab",
                  "Kam",
                  "Jum",
                  "Sab",
                  "Min"
                ];
                final dateNum = (24 + index).toString();
                bool isSelected = index == _selectedDateIndex;

                return GestureDetector(
                  onTap: () => setState(() => _selectedDateIndex = index),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? navy : softGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName[index % 7],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dateNum,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isSelected ? Colors.white : navy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // ============================================
          // 2. DASHBOARD SUMMARY (STATISTIK HARIAN)
          // ============================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Daily Performance",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: navy)),
                  Text("Target achievement",
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: Colors.grey[500])),
                ],
              ),
              // Percentage Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 14, color: successGreen),
                    const SizedBox(width: 4),
                    Text("85%",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: successGreen)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress Bar
          Stack(
            children: [
              Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: softGrey,
                      borderRadius: BorderRadius.circular(10))),
              Container(
                  height: 6,
                  width: 220,
                  decoration: BoxDecoration(
                      color: navy, borderRadius: BorderRadius.circular(10))),
            ],
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: Colors.grey.withOpacity(0.2)),

          // ============================================
          // 3. LIST PENGIRIMAN (TIMELINE STYLE)
          // ============================================
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildTimelineItem(
                    time: "08:30 AM",
                    title: "Drop Point Center",
                    subtitle: "Scan In - 4 Packages",
                    status: "Done",
                    navy: navy,
                    isLast: false),
                _buildTimelineItem(
                    time: "09:15 AM",
                    title: "PT. Maju Mundur",
                    subtitle: "Delivered - Resi #8821",
                    status: "Done",
                    navy: navy,
                    isLast: false),
                _buildTimelineItem(
                    time: "10:45 AM",
                    title: "Apartemen Grand",
                    subtitle: "Delivered - Resi #8822",
                    status: "Done",
                    navy: navy,
                    isLast: false),
                _buildTimelineItem(
                    time: "11:20 AM",
                    title: "Rumah Bpk. Budi",
                    subtitle: "Failed - House Empty",
                    status: "Failed",
                    navy: navy,
                    isLast: false),
                _buildTimelineItem(
                    time: "01:00 PM",
                    title: "Kantor Danantara",
                    subtitle: "Pickup - 2 Documents",
                    status: "Process",
                    navy: navy,
                    isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String subtitle,
    required String status,
    required Color navy,
    required bool isLast,
  }) {
    Color statusColor;
    IconData statusIcon;

    if (status == "Done") {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (status == "Failed") {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.local_shipping;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TIMELINE SECTION
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 4),
                // Garis Timeline
                Expanded(
                  child: isLast
                      ? const SizedBox()
                      : Container(
                          width: 2,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                ),
              ],
            ),
          ),

          // 2. ICON SECTION
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                ),
                child: Icon(statusIcon, size: 16, color: statusColor),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // 3. CONTENT SECTION
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16), // Jarak antar item
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  // Status Chip Kecil
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
