import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_theme.dart';
import '../../../../../../controllers/asociados_controller.dart';
import 'components/rut_search_field.dart';
import 'components/biometric_button.dart';
import 'components/qr_scanner_button.dart';

class SearchSection extends StatelessWidget {
  final AsociadosController controller;

  const SearchSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          const SizedBox(height: 16),
          _buildSearchControls(context),
          const SizedBox(height: 12),
          _buildHelpText(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Text(
      'Buscar Asociado',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppTheme.getTextPrimary(context),
      ),
    );
  }

  Widget _buildSearchControls(BuildContext context) {
    return Obx(() => Row(
      children: [
        // Campo principal de búsqueda
        Expanded(
          flex: 3,
          child: RutSearchField(
            onSearch: controller.searchAsociado,
            isLoading: controller.isLoading.value,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Botón biométrico
        BiometricButton(
          onPressed: controller.isLoading.value ? null : controller.biometricSearch,
          isLoading: controller.isLoading.value,
        ),
        
        const SizedBox(width: 8),
        
        // Botón QR Scanner
        QrScannerButton(
          onPressed: controller.isLoading.value ? null : controller.qrCodeSearch,
          isLoading: controller.isLoading.value,
        ),
      ],
    ));
  }

  Widget _buildHelpText(BuildContext context) {
    return Text(
      'Ingresa el RUT (ej: 12345678-9), usa la huella digital o escanea el código QR del asociado',
      style: TextStyle(
        fontSize: 14,
        color: AppTheme.getTextSecondary(context),
      ),
    );
  }
}