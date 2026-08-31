import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/widgets/brand_logo.dart';

class NavMenuButton extends StatelessWidget {
  const NavMenuButton({super.key, this.iconColor = Colors.white});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Menu',
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Close menu',
          barrierColor: AppColors.primaryDeep.withValues(alpha: 0.92),
          transitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (context, animation, secondary) {
            return FadeTransition(
              opacity: animation,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BrandLogo(size: 72),
                    const SizedBox(height: 28),
                    const _NavLink(label: 'Home', path: '/'),
                    const _NavLink(label: 'Projects', path: '/projects'),
                    ...SiteConfig.sections.map(
                      (s) => _NavLink(label: s.title, path: s.path),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: Icon(Icons.menu, color: iconColor),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.path});

  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    final current = GoRouterState.of(context).uri.path;
    final active = current == path || (path != '/' && current.startsWith(path));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          context.go(path);
        },
        child: Text(
          label,
          style: GoogleFonts.syne(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: active ? AppColors.accent : Colors.white,
          ),
        ),
      ),
    );
  }
}
