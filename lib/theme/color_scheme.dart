import 'package:flutter/material.dart';

const darkModeprimarybg = Color(0xFF161D31);
final darkModeSecondarybg = colorFromHex("#283046");
const darkModeDivider = Colors.black26;

const lightModeprimarybg = Color(0xFFF8F8F8);
final lightModeSecondarybg = colorFromHex("#F8F8F8");
final lightModeDivider = Colors.grey.withOpacity(0.15);
final allPrimary = colorFromHex("#2E8BC0");


const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006D38),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFF3F2F7),
  onPrimaryContainer: Color.fromARGB(255, 173, 173, 173),
  secondary: Color(0xFF7367F0),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFFFFF),
  onSecondaryContainer: Color(0xFF001F2A),
  tertiary: Color(0xFF3A656E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBEEAF5),
  onTertiaryContainer: Color(0xFF001F25),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8F8F8),
  onBackground: Color(0xFF191C19),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF191C19),
  surfaceVariant: Color(0xFFDDE5DA),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF717971),
  onInverseSurface: Color(0xFFF0F1EC),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF4BE085),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006D38),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4BE085),
  onPrimary: Color(0xFF00391A),
  primaryContainer: Color(0xFF283046),
  onPrimaryContainer: Color.fromARGB(255, 204, 203, 203),
  secondary: Color(0xFF9E95F5),
  onSecondary: Color(0xFF003547),
  secondaryContainer: Color(0xFF10163a),
  onSecondaryContainer: Color(0xFFBFE9FF),
  tertiary: Color(0xFFA2CED9),
  onTertiary: Color(0xFF01363F),
  tertiaryContainer: Color(0xFF204D56),
  onTertiaryContainer: Color(0xFFBEEAF5),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF161D31),
  onBackground: Color(0xFFE1E3DE),
  surface: Color(0xFF283046),
  onSurface: Color(0xFFE1E3DE),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BF),
  outline: Color(0xFF8B938A),
  onInverseSurface: Color(0xFF191C19),
  inverseSurface: Color(0xFFE1E3DE),
  inversePrimary: Color(0xFF006D38),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4BE085),
);

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
