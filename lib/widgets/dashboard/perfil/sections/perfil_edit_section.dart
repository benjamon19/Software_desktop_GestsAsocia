// lib/widgets/dashboard/perfil/sections/perfil_edit_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_theme.dart';

class PerfilEditSection extends StatelessWidget {
  const PerfilEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      final currentUser = authController.currentUser.value;
      
      if (currentUser == null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Cargando información...',
                style: TextStyle(
                  color: AppTheme.getTextSecondary(context),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            _buildPhotoSection(context, authController),
            const SizedBox(height: 20),
            _buildEditableInfoCard(context, currentUser),
            const SizedBox(height: 20),
            _buildPasswordCard(context),
          ],
        ),
      );
    });
  }

  Widget _buildPhotoSection(BuildContext context, AuthController authController) {
    return _buildCard(
      context,
      child: Column(
        children: [
          Text(
            'Foto de Perfil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.getBorderLight(context),
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Text(
                    authController.userDisplayName.isNotEmpty
                        ? authController.userDisplayName[0].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.getSurfaceColor(context),
                      width: 3,
                    ),
                  ),
                  child: IconButton(
                    onPressed: _showInfoSnackbar,
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Haz clic en el ícono para cambiar tu foto',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextSecondary(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoCard(BuildContext context, dynamic currentUser) {
    return _buildCardWithHeader(
      context,
      icon: Icons.edit_outlined,
      title: 'Información Editable',
      color: AppTheme.primaryColor,
      child: Column(
        children: [
          _buildField(context, 'Teléfono', currentUser.telefono, Icons.phone_outlined, editable: true),
          const SizedBox(height: 16),
          _buildField(context, 'Email', currentUser.email, Icons.email_outlined),
          const SizedBox(height: 16),
          _buildField(context, 'RUT', _formatRut(currentUser.rut), Icons.credit_card_outlined),
        ],
      ),
    );
  }

  Widget _buildPasswordCard(BuildContext context) {
    return _buildCardWithHeader(
      context,
      icon: Icons.lock_outlined,
      title: 'Cambiar Contraseña',
      color: const Color(0xFFF59E0B),
      child: Column(
        children: [
          _buildPasswordField(context, 'Contraseña Actual'),
          const SizedBox(height: 16),
          _buildPasswordField(context, 'Nueva Contraseña'),
          const SizedBox(height: 16),
          _buildPasswordField(context, 'Confirmar Contraseña'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showInfoSnackbar,
              icon: const Icon(Icons.save, size: 20),
              label: const Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
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
      child: child,
    );
  }

  Widget _buildCardWithHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
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
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context, String label, String value, IconData icon, {bool editable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.getTextSecondary(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: editable 
                ? AppTheme.getInputBackground(context)
                : AppTheme.getInputBackground(context).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.getBorderLight(context)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.getTextSecondary(context)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: editable 
                        ? AppTheme.getTextPrimary(context)
                        : AppTheme.getTextSecondary(context),
                  ),
                ),
              ),
              if (!editable)
                Icon(Icons.lock_outline, size: 16, color: AppTheme.getTextSecondary(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.getTextSecondary(context),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          style: TextStyle(color: AppTheme.getTextPrimary(context)),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline, size: 20, color: AppTheme.getTextSecondary(context)),
            suffixIcon: Icon(Icons.visibility_off, size: 20, color: AppTheme.getTextSecondary(context)),
            filled: true,
            fillColor: AppTheme.getInputBackground(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  String _formatRut(String rut) {
    String cleanRut = rut.replaceAll(RegExp(r'[.-]'), '');
    if (cleanRut.length < 8) return rut;
    
    String numero = cleanRut.substring(0, cleanRut.length - 1);
    String dv = cleanRut.substring(cleanRut.length - 1);
    
    String formatted = '';
    for (int i = numero.length; i > 0; i -= 3) {
      int start = i - 3 < 0 ? 0 : i - 3;
      String group = numero.substring(start, i);
      formatted = formatted.isEmpty ? group : '$group.$formatted';
    }
    
    return '$formatted-$dv';
  }

  void _showInfoSnackbar() {
    Get.snackbar(
      'Información', 
      'Solo diseño - Sin funcionalidad',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withValues(alpha: 0.1),
      colorText: Colors.blue,
      margin: const EdgeInsets.all(16),
    );
  }
}