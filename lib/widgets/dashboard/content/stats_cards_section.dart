import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class StatsCardsSection extends StatelessWidget {
  const StatsCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'Pacientes Activos',
            value: '1,284',
            icon: Icons.people_outline,
            iconColor: const Color(0xFF4299E1),
            backgroundColor: const Color(0xFFEBF8FF),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Citas Hoy',
            value: '34',
            icon: Icons.calendar_today_outlined,
            iconColor: const Color(0xFF48BB78),
            backgroundColor: const Color(0xFFF0FDF4),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Nuevos Registros',
            value: '12',
            icon: Icons.person_add_outlined,
            iconColor: const Color(0xFF9F7AEA),
            backgroundColor: const Color(0xFFF9F5FF),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: StatCard(
            title: 'Alertas',
            value: '3',
            icon: Icons.warning_amber_outlined,
            iconColor: const Color(0xFFF56565),
            backgroundColor: const Color(0xFFFFF5F5),
          ),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3) 
                : Colors.grey.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header simple
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? iconColor.withValues(alpha: 0.2)
                  : backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          
          const SizedBox(height: 12),
          
          // Valor principal
          Text(
            value, 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.w800, 
              color: AppTheme.getTextPrimary(context),
              height: 1.0,
              letterSpacing: -0.5,
            )
          ),
          
          const SizedBox(height: 4),
          
          // Título
          Text(
            title, 
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600, 
              color: AppTheme.getTextSecondary(context),
              letterSpacing: 0.2,
            )
          ),
        ],
      ),
    );
  }
}