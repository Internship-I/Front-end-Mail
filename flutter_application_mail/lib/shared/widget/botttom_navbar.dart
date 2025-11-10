import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // ⬅️ penting biar lingkaran tidak terpotong
        children: [
          // Bottom Navigation Bar
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: widget.currentIndex,
            selectedItemColor: const Color(0xFF0B1650),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (index != 1) widget.onTap(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: '',
              ),
            ],
          ),

          // Tombol Tengah (Profile)
          Positioned(
            bottom: 10, // ⬅️ POSISI DITURUNKAN agar bulatnya turun
            child: GestureDetector(
              onTap: () => widget.onTap(1),
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: widget.currentIndex == 1
                      ? const Color(0xFF0B1650)
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0B1650), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person,
                  color: widget.currentIndex == 1
                      ? Colors.white
                      : const Color(0xFF0B1650),
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
