import 'package:flutter/material.dart';
import 'package:michael_david/theme/app_colors.dart';

class PortraitPanel extends StatelessWidget {
  const PortraitPanel({
    super.key,
    required this.portraitOpacity,
    required this.portraitScale,
  });

  final Animation<double> portraitOpacity;
  final Animation<double> portraitScale;

  static const portraitAsset = 'assets/images/portrait_cutout.png';

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
                  scale: portraitScale.value,
                  alignment: Alignment.bottomCenter,
                  child: const _BlendedPortrait(assetPath: portraitAsset),
                ),
              ),
              IgnorePointer(
                child: Opacity(
                  opacity: portraitOpacity.value,
                  child: const _PortraitScrims(),
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
  const _BlendedPortrait({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppColors.primary.withValues(alpha: 0.22),
        BlendMode.softLight,
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        alignment: const Alignment(0, 0.15),
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(
              AppColors.primaryDeep.withValues(alpha: 0.45),
              BlendMode.multiply,
            ),
            child: Image.asset(
              'assets/images/portrait.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0, 0.15),
              filterQuality: FilterQuality.high,
            ),
          );
        },
      ),
    );
  }
}

class _PortraitScrims extends StatelessWidget {
  const _PortraitScrims();

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
                AppColors.primaryDeep.withValues(alpha: 0.55),
                Colors.transparent,
                AppColors.primary.withValues(alpha: 0.35),
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
                AppColors.primaryDeep.withValues(alpha: 0.65),
              ],
              stops: const [0.0, 0.4, 1.0],
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
      ],
    );
  }
}
