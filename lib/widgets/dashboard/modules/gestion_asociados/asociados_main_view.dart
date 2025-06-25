import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_theme.dart';
import '../../../../controllers/asociados_controller.dart';
import 'sections/search_section/search_section.dart';
import 'sections/profile_section/profile_section.dart';
import 'sections/actions_section/actions_section.dart';
import 'sections/empty_state_section/empty_state_section.dart';
import 'shared/widgets/loading_indicator.dart';

class AsociadosMainView extends StatelessWidget {
  const AsociadosMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final AsociadosController controller = Get.find<AsociadosController>();

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, controller),
          const SizedBox(height: 30),
          
          // Sección de búsqueda
          SearchSection(controller: controller),
          
          const SizedBox(height: 30),
          
          // Contenido principal dinámico
          Expanded(
            child: Obx(() => _buildMainContent(context, controller)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AsociadosController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gestión de Asociados',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Busca y gestiona la información de los asociados',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ],
        ),
        _buildHeaderActions(context, controller),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context, AsociadosController controller) {
    return Row(
      children: [
        // Botón limpiar (condicional)
        Obx(() => controller.hasSelectedAsociado
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: OutlinedButton.icon(
                  onPressed: controller.clearSearch,
                  icon: const Icon(Icons.clear, size: 18),
                  label: const Text('Limpiar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.getTextSecondary(context),
                    side: BorderSide(color: AppTheme.getBorderLight(context)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        ),
        
        // Botón nuevo asociado
        ElevatedButton.icon(
          onPressed: controller.newAsociado,
          icon: const Icon(Icons.person_add, size: 20),
          label: const Text('Nuevo Asociado'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, AsociadosController controller) {
    if (controller.isLoading.value) {
      return const LoadingIndicator();
    }
    
    if (controller.hasSelectedAsociado) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Perfil del asociado (2/3 del ancho)
          Expanded(
            flex: 2,
            child: ProfileSection(
              asociado: controller.currentAsociado!,
              onEdit: controller.editAsociado,
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Panel de acciones (1/3 del ancho)
          Expanded(
            flex: 1,
            child: ActionsSection(
              asociado: controller.currentAsociado!,
              controller: controller,
            ),
          ),
        ],
      );
    }
    
    return const EmptyStateSection();
  }
}