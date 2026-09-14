import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/widgets/project_gallery_dialog.dart';
import 'package:michael_david/widgets/project_video_dialog.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key, required this.projects});

  final List<PortfolioProject> projects;

  @override
  Widget build(BuildContext context) {
    final production =
        projects.where((p) => p.category == ProjectCategory.production).toList();
    final personal =
        projects.where((p) => p.category == ProjectCategory.personal).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (production.isNotEmpty) ...[
          _ProjectGroup(projects: production),
          if (personal.isNotEmpty) const SizedBox(height: 24),
        ],
        if (personal.isNotEmpty)
          _ProjectGroup(
            projects: personal,
            label: production.isNotEmpty ? 'Personal builds' : null,
          ),
      ],
    );
  }
}

class _ProjectGroup extends StatelessWidget {
  const _ProjectGroup({
    required this.projects,
    this.label,
  });

  final List<PortfolioProject> projects;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.body(
              color: AppColors.textMutedOnLight,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
        ],
        _ResponsiveProjectGrid(projects: projects),
      ],
    );
  }
}

class _ResponsiveProjectGrid extends StatelessWidget {
  const _ResponsiveProjectGrid({required this.projects});

  final List<PortfolioProject> projects;

  static const _gap = 16.0;
  static const _rowHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final rows = _packRows(maxWidth);
        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: _gap),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < rows[r].length; i++) ...[
                    if (i > 0) const SizedBox(width: _gap),
                    SizedBox(
                      width: rows[r][i].width,
                      child: _ProjectTile(
                        project: rows[r][i].project,
                        height: _rowHeight,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  List<List<_RowItem>> _packRows(double maxWidth) {
    final buckets = <List<PortfolioProject>>[];
    var row = <PortfolioProject>[];

    double usedWidth(List<PortfolioProject> items) {
      if (items.isEmpty) return 0;
      return items.fold<double>(0, (sum, p) => sum + _naturalWidth(p, maxWidth)) +
          _gap * (items.length - 1);
    }

    for (final project in projects) {
      final next = [...row, project];
      if (row.isNotEmpty && usedWidth(next) > maxWidth) {
        buckets.add(row);
        row = [project];
      } else {
        row.add(project);
      }
    }
    if (row.isNotEmpty) buckets.add(row);

    return [
      for (var i = 0; i < buckets.length; i++)
        _scaleRow(
          buckets[i],
          maxWidth,
          stretch: i < buckets.length - 1 || buckets[i].length > 1,
        ),
    ];
  }

  double _naturalWidth(PortfolioProject project, double maxWidth) {
    final ratio = project.heightRatio <= 0 ? 1.0 : project.heightRatio;
    return (_rowHeight / ratio).clamp(80.0, maxWidth);
  }

  List<_RowItem> _scaleRow(
    List<PortfolioProject> row,
    double maxWidth, {
    required bool stretch,
  }) {
    final naturals = [
      for (final project in row) _naturalWidth(project, maxWidth),
    ];
    final sum = naturals.fold<double>(0, (a, b) => a + b);
    final gaps = _gap * (row.length - 1);
    final target = (maxWidth - gaps).clamp(0.0, maxWidth);
    var scale = 1.0;
    if (stretch && sum > 0) {
      scale = target / sum;
      if (row.length == 1 && scale > 1.5) scale = 1.0;
    }
    final widths = [for (final w in naturals) w * scale];
    if (stretch && widths.length > 1) {
      final used = widths.fold<double>(0, (a, b) => a + b);
      widths[widths.length - 1] += target - used;
    }
    return [
      for (var i = 0; i < row.length; i++) _RowItem(row[i], widths[i]),
    ];
  }
}

class _RowItem {
  const _RowItem(this.project, this.width);

  final PortfolioProject project;
  final double width;
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({required this.project, required this.height});

  final PortfolioProject project;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isVideo = project.videoUrl != null;
    final galleryCount = project.galleryImages.length;
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: () {
          if (isVideo) {
            showProjectVideoDialog(context, project);
          } else {
            showProjectGalleryDialog(context, project);
          }
        },
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    project.imageAsset,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.82),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 32, 14, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              project.title,
                              style: AppTypography.body(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              project.detail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.body(
                                color: Colors.white.withValues(alpha: 0.82),
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                            if (project.tag != null) ...[
                              const SizedBox(height: 6),
                              Text(
                                project.tag!,
                                style: AppTypography.body(
                                  color: Colors.white.withValues(alpha: 0.88),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            if (project.metrics != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                project.metrics!,
                                style: AppTypography.body(
                                  color: Colors.white.withValues(alpha: 0.72),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isVideo)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.play_circle_outline,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Play demo',
                                style: AppTypography.body(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (galleryCount > 1)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.photo_library_outlined,
                                size: 13,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$galleryCount photos',
                                style: AppTypography.body(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
