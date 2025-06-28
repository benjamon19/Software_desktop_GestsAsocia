import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';
import 'components/carga_card.dart';

class CargasListSection extends StatelessWidget {
  final List<Map<String, dynamic>> cargas;
  final Function(Map<String, dynamic>) onCargaSelected;
  final Function(String) onFilterChanged;
  final Function(String) onStatusChanged;
  final String selectedFilter;
  final String selectedStatus;

  const CargasListSection({
    super.key,
    required this.cargas,
    required this.onCargaSelected,
    required this.onFilterChanged,
    required this.onStatusChanged,
    required this.selectedFilter,
    required this.selectedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${cargas.length} carga${cargas.length != 1 ? 's' : ''} familiar${cargas.length != 1 ? 'es' : ''} encontrada${cargas.length != 1 ? 's' : ''}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Container(
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
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: cargas.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CargaCard(
                  carga: cargas[index],
                  onTap: () => onCargaSelected(cargas[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}