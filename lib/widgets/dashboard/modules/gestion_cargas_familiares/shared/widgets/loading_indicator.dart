import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60, height: 60,
            child: CircularProgressIndicator(strokeWidth: 4, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor)),
          ),
          const SizedBox(height: 24),
          Text(message ?? 'Cargando...', style: TextStyle(color: AppTheme.getTextSecondary(context), fontSize: 16)),
        ],
      ),
    );
  }
}