import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

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
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bienvenido de vuelta, aquí está tu resumen del día',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
          const SizedBox(height: 30),
          
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Total Asociados',
                  '0',
                  Icons.people_outline,
                  const Color(0xFF4299E1),
                  const Color(0xFFEBF8FF),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Citas Hoy',
                  '0',
                  Icons.calendar_today_outlined,
                  const Color(0xFF48BB78),
                  const Color(0xFFF0FDF4),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Nuevos Registros',
                  '0',
                  Icons.person_add_outlined,
                  const Color(0xFF9F7AEA),
                  const Color(0xFFF9F5FF),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Alertas',
                  '0',
                  Icons.warning_amber_outlined,
                  const Color(0xFFF56565),
                  const Color(0xFFFFF5F5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Recent Activity
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
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
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Actividad Reciente',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.getTextPrimary(context),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          'Ver todo',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: AppTheme.getTextSecondary(context),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay actividad reciente',
                            style: TextStyle(
                              color: AppTheme.getTextSecondary(context),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title, 
    String value, 
    IconData icon, 
    Color iconColor, 
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? iconColor.withValues(alpha: 0.2)
                  : bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
        ],
      ),
    );
  }
}