import 'package:flutter/material.dart';

abstract final class VaultColors {
  static const background = Color(0xFF030405);
  static const surface = Color(0xFF0A0D12);
  static const violet = Color(0xFF8B5CF6);
  static const cyan = Color(0xFF22D3EE);
  static const text = Color(0xFFF8FAFC);
  static const muted = Color(0xFFA1AAB8);
  static const success = Color(0xFF34D399);
  static const warning = Color(0xFFFBBF24);
  static const error = Color(0xFFFB7185);
  static const accent = LinearGradient(colors: [violet, cyan]);
}

ThemeData vaultTheme() => ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: VaultColors.background,
  colorScheme: const ColorScheme.dark(
    primary: VaultColors.violet,
    secondary: VaultColors.cyan,
    surface: VaultColors.surface,
    error: VaultColors.error,
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 38,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.4,
    ),
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: VaultColors.text),
    bodyMedium: TextStyle(fontSize: 14, height: 1.45, color: VaultColors.muted),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: .06),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),
  ),
);
