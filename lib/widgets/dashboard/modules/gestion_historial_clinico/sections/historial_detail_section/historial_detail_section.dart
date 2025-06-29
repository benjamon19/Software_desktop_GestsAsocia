import 'package:flutter/material.dart';
import '../../../../../../utils/app_theme.dart';
import 'components/historial_header.dart';
import 'components/patient_info_card.dart';
import 'components/consultation_info_card.dart';
import 'components/medical_info_card.dart';

class HistorialDetailSection extends StatelessWidget {
  final Map<String, dynamic> historial;
  final VoidCallback onEdit;

  const HistorialDetailSection({super.key, required this.historial, required this.onEdit});

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
        children: [
          HistorialHeader(historial: historial, onEdit: onEdit),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PatientInfoCard(historial: historial),
                  const SizedBox(height: 20),
                  ConsultationInfoCard(historial: historial),
                  const SizedBox(height: 20),
                  MedicalInfoCard(historial: historial),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}