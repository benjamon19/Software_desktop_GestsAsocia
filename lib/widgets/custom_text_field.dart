import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final int? maxLines;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.labelMediumStyle,
        hintText: hint,
        hintStyle: AppTheme.captionStyle.copyWith(color: AppTheme.textLight),
        prefixIcon: prefixIcon != null 
          ? Icon(prefixIcon, size: 20, color: AppTheme.textTertiary)
          : null,
        suffixIcon: suffixIcon != null 
          ? IconButton(
              onPressed: onSuffixIconPressed,
              icon: Icon(suffixIcon, size: 20, color: AppTheme.textTertiary),
            )
          : null,
        filled: true,
        fillColor: enabled ? AppTheme.inputFill : AppTheme.inputFill.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          borderSide: const BorderSide(color: AppTheme.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          borderSide: const BorderSide(color: AppTheme.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          borderSide: const BorderSide(color: AppTheme.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          borderSide: const BorderSide(color: AppTheme.errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceM,
          vertical: AppTheme.spaceM,
        ),
      ),
    );
  }
}