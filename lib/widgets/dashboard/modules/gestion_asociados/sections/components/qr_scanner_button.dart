import 'package:flutter/material.dart';

class QrScannerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const QrScannerButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF8B5CF6);
    
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
            : const Icon(
                Icons.qr_code_scanner,
                color: color,
                size: 24,
              ),
        tooltip: 'Escanear código QR',
      ),
    );
  }
}