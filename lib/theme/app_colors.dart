import 'package:flutter/material.dart';

class AppColors {
  // Brand logo accents (kept for mark + highlights)
  static const logoPink = Color(0xFFFFAFCC);
  static const logoPeriwinkle = Color(0xFFA2A9F5);
  static const logoTan = Color(0xFFE5AA8A);

  // Portrait studio backdrop (warm taupe / umber)
  static const primary = Color(0xFF786050);
  static const primaryDeep = Color(0xFF2C241F);
  static const primaryMid = Color(0xFF5C4A40);
  static const primaryLight = Color(0xFF9A8778);
  static const accent = Color(0xFFC4A574);
  static const accentHover = Color(0xFFD4B88A);
  static const whiteMuted = Color(0xB8FFFFFF);
  static const whiteSoft = Color(0x1FFFFFFF);

  // Portfolio / CV content panel — warm taupe blend (matches home)
  static const surfaceLight = Color(0xFFF4F1ED);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const textOnLight = Color(0xFF2C241F);
  static const textMutedOnLight = Color(0xFF6B5D52);

  // CV accent uses primary taupe gradient
  static const cvIndigo = primaryMid;
  static const cvBlue = accent;
  static const cvIconBg = Color(0xFFE8E0D8);
  static const cvGlowBlue = Color(0x33786050);
  static const cvGlowPink = Color(0x33FFAFCC);

  // Legacy aliases used by older widgets
  static const portfolioOrange = primaryMid;
  static const sidebarTop = Color(0xFF3A3A3A);
  static const sidebarBottom = Color(0xFF141414);
  static const sidebarTextMuted = Color(0x99FFFFFF);

  static const availabilityTeal = Color(0xFF14B8A6);
}
