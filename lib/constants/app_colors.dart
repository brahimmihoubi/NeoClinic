import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF0F62FE); // Clinical Blue
  static const Color primaryContainer = Color(0xFFE0ECFF);
  static const Color secondary = Color(0xFF0D9488); // Wellness Teal
  static const Color secondaryContainer = Color(0xFFCCFBF1);

  // Semantics & Status
  static const Color emergency = Color(0xFFDC2626); // Urgent Red
  static const Color emergencyContainer = Color(0xFFFEF2F2);
  static const Color success = Color(0xFF16A34A);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);

  // Surfaces & Canvas
  static const Color background = Color(0xFFF8FAFC); // Slate Canvas
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);

  // Typography
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Backward compatibility aliases
  static const Color primaryBlue = primary;
  static const Color errorRed = emergency;
  static const Color white = surface;
  static const Color lightGrey = background;
  static const Color grey = textSecondary;
  static const Color black = textPrimary;
}
