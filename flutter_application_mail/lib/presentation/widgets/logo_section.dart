import 'package:flutter/material.dart';

//logo_section.dart → widget logo di pojok kiri atas (Pos & Danantara).

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset("assets/images/poslogo.png",
                width: 50, height: 50, fit: BoxFit.contain),
            const SizedBox(width: 10),
            Image.asset("assets/images/danantara.png",
                width: 60, height: 60, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
