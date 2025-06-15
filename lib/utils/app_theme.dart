import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales
  static const Color primaryColor = Color(0xFF4299E1);
  static const Color secondaryColor = Color(0xFF2D3748);
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color surfaceColor = Colors.white;
  
  // Colores de texto
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);
  static const Color textLight = Color(0xFFA0AEC0);
  
  // Colores de borde e input
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF7FAFC);
  static const Color inputBackground = Color(0xFFF7FAFC);
  static const Color inputBackgroundFocused = Color(0xFFEDF2F7);
  
  // Colores de estado
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color successColor = Color(0xFF38A169);
  static const Color warningColor = Color(0xFFD69E2E);
  
  // Etiquetas y captions
  static const Color labelMedium = Color(0xFF4A5568);
  static const Color caption = Color(0xFF718096);
  
  // Espaciados
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  
  // Radios
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  
  // Tamaños de fuente
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeXXXL = 32.0;
  
  // Estilos de texto
  static const TextStyle headingLarge = TextStyle(
    fontSize: fontSizeXXXL,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: fontSizeXXL,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: fontSizeS,
    fontWeight: FontWeight.normal,
    color: textTertiary,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static const TextStyle labelMediumStyle = TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w500,
    color: labelMedium,
  );
  
  static const TextStyle captionStyle = TextStyle(
    fontSize: fontSizeS,
    fontWeight: FontWeight.normal,
    color: caption,
  );
  
  // Sombras
  static const BoxShadow shadowLight = BoxShadow(
    color: Color(0x0F000000),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow shadowMedium = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 16,
    offset: Offset(0, 4),
  );
}