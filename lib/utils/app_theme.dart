import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4299E1);
  static const Color secondaryColor = Color(0xFF2D3748);
  
  static const Color backgroundColor = Color(0xFFF4F5F7);
  static const Color surfaceColor = Color(0xFFFAFAFB);
  
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);
  static const Color textLight = Color(0xFF9CA3AF);
  
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color inputFill = Color(0xFFF7F8FA);
  static const Color inputBackground = Color(0xFFF7F8FA);
  static const Color inputBackgroundFocused = Color(0xFFF0F2F5);
  
  static const Color darkBackgroundColor = Color(0xFF36393F);
  static const Color darkSurfaceColor = Color(0xFF2F3136);
  
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE2E4E9);
  static const Color darkTextTertiary = Color(0xFFC1C7D0);
  static const Color darkTextLight = Color(0xFF9CA3AF);
  
  static const Color darkBorderLight = Color(0xFF40444B);
  static const Color darkInputFill = Color(0xFF40444B);
  static const Color darkInputBackground = Color(0xFF40444B);
  static const Color darkInputBackgroundFocused = Color(0xFF343A47);
  
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color successColor = Color(0xFF38A169);
  static const Color warningColor = Color(0xFFD69E2E);
  
  static const Color labelMedium = Color(0xFF4A5568);
  static const Color caption = Color(0xFF6B7280);
  
  static const Color darkLabelMedium = Color(0xFFE2E4E9);
  static const Color darkCaption = Color(0xFFC1C7D0);
  
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeXXXL = 32.0;
  
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
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
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
      secondary: Color(0xFF404040),
      surface: darkSurfaceColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
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
      hintStyle: TextStyle(color: darkTextSecondary.withValues(alpha: 0.7)),
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