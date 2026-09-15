import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/open_external.dart';
import 'package:michael_david/widgets/brand_logo.dart';
import 'package:michael_david/widgets/site_header.dart';
import 'package:michael_david/widgets/social_rail.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({super.key, required this.section});

  final SiteSection section;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: Column(
        children: [
          SiteHeader(wide: wide),
          Expanded(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primaryDeep.withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
                ListView(
                  padding: EdgeInsets.fromLTRB(
                    wide ? 48 : 20,
                    36,
                    wide ? 48 : 20,
                    48,
                  ),
                  children: [
                    Text(
                      section.eyebrow,
                      style: AppTypography.body(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ).copyWith(letterSpacing: 2.2),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      section.title,
                      style: AppTypography.display(
                        fontSize: wide ? 42 : 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Text(
                        section.lead,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: AppColors.whiteMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Achievements',
                      style: AppTypography.display(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: AppColors.whiteSoft),
                    const SizedBox(height: 16),
                    ...section.achievements.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 56,
                              child: Text(
                                a.year,
                                style: AppTypography.body(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ).copyWith(letterSpacing: 1),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    a.detail,
                                    style: const TextStyle(
                                      color: AppColors.whiteMuted,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Projects',
                      style: AppTypography.display(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: AppColors.whiteSoft),
                    ...section.projects.map(
                      (p) => InkWell(
                        onTap: p.url == null ? null : () => openExternal(p.url!),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.title,
                                      style: AppTypography.display(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      p.detail,
                                      style: const TextStyle(
                                        color: AppColors.whiteMuted,
                                        height: 1.45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                p.tag.toUpperCase(),
                                style: AppTypography.body(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteMuted,
                                ).copyWith(letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Divider(color: AppColors.whiteSoft),
                    const SizedBox(height: 16),
                    // Bottom brand + platform logos
                    Row(
                      children: [
                        const BrandLogo(size: 28),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Reach out anytime.',
                            style: TextStyle(color: AppColors.whiteMuted),
                          ),
                        ),
                        const SocialRail(vertical: false),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
