import 'package:flutter/material.dart';
import 'package:michael_david/theme/app_colors.dart';

class PortraitPanel extends StatelessWidget {
  const PortraitPanel({
    super.key,
    required this.portraitOpacity,
    required this.portraitScale,
    this.compact = false,
  });

  final Animation<double> portraitOpacity;
  final Animation<double> portraitScale;

  /// Mobile / short panel — crop toward the head and soften edges.
  final bool compact;

  static const portraitAsset = 'assets/images/portrait_cutout.webp';
  static const portraitFallbackAsset = 'assets/images/portrait_cutout.png';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryMid, AppColors.primaryDeep, Color(0xFF1A1512)],
        ),
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([portraitOpacity, portraitScale]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: portraitOpacity.value,
                child: Transform.scale(
                  scale: compact
                      ? portraitScale.value * 1.28
                      : portraitScale.value,
                  alignment:
                      compact ? const Alignment(0, -0.55) : Alignment.bottomCenter,
                  child: _BlendedPortrait(
                    assetPath: portraitAsset,
                    compact: compact,
                  ),
                ),
              ),
              IgnorePointer(
                child: Opacity(
                  opacity: portraitOpacity.value,
                  child: _PortraitScrims(compact: compact),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BlendedPortrait extends StatelessWidget {
  const _BlendedPortrait({
    required this.assetPath,
    required this.compact,
  });

  final String assetPath;
  final bool compact;

  static const _imageAspect = 720 / 1080;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final panelAspect = constraints.maxWidth / constraints.maxHeight;
        // Cover scales by width on wide panels and crops the face — show full height instead.
        final fitHeight = !compact && panelAspect > _imageAspect;
        // Compact (mobile strip): cover + head-biased alignment.
        final alignment = compact
            ? const Alignment(0, -0.62)
            : (fitHeight ? Alignment.bottomCenter : const Alignment(0, 0.15));

        final image = Image.asset(
          assetPath,
          height: fitHeight ? constraints.maxHeight : null,
          width: fitHeight ? null : constraints.maxWidth,
          fit: fitHeight ? BoxFit.fitHeight : BoxFit.cover,
          alignment: alignment,
          filterQuality: FilterQuality.high,
          errorBuilder: (context, error, stackTrace) {
            return _PortraitFallback(
              assetPath: PortraitPanel.portraitFallbackAsset,
              fitHeight: fitHeight,
              compact: compact,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              alignment: alignment,
            );
          },
        );

        Widget portrait = ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.primary.withValues(alpha: 0.22),
            BlendMode.softLight,
          ),
          child: fitHeight
              ? Align(alignment: Alignment.bottomCenter, child: image)
              : SizedBox.expand(child: image),
        );

        // Soften the hard cutout silhouette into the panel gradient.
        portrait = ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (bounds) {
            return RadialGradient(
              center: compact ? const Alignment(0, -0.15) : const Alignment(0, 0.1),
              radius: compact ? 0.92 : 0.98,
              colors: [
                Colors.white,
                Colors.white.withValues(alpha: 0.85),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: compact
                  ? const [0.42, 0.72, 1.0]
                  : const [0.5, 0.78, 1.0],
            ).createShader(bounds);
          },
          child: portrait,
        );

        return portrait;
      },
    );
  }
}

class _PortraitFallback extends StatelessWidget {
  const _PortraitFallback({
    required this.assetPath,
    required this.fitHeight,
    required this.compact,
    required this.maxWidth,
    required this.maxHeight,
    required this.alignment,
  });

  final String assetPath;
  final bool fitHeight;
  final bool compact;
  final double maxWidth;
  final double maxHeight;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      assetPath,
      height: fitHeight ? maxHeight : null,
      width: fitHeight ? null : maxWidth,
      fit: fitHeight ? BoxFit.fitHeight : BoxFit.cover,
      alignment: alignment,
      filterQuality: FilterQuality.high,
    );

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppColors.primaryDeep.withValues(alpha: 0.45),
        BlendMode.multiply,
      ),
      child: fitHeight
          ? Align(alignment: Alignment.bottomCenter, child: image)
          : SizedBox.expand(child: image),
    );
  }
}

class _PortraitScrims extends StatelessWidget {
  const _PortraitScrims({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.primaryDeep.withValues(alpha: compact ? 0.7 : 0.55),
                Colors.transparent,
                AppColors.primary.withValues(alpha: compact ? 0.5 : 0.35),
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryMid.withValues(alpha: 0.25),
                Colors.transparent,
                AppColors.primaryDeep.withValues(alpha: compact ? 0.85 : 0.65),
              ],
              stops: compact
                  ? const [0.0, 0.35, 1.0]
                  : const [0.0, 0.4, 1.0],
            ),
          ),
        ),
        // Extra soft blend at the silhouette edge into the taupe field.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: compact ? const Alignment(0, -0.2) : const Alignment(0, 0.05),
              radius: 1.05,
              colors: [
                Colors.transparent,
                AppColors.primaryDeep.withValues(alpha: compact ? 0.45 : 0.28),
              ],
              stops: const [0.55, 1.0],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.accent.withValues(alpha: 0.12),
                Colors.transparent,
              ],
            ),
          ),
        ),
        if (compact)
          Align(
            alignment: Alignment.bottomCenter,
            child: IgnorePointer(
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.primaryDeep.withValues(alpha: 0.55),
                      const Color(0xFF1A1512).withValues(alpha: 0.9),
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
