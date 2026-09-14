import 'package:flutter/material.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/open_external.dart';

Widget driveIframe(String url) {
  return ColoredBox(
    color: const Color(0xFF1A1512),
    child: Center(
      child: TextButton.icon(
        onPressed: () => openExternal(url),
        icon: const Icon(Icons.play_circle_outline, color: AppColors.accent),
        label: Text(
          'Open video',
          style: AppTypography.body(
            color: AppColors.accent,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
