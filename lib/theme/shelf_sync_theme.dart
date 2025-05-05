import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _primaryColor = Color(0xFF3F51B5);
const Color _primaryLight = Color(0xFF7986CB);
const Color _primaryDark = Color(0xFF303F9F);
const Color _secondaryColor = Color(0xFF009688);
const Color _secondaryLight = Color(0xFF4DB6AC);
const Color _secondaryDark = Color(0xFF00796B);
const Color _tertiaryColor = Color(0xFFE91E63);
const Color _tertiaryLight = Color(0xFFF06292);
const Color _tertiaryDark = Color(0xFFC2185B);
const Color _neutralLight = Color(0xFFF5F5F5);
const Color _neutralDark = Color(0xFF212121);
const Color _neutralVariant = Color(0xFFE0E0E0);

final TextTheme _textTheme = TextTheme(
  displayLarge: GoogleFonts.inter(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.25,
  ),
  displayMedium: GoogleFonts.inter(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  ),
  displaySmall: GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.3,
  ),
  headlineLarge: GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
  ),
  headlineMedium: GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
  ),
  headlineSmall: GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  ),
  titleLarge: GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.27,
  ),
  titleMedium: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  ),
  titleSmall: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  ),
  bodyLarge: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  ),
  bodyMedium: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  ),
  bodySmall: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  ),
  labelLarge: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  ),
  labelMedium: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.66,
  ),
  labelSmall: GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: _primaryColor,
    onPrimary: Colors.white,
    primaryContainer: _primaryLight,
    onPrimaryContainer: _primaryDark,
    secondary: _secondaryColor,
    onSecondary: Colors.white,
    secondaryContainer: _secondaryLight,
    onSecondaryContainer: _secondaryDark,
    tertiary: _tertiaryColor,
    onTertiary: Colors.white,
    tertiaryContainer: _tertiaryLight,
    onTertiaryContainer: _tertiaryDark,
    surface: _neutralLight,
    onSurface: _neutralDark,
    error: Colors.red,
    onError: Colors.white,
    outline: _neutralVariant,
  ),
  textTheme: _textTheme,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _primaryColor),
    ),
    labelStyle: TextStyle(color: _primaryColor),
    floatingLabelStyle: TextStyle(color: _primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      textStyle: _textTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  cardTheme: CardTheme(
    color: _neutralLight,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: _neutralLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: _neutralLight,
    foregroundColor: _neutralDark,
    elevation: 0,
    centerTitle: true,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: _neutralLight,
    selectedItemColor: _primaryColor,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(fontSize: 12),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: _primaryColor,
    onPrimary: Colors.white,
    primaryContainer: _primaryDark,
    onPrimaryContainer: _primaryLight,
    secondary: _secondaryColor,
    onSecondary: Colors.white,
    secondaryContainer: _secondaryDark,
    onSecondaryContainer: _secondaryLight,
    tertiary: _tertiaryColor,
    onTertiary: Colors.white,
    tertiaryContainer: _tertiaryDark,
    onTertiaryContainer: _tertiaryLight,
    surface: _neutralDark,
    onSurface: _neutralLight,
    error: Colors.red,
    onError: Colors.white,
    outline: _neutralVariant,
  ),
  textTheme: _textTheme.apply(
    bodyColor: _neutralLight,
    displayColor: _neutralLight,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _primaryColor),
    ),
    labelStyle: TextStyle(color: _primaryColor),
    floatingLabelStyle: TextStyle(color: _primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      textStyle: _textTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  cardTheme: CardTheme(
    color: _neutralDark,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: _neutralDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _neutralDark,
    foregroundColor: _neutralLight,
    elevation: 0,
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _neutralDark,
    selectedItemColor: _primaryColor,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontSize: 12),
    unselectedLabelStyle: const TextStyle(fontSize: 12),
  ),
);
