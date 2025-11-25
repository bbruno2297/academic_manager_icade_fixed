import 'package:flutter/material.dart';

/// Tema visual optimizado para aplicaciones de escritorio
/// Diseño plano, denso, profesional - NO Material Design móvil
class DesktopTheme {
  // Colores de escritorio profesionales
  static const primaryBlue = Color(0xFF1976D2);
  static const darkBg = Color(0xFF1E1E1E);
  static const lightBg = Color(0xFFF5F7FA);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF2C2C2C);

  // Bordes y dividers
  static const borderLight = Color(0xFFE0E0E0);
  static const borderDark = Color(0xFF404040);

  // Padding reducido para desktop
  static const double compactPadding = 8.0;
  static const double standardPadding = 12.0;
  static const double largePadding = 16.0;

  // Border radius reducido (menos redondeado = más desktop)
  static const double smallRadius = 4.0;
  static const double standardRadius = 6.0;
  static const double largeRadius = 8.0;

  // Elevación mínima (desktop apps son más planas)
  static const double flatElevation = 0.0;
  static const double subtleElevation = 1.0;

  static BoxDecoration desktopCard(BuildContext context,
      {bool isDense = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: isDark ? surfaceDark : surfaceLight,
      borderRadius:
          BorderRadius.circular(isDense ? smallRadius : standardRadius),
      border: Border.all(
        color: isDark ? borderDark : borderLight,
        width: 1,
      ),
    );
  }

  static BoxDecoration desktopPanel(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: isDark ? surfaceDark : surfaceLight,
      border: Border(
        bottom: BorderSide(
          color: isDark ? borderDark : borderLight,
          width: 1,
        ),
      ),
    );
  }

  static TextStyle headerStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
      letterSpacing: 0.3,
    );
  }

  static TextStyle bodyStyle(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      color: Theme.of(context).colorScheme.onSurface,
      height: 1.4,
    );
  }

  static TextStyle captionStyle(BuildContext context) {
    return TextStyle(
      fontSize: 11,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      height: 1.3,
    );
  }
}
