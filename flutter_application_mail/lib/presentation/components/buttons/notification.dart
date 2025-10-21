import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasNotification; // 🔔 indikator notifikasi

  const NotificationIcon({
    super.key,
    required this.onTap,
    this.hasNotification = true, // default ada notifikasi
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 🔔 Tombol Lonceng
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [],
          ),
          child: IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.notifications_rounded,
              color: Color.fromARGB(255, 255, 251, 6),
              size: 28,
            ),
            splashRadius: 26,
          ),
        ),

        // 🔴 Titik merah kecil di pojok kanan atas
        if (hasNotification)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 0, 0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
