import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'content/stats_cards_section.dart';
import 'content/charts_grid_section.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen General', 
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: AppTheme.getTextPrimary(context)
            )
          ),
          const SizedBox(height: 8),
          Text(
            'Bienvenido de vuelta, aquí está tu resumen del día', 
            style: TextStyle(
              fontSize: 14, 
              color: AppTheme.getTextSecondary(context)
            )
          ),
          const SizedBox(height: 30),
          
          // Sección de tarjetas estadísticas
          const StatsCardsSection(),
          const SizedBox(height: 30),

          // Sección de gráficos
          const Expanded(
            child: ChartsGridSection(),
          ),
        ],
      ),
    );
  }
}