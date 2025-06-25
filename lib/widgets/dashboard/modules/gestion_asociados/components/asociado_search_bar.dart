import 'package:flutter/material.dart';
import '../../../../../utils/app_theme.dart';

class AsociadoSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onBiometricScan;
  final VoidCallback onQRCodeScan;
  final bool isLoading;

  const AsociadoSearchBar({
    super.key,
    required this.onSearch,
    required this.onBiometricScan,
    required this.onQRCodeScan,
    this.isLoading = false,
  });

  @override
  State<AsociadoSearchBar> createState() => _AsociadoSearchBarState();
}

class _AsociadoSearchBarState extends State<AsociadoSearchBar> {
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buscar Asociado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              // Campo de búsqueda por RUT
              Expanded(
                flex: 3,
                child: _buildRutSearchField(context),
              ),
              
              const SizedBox(width: 12),
              
              // Botón de huella digital
              _buildActionButton(
                context: context,
                icon: Icons.fingerprint,
                tooltip: 'Buscar por huella digital',
                color: const Color(0xFF10B981),
                onPressed: widget.isLoading ? null : widget.onBiometricScan,
              ),
              
              const SizedBox(width: 8),
              
              // Botón de QR/Código de barras
              _buildActionButton(
                context: context,
                icon: Icons.qr_code_scanner,
                tooltip: 'Escanear código QR',
                color: const Color(0xFF8B5CF6),
                onPressed: widget.isLoading ? null : widget.onQRCodeScan,
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Texto de ayuda
          Text(
            'Ingresa el RUT (ej: 12345678-9), usa la huella digital o escanea el código QR del asociado',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRutSearchField(BuildContext context) {
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
          color: AppTheme.getTextSecondary(context).withOpacity(0.7),
        ),
      ),
      style: TextStyle(color: AppTheme.getTextPrimary(context)),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (_) => _handleSearch(),
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: widget.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              )
            : Icon(
                icon,
                color: color,
                size: 24,
              ),
        tooltip: tooltip,
      ),
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