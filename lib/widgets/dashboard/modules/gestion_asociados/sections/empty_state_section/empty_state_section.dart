import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';

class EmptyStateSection extends StatelessWidget {
  const EmptyStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMainIcon(context),
          const SizedBox(height: 24),
          _buildTitle(context),
          const SizedBox(height: 12),
          _buildDescription(context),
          const SizedBox(height: 32),
          _buildFeatureOptions(context),
        ],
      ),
    );
  }

  Widget _buildMainIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.search,
        size: 80,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Buscar Asociado',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.getTextPrimary(context),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Ingresa el RUT del asociado, usa la huella digital\no escanea el código de barras para buscar',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: AppTheme.getTextSecondary(context),
        height: 1.5,
      ),
    );
  }

  Widget _buildFeatureOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureItem(
          context,
          icon: Icons.fingerprint,
          title: 'Huella Digital',
          description: 'Autenticación biométrica',
        ),
        const SizedBox(width: 40),
        _buildFeatureItem(
          context,
          icon: Icons.qr_code_scanner,
          title: 'Código de Barras',
          description: 'Escaneo rápido',
        ),
        const SizedBox(width: 40),
        _buildFeatureItem(
          context,
          icon: Icons.badge,
          title: 'Búsqueda por RUT',
          description: 'Búsqueda manual',
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 140, // Ancho fijo para que todas sean del mismo tamaño
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