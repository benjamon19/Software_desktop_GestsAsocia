import 'package:flutter/material.dart';
import '../../../../../../../controllers/cargas_familiares_controller.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/action_button.dart';

class CrudActions extends StatelessWidget {
  final CargasFamiliaresController controller;

  const CrudActions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Gestión de Carga'),
        const SizedBox(height: 12),
        ActionButton(
          icon: Icons.edit,
          title: 'Editar Información',
          subtitle: 'Modificar datos de la carga',
          color: const Color(0xFF3B82F6),
          onPressed: controller.editCarga,
        ),
        const SizedBox(height: 8),
        ActionButton(
          icon: Icons.swap_horiz,
          title: 'Transferir Carga',
          subtitle: 'Mover a otro asociado',
          color: const Color(0xFF8B5CF6),
          onPressed: controller.transferCarga,
        ),
        const SizedBox(height: 8),
        ActionButton(
          icon: Icons.delete_outline,
          title: 'Eliminar Carga',
          subtitle: 'Remover del sistema',
          color: const Color(0xFFEF4444),
          onPressed: controller.deleteCarga,
        ),
      ],
    );
  }
}