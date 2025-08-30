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
          const SizedBox(height: 32),
          _buildTitle(context),
          const SizedBox(height: 16),
          _buildDescription(context),
          const SizedBox(height: 40),
          _buildActionSuggestions(context),
        ],
      ),
    );
  }

  Widget _buildMainIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.people_outline,
        size: 64,
        color: AppTheme.primaryColor.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'No hay asociados disponibles',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppTheme.getTextPrimary(context),
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Text(
        'Actualmente no tienes asociados registrados en el sistema. Puedes agregar un nuevo asociado usando el botón flotante.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: AppTheme.getTextSecondary(context),
          height: 1.6,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildActionSuggestions(BuildContext context) {
    return Column(
      children: [
        Text(
          'Agregar nuevo asociado',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(
            'Usa el botón flotante para registrar un asociado',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getTextSecondary(context),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}