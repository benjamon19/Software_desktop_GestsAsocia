import 'package:flutter/material.dart';
import '../../../../../../../controllers/cargas_familiares_controller.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/action_button.dart';

class SpecialActions extends StatelessWidget {
  final CargasFamiliaresController controller;

  const SpecialActions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Herramientas'),
        const SizedBox(height: 12),
        ActionButton(
          icon: Icons.medical_services,
          title: 'Info Médica',
          subtitle: 'Actualizar datos médicos',
          color: const Color(0xFF10B981),
          onPressed: controller.updateMedicalInfo,
        ),
        const SizedBox(height: 8),
        ActionButton(
          icon: Icons.badge,
          title: 'Generar Carnet',
          subtitle: 'Crear carnet familiar',
          color: const Color(0xFF059669),
          onPressed: controller.generateCarnet,
        ),
        const SizedBox(height: 8),
        ActionButton(
          icon: Icons.history,
          title: 'Ver Historial',
          subtitle: 'Historial de cambios',
          color: const Color(0xFF6B7280),
          onPressed: controller.viewHistory,
        ),
      ],
    );
  }
}