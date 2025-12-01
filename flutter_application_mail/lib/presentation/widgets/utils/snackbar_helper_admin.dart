import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccess(BuildContext context, String message) {
    _showBaseSnackbar(
      context,
      message,
      backgroundColor: const Color(0xFF0A2647), // navy elegan
      textColor: Colors.white,
      icon: Icons.check_circle_rounded,
    );
  }

  static void showError(BuildContext context, String message) {
    _showBaseSnackbar(
      context,
      message,
      backgroundColor: Colors.red[600]!,
      textColor: Colors.white,
      icon: Icons.error_outline_rounded,
    );
  }

  static void _showBaseSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
