import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/widgets/sidebar_pattern.dart';
import 'package:michael_david/widgets/social_rail.dart';

typedef PortfolioSectionTap = void Function(String sectionId);

class PortfolioSidebar extends StatelessWidget {
  const PortfolioSidebar({
    super.key,
    required this.activeSection,
    this.onSectionTap,
    this.width = 280,
  });

  final String? activeSection;
  final PortfolioSectionTap? onSectionTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.isFinite ? width : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryMid,
                AppColors.primaryDeep,
                AppColors.primaryDeep.withValues(alpha: 0.98),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CustomPaint(painter: SidebarPatternPainter()),
              Column(
                children: [
                  const SizedBox(height: 40),
                  const _SidebarAvatar(),
                  const SizedBox(height: 28),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: SiteConfig.portfolioNavItems.map((item) {
                        final active = item.sectionId != null &&
                            activeSection == item.sectionId;
                        return _SidebarLink(
                          label: item.label,
                          active: active,
                          onTap: () {
                            if (item.sectionId != null) {
                              onSectionTap?.call(item.sectionId!);
                            } else if (item.path != null) {
                              context.go(item.path!);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 28),
                    child: SocialRail(
                      vertical: false,
                      circleSize: 34,
                      maxItems: 4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// White ring with a passport head-and-shoulders crop. Full head sits above the ring with headroom.
class _SidebarAvatar extends StatelessWidget {
  const _SidebarAvatar();

  static const _ring = 140.0;
  static const _overflow = 72.0;
  /// Raises only the lower ring; top headroom stays the same.
  static const _circleLift = 28.0;

  @override
  Widget build(BuildContext context) {
    // Full ring sits behind the portrait so the head always stays in front.
    // Lower semicircle is redrawn on top so the bottom arc stays visible.
    const translateY = 52.0;
    const scale = 1.95;
    const imageAlignY = -0.48;
    final boxHeight = _ring + _overflow + _circleLift;
    return SizedBox(
      width: _ring,
      height: boxHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Circle fill + full white ring BEHIND the portrait.
          Positioned(
            left: 0,
            right: 0,
            bottom: _circleLift,
            height: _ring,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryMid,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),
          // Portrait on top — head covers the upper ring wherever they overlap.
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final circleTop =
                    constraints.maxHeight - _ring - _circleLift;
                return ClipPath(
                  clipper: const _PopOutClipper(circleLift: _circleLift),
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (bounds) {
                      // Soft-fade only the head pop-out (above circleTop).
                      final headEnd = circleTop / bounds.height;
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [
                          Color(0x00FFFFFF),
                          Color(0xBBFFFFFF),
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                        ],
                        stops: [
                          0.0,
                          (headEnd * 0.55).clamp(0.04, 0.28),
                          headEnd.clamp(0.18, 0.45),
                          1.0,
                        ],
                      ).createShader(bounds);
                    },
                    child: Transform.translate(
                      offset: const Offset(0, translateY),
                      child: Transform.scale(
                        scale: scale,
                        alignment: const Alignment(0, -0.45),
                        child: Image.asset(
                          'assets/images/portrait_cutout.png',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, imageAlignY),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Lower semicircle on top so the bottom arc stays visible around the torso.
          Positioned(
            left: 0,
            right: 0,
            bottom: _circleLift,
            height: _ring,
            child: const IgnorePointer(
              child: CustomPaint(
                painter: _LowerSemiRingPainter(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lower semicircle stroke drawn above the portrait.
class _LowerSemiRingPainter extends CustomPainter {
  const _LowerSemiRingPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = strokeWidth / 2;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    // 0 = east; sweep π clockwise → lower semicircle.
    canvas.drawArc(rect, 0, 3.141592653589793, false, paint);
  }

  @override
  bool shouldRepaint(covariant _LowerSemiRingPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

class _PopOutClipper extends CustomClipper<Path> {
  const _PopOutClipper({this.circleLift = 0});

  final double circleLift;

  @override
  Path getClip(Size size) {
    final diameter = size.width;
    final radius = diameter / 2;
    // Circle raised by circleLift; top overflow / head chimney unchanged.
    final circleTop = size.height - diameter - circleLift;
    final circle = Rect.fromLTWH(0, circleTop, diameter, diameter);
    final chimney = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, diameter, circleTop + radius),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    return Path()
      ..addOval(circle)
      ..addRRect(chimney);
  }

  @override
  bool shouldReclip(covariant _PopOutClipper oldClipper) =>
      oldClipper.circleLift != circleLift;
}

class _SidebarLink extends StatelessWidget {
  const _SidebarLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.nav(
                fontSize: 15,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active ? Colors.white : AppColors.sidebarTextMuted,
              ),
            ),
            if (active) ...[
              const SizedBox(height: 4),
              Container(
                width: 56,
                height: 1.5,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
