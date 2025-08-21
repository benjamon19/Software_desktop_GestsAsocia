import 'package:flutter/material.dart';

class DashboardData {
  // Elementos del menú lateral
  static const List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_outlined,
    },
    {
      'title': 'Asociados',
      'icon': Icons.people_outline,
    },
    {
      'title': 'Cargas Familiares',
      'icon': Icons.family_restroom_outlined,
    },
    {
      'title': 'Historial Clínico',
      'icon': Icons.medical_information_outlined,
    },
    {
      'title': 'Reserva de Horas',
      'icon': Icons.schedule_outlined,
    },
  ];

  // Nombres de meses
  static const List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  // Obtener nombre del mes
  static String getMonthName(int month) {
    return monthNames[month - 1];
  }

  // Formatear fecha
  static String getFormattedDate() {
    final now = DateTime.now();
    return '${now.day} de ${getMonthName(now.month)}, ${now.year}';
  }
}