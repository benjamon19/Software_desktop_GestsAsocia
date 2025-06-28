import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';
import 'components/profile_header.dart';
import 'components/personal_info_card.dart';
import 'components/family_charges_card.dart';

class ProfileSection extends StatefulWidget {
  final Map<String, dynamic> asociado;
  final VoidCallback onEdit;

  const ProfileSection({
    super.key,
    required this.asociado,
    required this.onEdit,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Header del perfil
          ProfileHeader(
            asociado: widget.asociado,
            onEdit: widget.onEdit,
          ),
          
          // Contenido scrolleable con controller
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información personal
                    PersonalInfoCard(asociado: widget.asociado),
                    
                    // Cargas familiares
                    FamilyChargesCard(asociado: widget.asociado),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}