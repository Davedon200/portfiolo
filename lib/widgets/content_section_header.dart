import 'package:flutter/material.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';

class ContentSectionHeader extends StatelessWidget {
  const ContentSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: AppColors.cvIconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: AppColors.cvIndigo),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: AppTypography.body(
              color: AppColors.textOnLight,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
