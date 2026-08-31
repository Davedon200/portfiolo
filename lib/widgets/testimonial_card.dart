import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key, required this.testimonial});

  final SiteTestimonial testimonial;

  static const _avatarOverlap = 40.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: _avatarOverlap),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, _avatarOverlap + 16, 24, 28),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  testimonial.name,
                  style: AppTypography.body(
                    color: AppColors.cvIndigo,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (testimonial.role != null || testimonial.company != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    [
                      if (testimonial.role != null) testimonial.role!,
                      if (testimonial.company != null) testimonial.company!,
                    ].join(' · '),
                    textAlign: TextAlign.center,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  testimonial.quote,
                  textAlign: TextAlign.center,
                  style: AppTypography.body(
                    color: AppColors.textMutedOnLight,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: i < testimonial.rating
                          ? AppColors.cvBlue
                          : AppColors.cvBlue.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _Avatar(testimonial: testimonial),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.testimonial});

  final SiteTestimonial testimonial;

  @override
  Widget build(BuildContext context) {
    final initials = testimonial.name
        .split(' ')
        .where((p) => p.isNotEmpty)
        .map((p) => p[0])
        .take(2)
        .join()
        .toUpperCase();

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.cvIndigo,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: AppColors.cvIndigo,
        backgroundImage: testimonial.imageAsset != null
            ? AssetImage(testimonial.imageAsset!)
            : null,
        child: testimonial.imageAsset == null
            ? Text(
                initials,
                style: AppTypography.display(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
