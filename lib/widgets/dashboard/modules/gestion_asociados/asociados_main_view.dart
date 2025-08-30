import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_theme.dart';
import '../../../../controllers/asociados_controller.dart';
import '../../../../models/asociado.dart';
import 'sections/search_section/search_section.dart'; // Asegúrate de que la ruta sea correcta
import 'sections/profile_section/profile_section.dart';
import 'sections/actions_section/actions_section.dart';
import 'sections/empty_state_section/empty_state_section.dart';
import 'shared/widgets/loading_indicator.dart';

class AsociadosMainView extends StatelessWidget {
  const AsociadosMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final AsociadosController controller = Get.find<AsociadosController>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchSection(controller: controller), // Usar tu SearchSection actualizada
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => _buildMainContent(context, controller)),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => _buildFloatingActionButton(controller)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // ============================================================================
  // FLOATING ACTION BUTTON
  // ============================================================================

  Widget _buildFloatingActionButton(AsociadosController controller) {
    if (!controller.hasSelectedAsociado) {
      // Vista principal: solo botón agregar
      return FloatingActionButton(
        onPressed: controller.newAsociado,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 8,
        child: const Icon(Icons.person_add, size: 24),
      );
    } else {
      // Vista de perfil: solo botón volver (mini)
      return FloatingActionButton(
        mini: true,
        onPressed: () => _goBackToList(controller),
        backgroundColor: Colors.grey[600],
        foregroundColor: Colors.white,
        tooltip: 'Volver a la lista',
        child: const Icon(Icons.arrow_back, size: 20),
      );
    }
  }

  // ============================================================================
  // CONTENIDO PRINCIPAL
  // ============================================================================

  Widget _buildMainContent(BuildContext context, AsociadosController controller) {
    if (controller.isLoading.value) {
      return const LoadingIndicator();
    }

    if (controller.hasSelectedAsociado) {
      return _buildProfileView(controller);
    }

    if (controller.hasAsociados) {
      return _buildAsociadosList(context, controller);
    }

    return const EmptyStateSection();
  }

  Widget _buildProfileView(AsociadosController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ProfileSection(
            asociado: _asociadoToMap(controller.currentAsociado!),
            onEdit: controller.editAsociado,
            onBack: () => _goBackToList(controller),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: ActionsSection(
            asociado: _asociadoToMap(controller.currentAsociado!),
            controller: controller,
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // LISTA DE ASOCIADOS
  // ============================================================================

  Widget _buildAsociadosList(BuildContext context, AsociadosController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListHeader(context, controller),
        const SizedBox(height: 20),
        _buildListContent(context, controller),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context, AsociadosController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.people, color: AppTheme.primaryColor, size: 24),
          const SizedBox(width: 12),
          Text(
            'Lista de Asociados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const Spacer(),
          _buildRefreshButton(controller),
          const SizedBox(width: 8),
          _buildCounterBadge(controller),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(AsociadosController controller) {
    return Obx(() => IconButton(
      onPressed: controller.isLoading.value
          ? null
          : () => controller.loadAsociados(),
      icon: controller.isLoading.value
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor),
              ),
            )
          : Icon(Icons.refresh, color: AppTheme.primaryColor),
      tooltip: 'Recargar lista',
    ));
  }

  Widget _buildCounterBadge(AsociadosController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(() {
        // Mostrar contador dinámico basado en la lista filtrada
        final total = controller.asociados.length;
        final totalGeneral = controller.totalAllAsociados;
        final texto = controller.searchQuery.value.isEmpty
            ? '$total asociados'
            : '$total de $totalGeneral asociados';
        
        return Text(
          texto,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryColor,
          ),
        );
      }),
    );
  }

  Widget _buildListContent(BuildContext context, AsociadosController controller) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getSurfaceColor(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Obx(() {
          // Forzar reconstrucción cuando cambie la lista filtrada
          final listaFiltrada = controller.asociados;
          return ListView.separated(
            key: ValueKey(listaFiltrada.length), // Key que cambia con la lista
            padding: const EdgeInsets.all(16),
            itemCount: listaFiltrada.length,
            separatorBuilder: (context, index) => Divider(
              color: AppTheme.getBorderLight(context),
              thickness: 1,
              height: 1,
            ),
            itemBuilder: (context, index) {
              if (index >= listaFiltrada.length) return const SizedBox.shrink();
              final asociado = listaFiltrada[index];
              return _buildAsociadoListItem(context, asociado, controller);
            },
          );
        }),
      ),
    );
  }

  // ============================================================================
  // ITEM DE LISTA
  // ============================================================================

  Widget _buildAsociadoListItem(
      BuildContext context, Asociado asociado, AsociadosController controller) {
    final hovered = false.obs;

    return ObxValue<RxBool>(
      (hover) => InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _selectAsociado(controller, asociado), // IMPORTANTE: Método actualizado
        onHover: (value) => hover.value = value,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hover.value
                ? AppTheme.primaryColor.withAlpha(10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildAvatar(context, asociado),
              const SizedBox(width: 16),
              _buildAsociadoInfo(context, asociado),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: AppTheme.getTextSecondary(context),
              ),
            ],
          ),
        ),
      ),
      hovered,
    );
  }

  Widget _buildAvatar(BuildContext context, Asociado asociado) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.getBorderLight(context),
              width: 1.5,
            ),
          ),
          child: Icon(Icons.person, size: 28, color: Colors.grey.shade600),
        ),
        // Indicador de estado
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: asociado.isActive
                  ? AppTheme.primaryColor
                  : Colors.grey.shade400,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAsociadoInfo(BuildContext context, Asociado asociado) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            asociado.nombreCompleto,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.badge,
                  size: 14, color: AppTheme.getTextSecondary(context)),
              const SizedBox(width: 4),
              Text(
                _formatearRut(asociado.rut),
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.email,
                  size: 14, color: AppTheme.getTextSecondary(context)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  asociado.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextSecondary(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // EVENT HANDLERS (ACTUALIZADOS)
  // ============================================================================

  void _selectAsociado(AsociadosController controller, Asociado asociado) {
    // Seleccionar el asociado
    controller.selectedAsociado.value = asociado;
    // Resetear completamente el estado de búsqueda
    controller.resetFilter();
    // Limpiar físicamente el campo RUT
    controller.clearSearchField();
  }

  void _goBackToList(AsociadosController controller) {
    // Limpiar la selección
    controller.selectedAsociado.value = null;
    // Resetear completamente el estado de búsqueda
    controller.resetFilter();
    // Limpiar físicamente el campo RUT
    controller.clearSearchField();
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  String _formatearRut(String rutRaw) {
    final clean = rutRaw.replaceAll(RegExp(r'[^0-9kK]'), '').toUpperCase();
    if (clean.isEmpty) return '';
    String cuerpo = clean.substring(0, clean.length - 1);
    String dv = clean.substring(clean.length - 1);
    cuerpo = cuerpo.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return '$cuerpo-$dv';
  }

  Map<String, dynamic> _asociadoToMap(Asociado asociado) {
    return {
      'rut': asociado.rut,
      'nombre': asociado.nombre,
      'apellido': asociado.apellido,
      'email': asociado.email,
      'telefono': asociado.telefono,
      'fechaNacimiento': asociado.fechaNacimientoFormateada,
      'direccion': asociado.direccion,
      'estadoCivil': asociado.estadoCivil,
      'fechaIngreso': asociado.fechaIngresoFormateada,
      'estado': asociado.estado,
      'plan': asociado.plan,
      'cargasFamiliares': [],
    };
  }
}