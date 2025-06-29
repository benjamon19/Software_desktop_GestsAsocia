import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_theme.dart';

class PerfilInfoSection extends StatelessWidget {
  const PerfilInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      final currentUser = authController.currentUser.value;
      
      if (currentUser == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta de información personal
            _buildInfoCard(
              context,
              title: 'Información Personal',
              icon: Icons.person_outline,
              children: [
                _buildInfoRow(
                  context,
                  label: 'Nombre Completo',
                  value: '${currentUser.nombre} ${currentUser.apellido}',
                  icon: Icons.person,
                ),
                _buildInfoRow(
                  context,
                  label: 'Nombre',
                  value: currentUser.nombre,
                  icon: Icons.badge,
                ),
                _buildInfoRow(
                  context,
                  label: 'Apellido',
                  value: currentUser.apellido,
                  icon: Icons.badge_outlined,
                ),
                _buildInfoRow(
                  context,
                  label: 'RUT',
                  value: _formatRut(currentUser.rut),
                  icon: Icons.credit_card,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Tarjeta de información de contacto
            _buildInfoCard(
              context,
              title: 'Información de Contacto',
              icon: Icons.contact_mail_outlined,
              children: [
                _buildInfoRow(
                  context,
                  label: 'Email',
                  value: currentUser.email,
                  icon: Icons.email_outlined,
                ),
                _buildInfoRow(
                  context,
                  label: 'Teléfono',
                  value: currentUser.telefono,
                  icon: Icons.phone_outlined,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Tarjeta de información del sistema
            _buildInfoCard(
              context,
              title: 'Información del Sistema',
              icon: Icons.settings_outlined,
              children: [
                _buildInfoRow(
                  context,
                  label: 'Fecha de Registro',
                  value: _formatDate(currentUser.fechaCreacion),
                  icon: Icons.calendar_today_outlined,
                ),
                _buildInfoRow(
                  context,
                  label: 'ID de Usuario',
                  value: currentUser.id ?? 'N/A',
                  icon: Icons.fingerprint,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la tarjeta
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Contenido de la tarjeta
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.getInputBackground(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? AppTheme.getTextPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatRut(String rut) {
    // Quitar puntos y guiones existentes
    String cleanRut = rut.replaceAll(RegExp(r'[.-]'), '');
    
    if (cleanRut.length < 8) return rut;
    
    // Separar el dígito verificador
    String numero = cleanRut.substring(0, cleanRut.length - 1);
    String dv = cleanRut.substring(cleanRut.length - 1);
    
    // Formatear con puntos
    String formatted = '';
    for (int i = numero.length; i > 0; i -= 3) {
      int start = i - 3 < 0 ? 0 : i - 3;
      String group = numero.substring(start, i);
      formatted = formatted.isEmpty ? group : '$group.$formatted';
    }
    
    return '$formatted-$dv';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    
    return '${date.day} de ${months[date.month - 1]}, ${date.year}';
  }
}