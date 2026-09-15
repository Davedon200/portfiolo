import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/widgets/brand_logo.dart';

class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key, required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;

    return Material(
      color: AppColors.primary.withValues(alpha: 0.92),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 12, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.whiteSoft)),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: () => context.go('/'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandLogo(size: 32),
                  const SizedBox(width: 10),
                  Text(
                    SiteConfig.name,
                    style: AppTypography.nav(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (wide)
              ...[
                _HeaderLink(label: 'Home', path: '/', current: path),
                _HeaderLink(label: 'Projects', path: '/projects', current: path),
                ...SiteConfig.sections.map(
                  (s) => _HeaderLink(
                    label: s.navLabel,
                    path: s.path,
                    current: path,
                  ),
                ),
              ]
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _HeaderLink(label: 'Home', path: '/', current: path),
                  _HeaderLink(label: 'Projects', path: '/projects', current: path),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({
    required this.label,
    required this.path,
    required this.current,
  });

  final String label;
  final String path;
  final String current;

  @override
  Widget build(BuildContext context) {
    final active = current == path || (path != '/' && current.startsWith(path));
    return TextButton(
      onPressed: () => context.go(path),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : AppColors.whiteMuted,
          fontWeight: active ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}
