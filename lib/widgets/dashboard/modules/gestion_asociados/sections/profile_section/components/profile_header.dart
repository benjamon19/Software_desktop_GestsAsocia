import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> asociado;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.asociado,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          _buildAvatar(),
          
          const SizedBox(width: 20),
          
          // Información básica
          Expanded(
            child: _buildBasicInfo(),
          ),
          
          // Botón de editar
          _buildEditButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.person,
        size: 40,
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${asociado['nombre']} ${asociado['apellido']}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'RUT: ${asociado['rut']}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 8),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(asociado['estado']).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStatusColor(asociado['estado']),
          width: 1,
        ),
      ),
      child: Text(
        asociado['estado'],
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(asociado['estado']),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return IconButton(
      onPressed: onEdit,
      icon: const Icon(Icons.edit, color: Colors.white),
      tooltip: 'Editar información',
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'activo':
        return const Color(0xFF10B981);
      case 'inactivo':
        return const Color(0xFFEF4444);
      case 'suspendido':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }
}