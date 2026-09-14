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

  /// Mobile / short panel — crop toward the head.
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
          colors: [
            AppColors.primaryMid,
            AppColors.primaryDeep,
            Color(0xFF1A1512),
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([portraitOpacity, portraitScale]),
        builder: (context, _) {
          return Opacity(
            opacity: portraitOpacity.value,
            child: Transform.scale(
              scale: compact
                  ? portraitScale.value * 1.28
                  : portraitScale.value,
              alignment:
                  compact ? const Alignment(0, -0.55) : Alignment.bottomCenter,
              child: _PlainPortrait(
                assetPath: portraitAsset,
                compact: compact,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlainPortrait extends StatelessWidget {
  const _PlainPortrait({
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
        final fitHeight = !compact && panelAspect > _imageAspect;
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
            return Image.asset(
              PortraitPanel.portraitFallbackAsset,
              height: fitHeight ? constraints.maxHeight : null,
              width: fitHeight ? null : constraints.maxWidth,
              fit: fitHeight ? BoxFit.fitHeight : BoxFit.cover,
              alignment: alignment,
              filterQuality: FilterQuality.high,
            );
          },
        );

        if (fitHeight) {
          return Align(alignment: Alignment.bottomCenter, child: image);
        }
        return SizedBox.expand(child: image);
      },
    );
  }
}
