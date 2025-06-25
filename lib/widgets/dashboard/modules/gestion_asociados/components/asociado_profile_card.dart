import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';
import 'asociado_header_card.dart';
import 'asociado_personal_info.dart';
import 'asociado_family_charges.dart';

class AsociadoProfileCard extends StatelessWidget {
  final Map<String, dynamic> asociado;
  final VoidCallback onEdit;

  const AsociadoProfileCard({
    super.key,
    required this.asociado,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con foto y datos básicos
          AsociadoHeaderCard(
            asociado: asociado,
            onEdit: onEdit,
          ),
          
          // Contenido scrolleable
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información personal
                    AsociadoPersonalInfo(asociado: asociado),
                    
                    // Cargas familiares
                    AsociadoFamilyCharges(asociado: asociado),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}