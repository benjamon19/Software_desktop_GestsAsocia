import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales
  static const Color primaryColor = Color(0xFF4299E1);
  static const Color secondaryColor = Color(0xFF2D3748);
  
  // Colores modo claro (tu estructura original)
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color surfaceColor = Colors.white;
  
  // Colores de texto modo claro
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);
  static const Color textLight = Color(0xFFA0AEC0);
  
  // Colores de borde e input modo claro
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF7FAFC);
  static const Color inputBackground = Color(0xFFF7FAFC);
  static const Color inputBackgroundFocused = Color(0xFFEDF2F7);
  
  // Colores modo oscuro (más claros y cómodos)
  static const Color darkBackgroundColor = Color(0xFF1A1A1A); // Gris oscuro pero no tanto
  static const Color darkSurfaceColor = Color(0xFF2D2D2D);    // Gris medio para el panel
  
  // Colores de texto modo oscuro
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA0AEC0);
  static const Color darkTextTertiary = Color(0xFF718096);
  static const Color darkTextLight = Color(0xFF4A5568);
  
  // Colores de borde e input modo oscuro (más equilibrados)
  static const Color darkBorderLight = Color(0xFF404040);     // Gris medio más visible
  static const Color darkInputFill = Color(0xFF363636);       // Gris para inputs más claro
  static const Color darkInputBackground = Color(0xFF363636);
  static const Color darkInputBackgroundFocused = Color(0xFF404040);
  
  // Colores de estado (iguales para ambos modos)
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color successColor = Color(0xFF38A169);
  static const Color warningColor = Color(0xFFD69E2E);
  
  // Etiquetas y captions modo claro
  static const Color labelMedium = Color(0xFF4A5568);
  static const Color caption = Color(0xFF718096);
  
  // Etiquetas y captions modo oscuro
  static const Color darkLabelMedium = Color(0xFFA0AEC0);
  static const Color darkCaption = Color(0xFF718096);
  
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
  
  // Getters dinámicos que detectan el tema actual
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor
        : backgroundColor;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : surfaceColor;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : textPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : textSecondary;
  }

  static Color getInputBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkInputBackground
        : inputBackground;
  }

  static Color getBorderLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderLight
        : borderLight;
  }

  static Color getLabelMediumColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkLabelMedium
        : labelMedium;
  }
  
  // Estilos de texto estáticos (tu código original)
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
  
  // Estilos de texto adaptativos (nuevos)
  static TextStyle getHeadingLarge(BuildContext context) => TextStyle(
    fontSize: fontSizeXXXL,
    fontWeight: FontWeight.bold,
    color: getTextPrimary(context),
  );
  
  static TextStyle getHeadingMedium(BuildContext context) => TextStyle(
    fontSize: fontSizeXXL,
    fontWeight: FontWeight.bold,
    color: getTextPrimary(context),
  );
  
  static TextStyle getHeadingSmall(BuildContext context) => TextStyle(
    fontSize: fontSizeXL,
    fontWeight: FontWeight.w600,
    color: getTextPrimary(context),
  );
  
  static TextStyle getBodyLarge(BuildContext context) => TextStyle(
    fontSize: fontSizeL,
    fontWeight: FontWeight.normal,
    color: getTextPrimary(context),
  );
  
  static TextStyle getBodyMedium(BuildContext context) => TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.normal,
    color: getTextSecondary(context),
  );
  
  static TextStyle getBodySmall(BuildContext context) => TextStyle(
    fontSize: fontSizeS,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark ? darkTextTertiary : textTertiary,
  );
  
  static TextStyle getLabelMediumStyle(BuildContext context) => TextStyle(
    fontSize: fontSizeM,
    fontWeight: FontWeight.w500,
    color: getLabelMediumColor(context),
  );
  
  static TextStyle getCaptionStyle(BuildContext context) => TextStyle(
    fontSize: fontSizeS,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark ? darkCaption : caption,
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

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(0xFF4299E1, {
      50: Color(0xFFEBF8FF),
      100: Color(0xFFBEE3F8),
      200: Color(0xFF90CDF4),
      300: Color(0xFF63B3ED),
      400: Color(0xFF4299E1),
      500: Color(0xFF3182CE),
      600: Color(0xFF2B77CB),
      700: Color(0xFF2C5AA0),
      800: Color(0xFF2A4365),
      900: Color(0xFF1A365D),
    }),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onBackground: textPrimary,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: textPrimary,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(color: borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: spaceM),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
        textStyle: buttonText,
      ),
    ),
  );

  // Tema oscuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(0xFF4299E1, {
      50: Color(0xFFEBF8FF),
      100: Color(0xFFBEE3F8),
      200: Color(0xFF90CDF4),
      300: Color(0xFF63B3ED),
      400: Color(0xFF4299E1),
      500: Color(0xFF3182CE),
      600: Color(0xFF2B77CB),
      700: Color(0xFF2C5AA0),
      800: Color(0xFF2A4365),
      900: Color(0xFF1A365D),
    }),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: Color(0xFF404040),          // Gris más claro y visible
      surface: darkSurfaceColor,
      background: darkBackgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
      onBackground: darkTextPrimary,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurfaceColor,
      foregroundColor: darkTextPrimary,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkInputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(color: darkBorderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: darkTextSecondary),
      hintStyle: TextStyle(color: darkTextSecondary.withOpacity(0.7)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: spaceM),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSmall)),
        textStyle: buttonText,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkTextPrimary),
      bodyMedium: TextStyle(color: darkTextSecondary),
      headlineMedium: TextStyle(color: darkTextPrimary, fontSize: fontSizeXXL, fontWeight: FontWeight.bold),
    ),
  );
}