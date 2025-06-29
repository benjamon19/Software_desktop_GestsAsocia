// lib/widgets/dashboard/modules/gestion_cargas_familiares/sections/search_section/search_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_theme.dart';
import '../../../../../../controllers/cargas_familiares_controller.dart';

class SearchSection extends StatefulWidget {
  final CargasFamiliaresController controller;

  const SearchSection({super.key, required this.controller});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buscar Cargas Familiares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar por nombre, RUT o titular',
                    hintText: 'María González, 12345678-9, Juan González...',
                    prefixIcon: Icon(Icons.search, color: AppTheme.getTextSecondary(context)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              widget.controller.clearSearch();
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.getInputBackground(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppTheme.getBorderLight(context)),
                    ),
                    labelStyle: TextStyle(color: AppTheme.getTextSecondary(context)),
                    hintStyle: TextStyle(
                      color: AppTheme.getTextSecondary(context).withValues(alpha: 0.7),
                    ),
                  ),
                  style: TextStyle(color: AppTheme.getTextPrimary(context)),
                  onChanged: (value) {
                    setState(() {});
                    widget.controller.searchCargas(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Dropdown de Parentesco con Obx
              Obx(() => _buildFilterDropdown(
                'Parentesco', 
                widget.controller.selectedFilter.value, 
                ['todos', 'hijo', 'cónyuge', 'padre'], 
                widget.controller.setFilter
              )),
              const SizedBox(width: 12),
              // Dropdown de Estado con Obx
              Obx(() => _buildFilterDropdown(
                'Estado', 
                widget.controller.selectedStatus.value,
                ['todas', 'activas', 'inactivas'], 
                widget.controller.setStatus
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> options, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.getInputBackground(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.getBorderLight(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: AppTheme.getTextSecondary(context),
          ),
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.getTextPrimary(context),
          ),
          dropdownColor: AppTheme.getSurfaceColor(context),
          items: options.map((option) => DropdownMenuItem(
            value: option,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$label: ${option[0].toUpperCase()}${option.substring(1)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
              ],
            ),
          )).toList(),
          onChanged: (newValue) {
            if (newValue != null && newValue != value) {
              Get.log('Cambiando $label de $value a $newValue'); // Debug
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}