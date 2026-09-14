import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';

class SkillsGrid extends StatelessWidget {
  const SkillsGrid({super.key, required this.groups});

  final List<SiteSkillGroup> groups;

  static const _gap = 14.0;
  static const _fourColMin = 720.0;
  static const _twoColMin = 520.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= _fourColMin
            ? 4
            : constraints.maxWidth >= _twoColMin
                ? 2
                : 1;
        final rows = <List<SiteSkillGroup>>[];
        for (var i = 0; i < groups.length; i += cols) {
          rows.add(groups.sublist(i, math.min(i + cols, groups.length)));
        }

        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: _gap),
              if (rows[r].length == 1)
                SkillCard(group: rows[r].first)
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < rows[r].length; i++) ...[
                        if (i > 0) const SizedBox(width: _gap),
                        Expanded(child: SkillCard(group: rows[r][i])),
                      ],
                    ],
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class SkillCard extends StatelessWidget {
  const SkillCard({super.key, required this.group});

  final SiteSkillGroup group;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.cvIndigo,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _iconFor(group.icon),
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      group.title,
                      style: AppTypography.body(
                        color: AppColors.textOnLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              for (var i = 0; i < group.items.length; i++) ...[
                if (i > 0) const SizedBox(height: 6),
                Text(
                  group.items[i],
                  style: AppTypography.body(
                    color: AppColors.textMutedOnLight,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

IconData _iconFor(String key) {
  switch (key) {
    case 'phone_iphone':
      return Icons.phone_iphone;
    case 'architecture':
      return Icons.architecture;
    case 'api':
      return Icons.hub_outlined;
    case 'code':
    default:
      return Icons.code;
  }
}
