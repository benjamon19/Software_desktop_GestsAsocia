import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_theme.dart';
import '../../../../controllers/asociados_controller.dart';
import '../../../../models/asociado.dart';
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

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda que usa todo el ancho disponible
            SearchSection(controller: controller),
            
            const SizedBox(height: 20),
            
            // Contenido principal dinámico
            Expanded(
              child: Obx(() => _buildMainContent(context, controller)),
            ),
          ],
        ),
      ),

      // Botones flotantes - mostrar botón volver cuando hay asociado seleccionado
      floatingActionButton: Obx(() => controller.hasSelectedAsociado 
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botón volver a la lista
                FloatingActionButton(
                  heroTag: "back",
                  mini: true,
                  onPressed: () => _goBackToList(controller),
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                  tooltip: 'Volver a la lista',
                  child: const Icon(Icons.arrow_back, size: 20)
                ),
                const SizedBox(width: 10),
                // Botón agregar asociado
                FloatingActionButton(
                  heroTag: "add",
                  onPressed: controller.newAsociado,
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  child: const Icon(Icons.person_add, size: 24),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: controller.newAsociado,
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 8,
              child: const Icon(Icons.person_add, size: 24),
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              asociado: _asociadoToMap(controller.currentAsociado!),
              onEdit: controller.editAsociado,
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Panel de acciones (1/3 del ancho)
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

    // Si hay asociados pero no hay uno seleccionado, mostrar lista
    if (controller.hasAsociados) {
      return _buildAsociadosList(context, controller);
    }

    // Si no hay asociados, mostrar empty state
    return const EmptyStateSection();
  }

  Widget _buildAsociadosList(BuildContext context, AsociadosController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header de la lista con botón de recarga
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.getSurfaceColor(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.people,
                color: AppTheme.primaryColor,
                size: 24,
              ),
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
              // Botón de recarga reactivo
              Obx(() => IconButton(
                onPressed: controller.isLoading.value 
                    ? null 
                    : () => controller.loadAsociados(),
                icon: controller.isLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                        ),
                      )
                    : Icon(
                        Icons.refresh,
                        color: AppTheme.primaryColor,
                      ),
                tooltip: 'Recargar lista',
              )),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${controller.totalAsociados} asociados',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Lista de asociados
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getSurfaceColor(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.asociados.length,
              separatorBuilder: (context, index) => Divider(
                color: AppTheme.getBorderLight(context),
                thickness: 1,
                height: 1,
              ),
              itemBuilder: (context, index) {
                final asociado = controller.asociados[index];
                return _buildAsociadoListItem(context, asociado, controller);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAsociadoListItem(BuildContext context, Asociado asociado, AsociadosController controller) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        controller.selectedAsociado.value = asociado;
        controller.searchQuery.value = asociado.rut;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar con iniciales
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${asociado.nombre[0]}${asociado.apellido[0]}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Información principal
            Expanded(
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
                      Icon(
                        Icons.badge,
                        size: 14,
                        color: AppTheme.getTextSecondary(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        asociado.rutFormateado,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.getTextSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.email,
                        size: 14,
                        color: AppTheme.getTextSecondary(context),
                      ),
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
            ),
            
            const SizedBox(width: 16),
            
            // Plan y estado
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getPlanColor(asociado.plan).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    asociado.plan,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getPlanColor(asociado.plan),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: asociado.isActive ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      asociado.estado,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.getTextSecondary(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(width: 8),
            
            // Flecha
            Icon(
              Icons.chevron_right,
              color: AppTheme.getTextSecondary(context),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPlanColor(String plan) {
    switch (plan.toLowerCase()) {
      case 'básico':
        return Colors.blue;
      case 'premium':
        return Colors.orange;
      case 'vip':
        return Colors.purple;
      case 'empresarial':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Método para volver a la lista
  void _goBackToList(AsociadosController controller) {
    controller.selectedAsociado.value = null;
    controller.searchQuery.value = '';
  }

  // Método helper para convertir Asociado a Map (solución temporal)
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