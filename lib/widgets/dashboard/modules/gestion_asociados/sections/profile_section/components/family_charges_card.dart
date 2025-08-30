import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_theme.dart';
import '../../../../../../../controllers/asociados_controller.dart';
import '../../../../../../../models/asociado.dart';

class FamilyChargesCard extends StatefulWidget {
  final Asociado asociado;

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
    // Obtener el controller para acceder a las cargas familiares reales
    final AsociadosController controller = Get.find<AsociadosController>();
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header reactivo que muestra el número real de cargas DEL ASOCIADO PASADO POR PARÁMETRO
          Obx(() {
            // Usar el ID del asociado pasado por parámetro
            final asociadoId = widget.asociado.id;
            
            if (asociadoId == null) {
              return const SizedBox();
            }
            
            // FILTRAR solo las cargas del asociado ACTUAL (el del widget, no el seleccionado)
            final cargasDelAsociado = controller.cargasFamiliares
                .where((carga) => carga.asociadoId == asociadoId)
                .toList();
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(context, cargasDelAsociado.length),
                const SizedBox(height: 16),
                _buildChargesContent(context, cargasDelAsociado),
                if (cargasDelAsociado.length > 5) _buildScrollHint(context),
              ],
            );
          }),
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
            if (chargesCount > 5)
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
        maxHeight: cargas.length > 5 ? 400 : double.infinity,
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
          thumbVisibility: cargas.length > 5,
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            physics: cargas.length > 5 
                ? const AlwaysScrollableScrollPhysics() 
                : const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: cargas.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              // Ahora usa el modelo CargaFamiliar real
              final carga = cargas[index];
              return _buildFamilyChargeItem(context, carga);
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

  Widget _buildFamilyChargeItem(BuildContext context, dynamic carga) {
    // Determinar si debe tener fondo especial basado en diferentes criterios
    final bool hasSpecialBackground = _shouldHaveSpecialBackground(carga);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Fondo condicional
        color: hasSpecialBackground 
            ? AppTheme.primaryColor.withValues(alpha: 0.05)  // Fondo azul suave
            : AppTheme.getInputBackground(context),           // Fondo normal
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasSpecialBackground
              ? AppTheme.primaryColor.withValues(alpha: 0.2)  // Borde azul
              : AppTheme.getBorderLight(context),              // Borde normal
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
              _getFamilyIcon(carga.parentesco),
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
                  carga.nombreCompleto,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${carga.parentesco} • RUT: ${carga.rut}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
                Text(
                  'Edad: ${carga.edad} años • Nacimiento: ${carga.fechaNacimientoFormateada}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          
          // Indicador de estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: carga.isActive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              carga.estado,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: carga.isActive ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para determinar qué cargas deben tener fondo especial
  bool _shouldHaveSpecialBackground(dynamic carga) {
    // OPCIÓN 1: Alternar cada elemento (índice par/impar)
    // return carga.hashCode % 2 == 0;
    
    // OPCIÓN 2: Destacar ciertos parentescos
    final parentescosEspeciales = ['Cónyuge', 'Hijo/a', 'Padre', 'Madre'];
    return parentescosEspeciales.contains(carga.parentesco);
    
    // OPCIÓN 3: Destacar por edad (menores de 18 años)
    // return carga.edad < 18;
    
    // OPCIÓN 4: Destacar cargas recién creadas (menos de 30 días)
    // final diasDesdeCreacion = DateTime.now().difference(carga.fechaCreacion).inDays;
    // return diasDesdeCreacion <= 30;
    
    // OPCIÓN 5: Combinación de criterios
    // return carga.edad < 18 || ['Cónyuge'].contains(carga.parentesco);
  }

  Widget _buildScrollHint(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: Text(
          'Scrollea para ver más cargas familiares',
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
      case 'hijo/a':
        return Icons.child_care;
      case 'padre':
      case 'madre':
        return Icons.elderly;
      case 'hermano':
      case 'hermana':
      case 'hermano/a':
        return Icons.people;
      case 'abuelo':
      case 'abuela':
      case 'abuelo/a':
        return Icons.elderly;
      default:
        return Icons.person;
    }
  }
}