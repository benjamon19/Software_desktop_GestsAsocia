import 'package:flutter/material.dart';
import '../../../../../../../utils/app_theme.dart';

class RutSearchField extends StatefulWidget {
  final Function(String) onSearch;
  final bool isLoading;

  const RutSearchField({
    super.key,
    required this.onSearch,
    this.isLoading = false,
  });

  @override
  State<RutSearchField> createState() => _RutSearchFieldState();
}

class _RutSearchFieldState extends State<RutSearchField> {
  final TextEditingController _rutController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _rutController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _rutController,
      focusNode: _focusNode,
      enabled: !widget.isLoading,
      decoration: InputDecoration(
        labelText: 'RUT del Asociado',
        hintText: '12345678-9',
        prefixIcon: Icon(
          Icons.badge,
          color: AppTheme.getTextSecondary(context),
          size: 20,
        ),
        suffixIcon: _rutController.text.isNotEmpty
            ? IconButton(
                onPressed: widget.isLoading ? null : _handleSearch,
                icon: Icon(
                  Icons.search,
                  color: AppTheme.primaryColor,
                ),
                tooltip: 'Buscar',
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (_) => _handleSearch(),
      onChanged: (value) => setState(() {}),
    );
  }

  void _handleSearch() {
    final rut = _rutController.text.trim();
    if (rut.isNotEmpty) {
      _focusNode.unfocus();
      widget.onSearch(rut);
    }
  }
}