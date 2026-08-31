import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/open_external.dart';

class ChallengeGrid extends StatelessWidget {
  const ChallengeGrid({super.key, required this.challenges, required this.wide});

  final List<UiChallenge> challenges;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    if (!wide) {
      return Column(
        children: [
          for (var i = 0; i < challenges.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i < challenges.length - 1 ? 16 : 0),
              child: _ChallengeCard(challenge: challenges[i]),
            ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 16.0;
        final columns = constraints.maxWidth >= 900 ? 4 : 2;
        final cardWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final c in challenges)
              SizedBox(
                width: cardWidth,
                child: _ChallengeCard(challenge: c),
              ),
          ],
        );
      },
    );
  }
}

class _ChallengeCard extends StatefulWidget {
  const _ChallengeCard({required this.challenge});

  final UiChallenge challenge;

  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: Material(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          elevation: _hovered ? 6 : 1,
          shadowColor: Colors.black.withValues(alpha: 0.12),
          child: InkWell(
            onTap: challenge.url == null ? null : () => openExternal(challenge.url!),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Image.asset(
                      challenge.imageAsset,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.cvIconBg,
                          alignment: Alignment.center,
                          child: const Icon(Icons.animation, color: AppColors.primary),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: AppTypography.body(
                          color: AppColors.textOnLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        challenge.detail,
                        style: AppTypography.body(
                          color: AppColors.textMutedOnLight,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                      if (challenge.url != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.open_in_new,
                              size: 14,
                              color: AppColors.primaryMid,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'View demo',
                              style: AppTypography.body(
                                color: AppColors.primaryMid,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
