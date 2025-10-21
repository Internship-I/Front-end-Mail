import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/poslogo.png",
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Image.asset(
            "assets/images/danantara.png",
            width: 55,
            height: 55,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
