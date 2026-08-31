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
                  const SizedBox(height: 24),
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

/// White ring with a zoomed head-and-shoulders crop. Only the head pops out.
class _SidebarAvatar extends StatelessWidget {
  const _SidebarAvatar();

  static const _ring = 140.0;
  static const _overflow = 36.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _ring,
      height: _ring + _overflow,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
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
          Positioned.fill(
            child: ClipPath(
              clipper: const _PopOutClipper(),
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: Transform.scale(
                  scale: 2.2,
                  alignment: const Alignment(0, -0.75),
                  child: Image.asset(
                    'assets/images/portrait_cutout.png',
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, -0.72),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PopOutClipper extends CustomClipper<Path> {
  const _PopOutClipper();

  @override
  Path getClip(Size size) {
    final diameter = size.width;
    final overflow = size.height - diameter;
    final circle = Rect.fromLTWH(0, overflow, diameter, diameter);
    final chimney = Rect.fromLTWH(0, 0, diameter, overflow + diameter * 0.55);

    return Path()
      ..addOval(circle)
      ..addRect(chimney);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
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
