import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';

class EmptyStateSection extends StatelessWidget {
  final bool hasSearchQuery;
  final String searchQuery;
  final VoidCallback onNewCarga;

  const EmptyStateSection({super.key, this.hasSearchQuery = false, this.searchQuery = '', required this.onNewCarga});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: hasSearchQuery 
                  ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
                  : AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasSearchQuery ? Icons.search_off : Icons.family_restroom_outlined,
              size: 80,
              color: hasSearchQuery ? const Color(0xFFF59E0B) : AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            hasSearchQuery ? 'No se encontraron resultados' : 'No hay cargas familiares',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimary(context)),
          ),
          const SizedBox(height: 12),
          Text(
            hasSearchQuery 
                ? 'No se encontraron cargas para "$searchQuery"'
                : 'Aún no hay cargas familiares registradas',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppTheme.getTextSecondary(context)),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onNewCarga,
            icon: const Icon(Icons.person_add, size: 20),
            label: Text(hasSearchQuery ? 'Agregar Nueva Carga' : 'Agregar Primera Carga'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}