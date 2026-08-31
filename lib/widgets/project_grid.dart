import 'package:flutter/material.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/open_external.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key, required this.projects, required this.wide});

  final List<PortfolioProject> projects;
  final bool wide;

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
          _ProjectGroup(projects: production, wide: wide),
          if (personal.isNotEmpty) const SizedBox(height: 24),
        ],
        if (personal.isNotEmpty)
          _ProjectGroup(
            projects: personal,
            wide: wide,
            label: production.isNotEmpty ? 'Personal builds' : null,
          ),
      ],
    );
  }
}

class _ProjectGroup extends StatelessWidget {
  const _ProjectGroup({
    required this.projects,
    required this.wide,
    this.label,
  });

  final List<PortfolioProject> projects;
  final bool wide;
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
        if (!wide)
          Column(
            children: [
              for (var i = 0; i < projects.length; i++)
                Padding(
                  padding:
                      EdgeInsets.only(bottom: i < projects.length - 1 ? 16 : 0),
                  child: _ProjectTile(
                    project: projects[i],
                    height: 220 * projects[i].heightRatio,
                  ),
                ),
            ],
          )
        else
          _MasonryGrid(projects: projects),
      ],
    );
  }
}

class _MasonryGrid extends StatelessWidget {
  const _MasonryGrid({required this.projects});

  final List<PortfolioProject> projects;

  @override
  Widget build(BuildContext context) {
    final left = <PortfolioProject>[];
    final right = <PortfolioProject>[];
    var leftWeight = 0.0;
    var rightWeight = 0.0;

    for (final project in projects) {
      if (leftWeight <= rightWeight) {
        left.add(project);
        leftWeight += project.heightRatio;
      } else {
        right.add(project);
        rightWeight += project.heightRatio;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnWidth = (constraints.maxWidth - 16) / 2;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < left.length; i++)
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: i < left.length - 1 ? 16 : 0),
                      child: _ProjectTile(
                        project: left[i],
                        height: columnWidth * left[i].heightRatio,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  for (var i = 0; i < right.length; i++)
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: i < right.length - 1 ? 16 : 0),
                      child: _ProjectTile(
                        project: right[i],
                        height: columnWidth * right[i].heightRatio,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({required this.project, required this.height});

  final PortfolioProject project;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: project.url != null ? () => openExternal(project.url!) : null,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(project.imageAsset, fit: BoxFit.cover),
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
                          Colors.black.withValues(alpha: 0.75),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 28, 14, 14),
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
                          if (project.tag != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              project.tag!,
                              style: AppTypography.body(
                                color: Colors.white.withValues(alpha: 0.85),
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
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 11,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
    );
  }
}
