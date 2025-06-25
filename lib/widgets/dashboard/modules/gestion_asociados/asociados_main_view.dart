import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_theme.dart';
import '../../../../controllers/asociados_controller.dart';
import 'components/asociado_search_bar.dart';
import 'components/asociado_profile_card.dart';
import 'components/asociado_actions_panel.dart';

class AsociadosMainView extends StatelessWidget {
  const AsociadosMainView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el controlador (se crea una sola vez y persiste)
    final AsociadosController controller = Get.find<AsociadosController>();

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(context, controller),
          
          const SizedBox(height: 30),
          
          // Barra de búsqueda con botones
          Obx(() => AsociadoSearchBar(
            onSearch: controller.searchAsociado,
            onBiometricScan: controller.biometricSearch,
            onQRCodeScan: controller.qrCodeSearch,
            isLoading: controller.isLoading.value,
          )),
          
          const SizedBox(height: 30),
          
          // Contenido principal
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
        // Botón de nuevo asociado
        Row(
          children: [
            // Botón para limpiar búsqueda (solo si hay asociado seleccionado)
            Obx(() => controller.hasSelectedAsociado
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: OutlinedButton.icon(
                      onPressed: controller.clearSearch,
                      icon: const Icon(Icons.clear, size: 18),
                      label: const Text('Limpiar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.getTextSecondary(context),
                        side: BorderSide(
                          color: AppTheme.getBorderLight(context),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            ),
            
            // Botón de nuevo asociado
            ElevatedButton.icon(
              onPressed: controller.newAsociado,
              icon: const Icon(Icons.person_add, size: 20),
              label: const Text('Nuevo Asociado'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, AsociadosController controller) {
    if (controller.isLoading.value) {
      return _buildLoadingState(context);
    }
    
    if (controller.hasSelectedAsociado) {
      return _buildAsociadoProfile(controller);
    }
    
    return _buildEmptyState(context);
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Buscando asociado...',
            style: TextStyle(
              color: AppTheme.getTextSecondary(context),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAsociadoProfile(AsociadosController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Perfil del asociado
        Expanded(
          flex: 2,
          child: AsociadoProfileCard(
            asociado: controller.currentAsociado!,
            onEdit: controller.editAsociado,
          ),
        ),
        
        const SizedBox(width: 20),
        
        // Panel de acciones
        Expanded(
          flex: 1,
          child: AsociadoActionsPanel(
            asociado: controller.currentAsociado!,
            onEdit: controller.editAsociado,
            onDelete: controller.deleteAsociado,
            onViewHistory: controller.viewHistory,
            onAddCarga: controller.addCarga,
            onGenerateQR: controller.generateQR,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Buscar Asociado',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Ingresa el RUT del asociado, usa la huella digital\no escanea el código QR para buscar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.getTextSecondary(context),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureCard(
                context,
                icon: Icons.fingerprint,
                title: 'Huella Digital',
                description: 'Autenticación biométrica',
              ),
              const SizedBox(width: 20),
              _buildFeatureCard(
                context,
                icon: Icons.qr_code_scanner,
                title: 'Código QR',
                description: 'Escaneo rápido',
              ),
              const SizedBox(width: 20),
              _buildFeatureCard(
                context,
                icon: Icons.badge,
                title: 'Búsqueda por RUT',
                description: 'Búsqueda manual',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getTextSecondary(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}