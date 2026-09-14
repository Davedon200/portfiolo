import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/asset_paths.dart';
import 'package:michael_david/utils/open_external.dart';

class ChallengeGrid extends StatelessWidget {
  const ChallengeGrid({super.key, required this.challenges, required this.wide});

  final List<UiChallenge> challenges;
  final bool wide;

  static const _gap = 16.0;
  static const _wideMediaHeight = 240.0;
  static const _mobileMediaHeight = 180.0;
  static const _mobileCardWidth = 160.0;
  static const _aspect = 9 / 16;

  @override
  Widget build(BuildContext context) {
    if (!wide) {
      const cardWidth = _mobileCardWidth;
      return SizedBox(
        height: _mobileMediaHeight + 138,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          itemCount: challenges.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return SizedBox(
              width: cardWidth,
              child: _ChallengeCard(
                challenge: challenges[index],
                mediaHeight: _mobileMediaHeight,
                compact: true,
              ),
            );
          },
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final rows = _packRows(constraints.maxWidth);
        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: _gap),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < rows[r].length; i++) ...[
                    if (i > 0) const SizedBox(width: _gap),
                    SizedBox(
                      width: rows[r][i].width,
                      child: _ChallengeCard(
                        challenge: rows[r][i].challenge,
                        mediaHeight: _wideMediaHeight,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  double _naturalWidth(double maxWidth) {
    return (_wideMediaHeight * _aspect).clamp(80.0, maxWidth);
  }

  List<List<_PackedChallenge>> _packRows(double maxWidth) {
    final buckets = <List<UiChallenge>>[];
    var row = <UiChallenge>[];

    double usedWidth(int count) {
      if (count == 0) return 0;
      return _naturalWidth(maxWidth) * count + _gap * (count - 1);
    }

    for (final challenge in challenges) {
      if (row.isNotEmpty && usedWidth(row.length + 1) > maxWidth) {
        buckets.add(row);
        row = [challenge];
      } else {
        row.add(challenge);
      }
    }
    if (row.isNotEmpty) buckets.add(row);

    return [
      for (var i = 0; i < buckets.length; i++)
        _scaleRow(
          buckets[i],
          maxWidth,
          stretch: i < buckets.length - 1 || buckets[i].length > 1,
        ),
    ];
  }

  List<_PackedChallenge> _scaleRow(
    List<UiChallenge> row,
    double maxWidth, {
    required bool stretch,
  }) {
    final natural = _naturalWidth(maxWidth);
    final gaps = _gap * (row.length - 1);
    final target = (maxWidth - gaps).clamp(0.0, maxWidth);
    var scale = 1.0;
    if (stretch && natural > 0) {
      scale = target / (natural * row.length);
      if (row.length == 1 && scale > 1.5) scale = 1.0;
    }
    final widths = List<double>.filled(row.length, natural * scale);
    if (stretch && widths.length > 1) {
      final used = widths.fold<double>(0, (a, b) => a + b);
      widths[widths.length - 1] += target - used;
    }
    return [
      for (var i = 0; i < row.length; i++)
        _PackedChallenge(row[i], widths[i]),
    ];
  }
}

class _PackedChallenge {
  const _PackedChallenge(this.challenge, this.width);

  final UiChallenge challenge;
  final double width;
}

class _ChallengeCard extends StatefulWidget {
  const _ChallengeCard({
    required this.challenge,
    required this.mediaHeight,
    this.compact = false,
  });

  final UiChallenge challenge;
  final double mediaHeight;
  final bool compact;

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
            onTap: challenge.url == null
                ? null
                : () => openExternal(challenge.url!),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    height: widget.mediaHeight,
                    width: double.infinity,
                    child: _ChallengeImage(assetPath: challenge.imageAsset),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    14,
                    widget.compact ? 10 : 14,
                    14,
                    widget.compact ? 12 : 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body(
                          color: AppColors.textOnLight,
                          fontSize: widget.compact ? 14 : 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        challenge.detail,
                        maxLines: widget.compact ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body(
                          color: AppColors.textMutedOnLight,
                          fontSize: widget.compact ? 12 : 13,
                          height: 1.45,
                        ),
                      ),
                      if (challenge.url != null) ...[
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.open_in_new,
                              size: 14,
                              color: AppColors.primaryMid,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'View demo',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.body(
                                  color: AppColors.primaryMid,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
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

class _ChallengeImage extends StatelessWidget {
  const _ChallengeImage({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: AppColors.cvIconBg,
      alignment: Alignment.center,
      child: const Icon(Icons.animation, color: AppColors.primary),
    );

    if (kIsWeb) {
      return Image.network(
        resolveAssetPath(assetPath),
        fit: BoxFit.cover,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: AppColors.cvIconBg,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => placeholder,
      );
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}
