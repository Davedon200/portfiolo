import 'package:flutter/material.dart';

/// Shared typography — Syne for display, Manrope for body (matches home page).
/// Uses families declared in pubspec.yaml.
abstract class AppTypography {
  static TextStyle display({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = -0.5,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Syne',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height ?? 1.05,
      color: color,
    );
  }

  static TextStyle body({
    required Color color,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.55,
  }) {
    return TextStyle(
      fontFamily: 'Manrope',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color,
    );
  }

  static TextStyle nav({
    required Color color,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: 'Syne',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Hero eyebrow / labels — monospace, letter-spaced (reference layout).
  static TextStyle heroLabel({
    required Color color,
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.w600,
    double letterSpacing = 3.2,
  }) {
    return TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle heroTitle({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w900,
    double letterSpacing = -2,
    double height = 0.9,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
    );
  }

  /// Hero body & UI copy — Inter (matches reference sans).
  static TextStyle heroBody({
    required Color color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.65,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      color: color,
    );
  }
}
