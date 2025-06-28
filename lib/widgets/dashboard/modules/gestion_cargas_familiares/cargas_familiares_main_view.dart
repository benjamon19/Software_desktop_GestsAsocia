import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_theme.dart';
import '../../../../controllers/cargas_familiares_controller.dart';
import 'sections/search_section/search_section.dart';
import 'sections/cargas_list_section/cargas_list_section.dart';
import 'sections/carga_detail_section/carga_detail_section.dart';
import 'sections/actions_section/actions_section.dart';
import 'sections/empty_state_section/empty_state_section.dart';
import 'shared/widgets/loading_indicator.dart';

class CargasFamiliaresMainView extends StatelessWidget {
  const CargasFamiliaresMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final CargasFamiliaresController controller = Get.put(CargasFamiliaresController());

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, controller),
          const SizedBox(height: 30),
          
          // Solo mostrar búsqueda en vista de lista
          Obx(() => controller.isListView 
            ? Column(
                children: [
                  SearchSection(controller: controller),
                  const SizedBox(height: 30),
                ],
              )
            : const SizedBox.shrink(),
          ),
          
          // Contenido principal
          Expanded(
            child: Obx(() => _buildMainContent(context, controller)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CargasFamiliaresController controller) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título y subtítulo
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.currentTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getSubtitle(controller),
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextSecondary(context),
              ),
            ),
          ],
        ),
        
        // Acciones del header
        _buildHeaderActions(context, controller),
      ],
    ));
  }

  String _getSubtitle(CargasFamiliaresController controller) {
    if (controller.isDetailView) {
      return 'Información completa y gestión de la carga familiar';
    } else {
      return 'Gestiona todas las cargas familiares del sistema';
    }
  }

  Widget _buildHeaderActions(BuildContext context, CargasFamiliaresController controller) {
    return Obx(() => Row(
      children: [
        // Botón volver (solo en vista detalle)
        if (controller.isDetailView)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              onPressed: controller.backToList,
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text('Volver'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.getTextSecondary(context),
                side: BorderSide(color: AppTheme.getBorderLight(context)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        
        // Botón limpiar (solo en vista lista con búsqueda)
        if (controller.isListView && controller.hasSearchQuery)
          Padding(
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
          ),
        
        // Botón nueva carga (siempre visible)
        ElevatedButton.icon(
          onPressed: controller.addNewCarga,
          icon: const Icon(Icons.person_add, size: 20),
          label: const Text('Nueva Carga Familiar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    ));
  }

  Widget _buildMainContent(BuildContext context, CargasFamiliaresController controller) {
    if (controller.isLoading.value) {
      return const LoadingIndicator(message: 'Cargando cargas familiares...');
    }
    
    // Vista de detalle (como el profile de asociados)
    if (controller.isDetailView && controller.hasSelectedCarga) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detalle de la carga (2/3 del ancho)
          Expanded(
            flex: 2,
            child: CargaDetailSection(
              carga: controller.selectedCarga.value!,
              onEdit: controller.editCarga,
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Panel de acciones (1/3 del ancho)
          Expanded(
            flex: 1,
            child: ActionsSection(
              carga: controller.selectedCarga.value!,
              controller: controller,
            ),
          ),
        ],
      );
    }
    
    // Vista de lista (todas las cargas)
    if (controller.filteredCargas.isNotEmpty) {
      return CargasListSection(
        cargas: controller.filteredCargas,
        onCargaSelected: controller.selectCarga,
        onFilterChanged: controller.setFilter,
        onStatusChanged: controller.setStatus,
        selectedFilter: controller.selectedFilter.value,
        selectedStatus: controller.selectedStatus.value,
      );
    }
    
    // Estado vacío
    return EmptyStateSection(
      hasSearchQuery: controller.hasSearchQuery,
      searchQuery: controller.searchQuery.value,
      onNewCarga: controller.addNewCarga,
    );
  }
}