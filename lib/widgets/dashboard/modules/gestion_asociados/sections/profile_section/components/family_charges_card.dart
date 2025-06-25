import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

class FamilyChargesCard extends StatefulWidget {
  final Map<String, dynamic> asociado;

  const FamilyChargesCard({
    super.key,
    required this.asociado,
  });

  @override
  State<FamilyChargesCard> createState() => _FamilyChargesCardState();
}

class _FamilyChargesCardState extends State<FamilyChargesCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cargas = widget.asociado['cargasFamiliares'] as List<dynamic>? ?? [];
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, cargas.length),
          const SizedBox(height: 16),
          _buildChargesContent(context, cargas),
          if (cargas.length > 3) _buildScrollHint(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, int chargesCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cargas Familiares',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$chargesCount',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            if (chargesCount > 3)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.getTextSecondary(context),
                  size: 16,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildChargesContent(BuildContext context, List<dynamic> cargas) {
    if (cargas.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: cargas.length > 3 ? 250 : double.infinity,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.getBorderLight(context).withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: cargas.length > 3,
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            physics: cargas.length > 3 
                ? const AlwaysScrollableScrollPhysics() 
                : const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: cargas.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return _buildFamilyChargeItem(context, cargas[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppTheme.getTextSecondary(context),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'No hay cargas familiares registradas',
            style: TextStyle(
              color: AppTheme.getTextSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyChargeItem(BuildContext context, Map<String, dynamic> carga) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.getBorderLight(context),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getFamilyIcon(carga['parentesco']),
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carga['nombre'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${carga['parentesco']} • RUT: ${carga['rut']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
                Text(
                  'Nacimiento: ${carga['fechaNacimiento']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollHint(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: Text(
          'Desliza para ver más cargas familiares',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.getTextSecondary(context),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  IconData _getFamilyIcon(String parentesco) {
    switch (parentesco.toLowerCase()) {
      case 'cónyuge':
      case 'esposo':
      case 'esposa':
        return Icons.favorite;
      case 'hijo':
      case 'hija':
        return Icons.child_care;
      case 'padre':
      case 'madre':
        return Icons.elderly;
      case 'hermano':
      case 'hermana':
        return Icons.people;
      default:
        return Icons.person;
    }
  }
}