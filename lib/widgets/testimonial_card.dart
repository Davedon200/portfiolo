import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';

class TestimonialsGrid extends StatelessWidget {
  const TestimonialsGrid({super.key, required this.testimonials});

  final List<SiteTestimonial> testimonials;

  static const _gap = 20.0;
  static const _twoColMin = 520.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= _twoColMin ? 2 : 1;
        final rows = <List<SiteTestimonial>>[];
        for (var i = 0; i < testimonials.length; i += cols) {
          rows.add(
            testimonials.sublist(i, math.min(i + cols, testimonials.length)),
          );
        }

        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: _gap),
              if (rows[r].length == 1)
                TestimonialCard(testimonial: rows[r].first)
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < rows[r].length; i++) ...[
                        if (i > 0) const SizedBox(width: _gap),
                        Expanded(
                          child: TestimonialCard(testimonial: rows[r][i]),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

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
          child: DecoratedBox(
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  _avatarOverlap + 16,
                  24,
                  28,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      testimonial.name,
                      textAlign: TextAlign.center,
                      style: AppTypography.body(
                        color: AppColors.cvIndigo,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (testimonial.role != null ||
                        testimonial.company != null) ...[
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
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    _Quote(testimonial: testimonial),
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
          ),
        ),
        _Avatar(testimonial: testimonial),
      ],
    );
  }
}

class _Quote extends StatelessWidget {
  const _Quote({required this.testimonial});

  final SiteTestimonial testimonial;

  @override
  Widget build(BuildContext context) {
    return Text(
      testimonial.quote,
      textAlign: TextAlign.center,
      style: AppTypography.body(
        color: AppColors.textMutedOnLight,
        fontSize: 14,
        height: 1.6,
      ),
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
