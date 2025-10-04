import 'package:flutter/material.dart';

/// Modern app color constants with beautiful gradients and improved contrast
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Modern Primary Colors - Deep Purple/Violet Theme
  static const Color primary = Color(0xFF6366F1); // Indigo-500
  static const Color primaryLight = Color(0xFF8B5CF6); // Violet-500
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo-600
  static const Color primaryContainer = Color(0xFFE0E7FF); // Indigo-100
  
  // Secondary Colors - Warm Orange/Amber
  static const Color secondary = Color(0xFFF59E0B); // Amber-500
  static const Color secondaryLight = Color(0xFFFCD34D); // Amber-300
  static const Color secondaryDark = Color(0xFFD97706); // Amber-600
  static const Color secondaryContainer = Color(0xFFFEF3C7); // Amber-100
  
  // Accent Colors - Vibrant Pink/Rose
  static const Color accent = Color(0xFFEC4899); // Pink-500
  static const Color accentLight = Color(0xFFF472B6); // Pink-400
  static const Color accentDark = Color(0xFFDB2777); // Pink-600
  static const Color accentContainer = Color(0xFFFCE7F3); // Pink-100
  
  // Background Colors - Modern Neutrals
  static const Color background = Color(0xFFFAFAFA); // Gray-50
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color scaffoldBackground = Color(0xFFF8FAFC); // Slate-50
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate-100
  
  // Text Colors - High Contrast
  static const Color textPrimary = Color(0xFF0F172A); // Slate-900
  static const Color textSecondary = Color(0xFF475569); // Slate-600
  static const Color textTertiary = Color(0xFF64748B); // Slate-500
  static const Color textHint = Color(0xFF94A3B8); // Slate-400
  static const Color textDisabled = Color(0xFFCBD5E1); // Slate-300
  
  // Status Colors - Modern Palette
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color successLight = Color(0xFF34D399); // Emerald-400
  static const Color successContainer = Color(0xFFD1FAE5); // Emerald-100
  
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color warningLight = Color(0xFFFCD34D); // Amber-300
  static const Color warningContainer = Color(0xFFFEF3C7); // Amber-100
  
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color errorLight = Color(0xFFF87171); // Red-400
  static const Color errorContainer = Color(0xFFFEE2E2); // Red-100
  
  static const Color info = Color(0xFF3B82F6); // Blue-500
  static const Color infoLight = Color(0xFF60A5FA); // Blue-400
  static const Color infoContainer = Color(0xFFDBEAFE); // Blue-100
  
  // Movie-specific Colors
  static const Color movieCardBackground = Color(0xFFFFFFFF);
  static const Color movieCardBorder = Color(0xFFE2E8F0); // Slate-200
  static const Color movieCardShadow = Color(0x0F000000); // Subtle shadow
  static const Color ratingStar = Color(0xFFFBBF24); // Amber-400
  static const Color ratingStarEmpty = Color(0xFFE2E8F0); // Slate-200
  
  // Navigation Colors
  static const Color navigationBarBackground = Color(0xFFFFFFFF);
  static const Color navigationBarSelected = Color(0xFF6366F1); // Indigo-500
  static const Color navigationBarUnselected = Color(0xFF94A3B8); // Slate-400
  
  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color divider = Color(0xFFE2E8F0); // Slate-200
  static const Color shadow = Color(0x0A000000); // Very subtle shadow
  
  // Glassmorphism Colors
  static const Color glassBackground = Color(0x20FFFFFF);
  static const Color glassBorder = Color(0x30FFFFFF);
  
  // Modern Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFCD34D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
  );
  
  // Movie Card Gradients
  static const LinearGradient movieCardGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  // Background Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Glassmorphism Gradient
  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x20FFFFFF), Color(0x10FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Rating Gradient
  static const LinearGradient ratingGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
