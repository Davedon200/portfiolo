import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/open_external.dart';

Future<void> showProjectGalleryDialog(
  BuildContext context,
  PortfolioProject project,
) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.72),
    builder: (context) => _ProjectGalleryDialog(project: project),
  );
}

class _ProjectGalleryDialog extends StatefulWidget {
  const _ProjectGalleryDialog({required this.project});

  final PortfolioProject project;

  @override
  State<_ProjectGalleryDialog> createState() => _ProjectGalleryDialogState();
}

class _ProjectGalleryDialogState extends State<_ProjectGalleryDialog> {
  late final PageController _pageController;
  late final List<String> _images;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _images = widget.project.galleryImages;
    final cover = widget.project.imageAsset;
    final start = _images.indexOf(cover);
    _index = start >= 0 ? start : 0;
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= _images.length) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final wide = MediaQuery.sizeOf(context).width >= 720;
    final maxWidth = wide ? 720.0 : MediaQuery.sizeOf(context).width - 32;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () =>
            _goTo(_index - 1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () =>
            _goTo(_index + 1),
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).pop(),
      },
      child: Focus(
        autofocus: true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: 860),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primaryDeep,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 8, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              project.title,
                              style: AppTypography.body(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Close',
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ColoredBox(
                        color: const Color(0xFF1A1512),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _images.length,
                              onPageChanged: (i) => setState(() => _index = i),
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Image.asset(
                                    _images[i],
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                                );
                              },
                            ),
                            if (wide && _images.length > 1) ...[
                              Positioned(
                                left: 8,
                                child: _NavCircle(
                                  icon: Icons.chevron_left,
                                  onPressed: _index > 0
                                      ? () => _goTo(_index - 1)
                                      : null,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                child: _NavCircle(
                                  icon: Icons.chevron_right,
                                  onPressed: _index < _images.length - 1
                                      ? () => _goTo(_index + 1)
                                      : null,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_images.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    '${_index + 1} / ${_images.length}',
                                    style: AppTypography.body(
                                      color: AppColors.whiteMuted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: [
                                        for (var i = 0; i < _images.length; i++)
                                          Container(
                                            width: i == _index ? 16 : 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              color: i == _index
                                                  ? AppColors.accent
                                                  : Colors.white
                                                      .withValues(alpha: 0.28),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Text(
                            project.detail,
                            style: AppTypography.body(
                              color: Colors.white.withValues(alpha: 0.88),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          if (project.url != null) ...[
                            const SizedBox(height: 14),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () => openExternal(project.url!),
                                icon: const Icon(
                                  Icons.open_in_new,
                                  size: 16,
                                  color: AppColors.accent,
                                ),
                                label: Text(
                                  'View repo',
                                  style: AppTypography.body(
                                    color: AppColors.accent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavCircle extends StatelessWidget {
  const _NavCircle({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
