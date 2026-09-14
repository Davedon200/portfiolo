import 'dart:async';
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/download_resume.dart';
import 'package:michael_david/utils/open_external.dart';
import 'package:michael_david/widgets/brand_logo.dart';
import 'package:michael_david/widgets/portrait_panel.dart';
import 'package:michael_david/widgets/social_rail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static const _hold = Duration(milliseconds: 400);
  static const _animDuration = Duration(milliseconds: 1400);
  static const _logoStart = 220.0;
  static const _logoEnd = 40.0;

  late final AnimationController _controller;
  late final Animation<double> _logoMove;
  late final Animation<double> _portraitOpacity;
  late final Animation<double> _portraitScale;
  bool _introDone = false;
  bool _started = false;
  Timer? _holdTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animDuration);
    _logoMove = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeInOutCubic),
    );
    _portraitOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _portraitScale = Tween<double>(begin: 1.06, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _introDone = true);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      _introDone = true;
      return;
    }
    _holdTimer = Timer(_hold, () {
      if (mounted && _controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 900;
    final startLeft =
        wide ? size.width * 0.25 - _logoStart / 2 : size.width / 2 - _logoStart / 2;
    final startTop = wide ? size.height / 2 - _logoStart / 2 : 140 - _logoStart / 2;
    const endLeft = 16.0;
    const endTop = 16.0;

    return Scaffold(
      body: Stack(
        children: [
          wide
              ? Row(
                  children: [
                    Expanded(
                      child: PortraitPanel(
                        portraitOpacity: _portraitOpacity,
                        portraitScale: _portraitScale,
                      ),
                    ),
                    Expanded(child: _IntroPanel(wide: wide)),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 280,
                      child: PortraitPanel(
                        portraitOpacity: _portraitOpacity,
                        portraitScale: _portraitScale,
                        compact: true,
                      ),
                    ),
                    Expanded(child: _IntroPanel(wide: wide)),
                  ],
                ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _introDone ? 1.0 : _logoMove.value;
              final logoSize = lerpDouble(_logoStart, _logoEnd, t)!;
              final left = lerpDouble(startLeft, endLeft, t)!;
              final top = lerpDouble(startTop, endTop, t)!;
              return Positioned(
                left: left,
                top: top,
                width: logoSize,
                height: logoSize,
                child: BrandLogo(size: logoSize),
              );
            },
          ),
          const Positioned(right: 10, bottom: 16, child: SocialRail()),
        ],
      ),
    );
  }
}

class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.wide});

  final bool wide;

  static const _textBlack = Colors.black;

  @override
  Widget build(BuildContext context) {
    final titleSize = wide ? 44.0 : 32.0;
    final titleStyle = AppTypography.heroTitle(
      fontSize: titleSize,
      color: _textBlack,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Colors.white),
        const Positioned.fill(child: _IntroGlow()),
        Padding(
          padding: EdgeInsets.fromLTRB(wide ? 56 : 28, 48, wide ? 56 : 28, 48),
          child: Align(
            alignment: wide ? Alignment.centerLeft : Alignment.topLeft,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, t, child) {
                return Opacity(
                  opacity: t,
                  child: Transform.translate(
                    offset: Offset(0, 18 * (1 - t)),
                    child: child,
                  ),
                );
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: wide ? 600 : double.infinity,
                  maxHeight: double.infinity,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AvailabilityPill(wide: wide),
                      SizedBox(height: wide ? 28 : 22),
                      Text(
                        SiteConfig.homeEyebrow,
                        style: AppTypography.heroLabel(
                          color: _textBlack,
                          fontSize: wide ? 11 : 10,
                        ),
                      ),
                      SizedBox(height: wide ? 18 : 14),
                      Text(
                        SiteConfig.homeTitleLine1,
                        style: titleStyle,
                      ),
                      Text(
                        SiteConfig.homeTitleLine2,
                        style: titleStyle,
                      ),
                      Text(
                        SiteConfig.homeTitleLine3,
                        style: titleStyle,
                      ),
                      SizedBox(height: wide ? 22 : 18),
                      Text(
                        SiteConfig.homeHeroBody,
                        textAlign: TextAlign.justify,
                        style: AppTypography.heroBody(
                          fontSize: wide ? 16 : 15,
                          color: _textBlack,
                        ),
                      ),
                      SizedBox(height: wide ? 32 : 26),
                      const _HeroStatsRow(),
                      SizedBox(height: wide ? 32 : 26),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth,
                                ),
                                child: _HeroPrimaryButton(
                                  label: 'Book a 20-min call',
                                  onPressed: () =>
                                      openExternal(SiteConfig.calendlyUrl),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth,
                                ),
                                child: _HeroOutlineButton(
                                  label: 'View Projects',
                                  accent: true,
                                  onPressed: () => context.go('/projects'),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth,
                                ),
                                child: _HeroOutlineButton(
                                  label: 'CV / Resume',
                                  icon: Icons.description_outlined,
                                  onPressed: downloadResume,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackTypes = constraints.maxWidth < 340;

        return Container(
          width: stackTypes ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.availabilityTeal.withValues(alpha: 0.7),
            ),
            color: AppColors.availabilityTeal.withValues(alpha: 0.1),
          ),
          child: stackTypes
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _availabilityDot(),
                        const SizedBox(width: 7),
                        Flexible(
                          child: Text(
                            SiteConfig.homeAvailabilityLabel,
                            style: _labelStyle(wide),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      SiteConfig.homeAvailabilityTypes,
                      style: _typesStyle(wide),
                    ),
                  ],
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _availabilityDot(),
                        const SizedBox(width: 7),
                        Text(
                          SiteConfig.homeAvailabilityLabel,
                          style: _labelStyle(wide),
                        ),
                      ],
                    ),
                    Text(
                      SiteConfig.homeAvailabilityTypes,
                      style: _typesStyle(wide),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _availabilityDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: AppColors.availabilityTeal,
        shape: BoxShape.circle,
      ),
    );
  }

  TextStyle _labelStyle(bool wide) {
    return AppTypography.heroBody(
      fontSize: wide ? 12 : 11,
      fontWeight: FontWeight.w700,
      color: AppColors.availabilityTeal,
      height: 1.2,
    );
  }

  TextStyle _typesStyle(bool wide) {
    return AppTypography.heroBody(
      fontSize: wide ? 11 : 10,
      fontWeight: FontWeight.w500,
      color: AppColors.availabilityTeal,
      height: 1.2,
    );
  }
}

class _HeroStatsRow extends StatelessWidget {
  const _HeroStatsRow();

  static const _textBlack = Colors.black;

  @override
  Widget build(BuildContext context) {
    final stats = SiteConfig.homeHeroStats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'BY THE NUMBERS',
              style: AppTypography.heroLabel(
                color: _textBlack,
                fontSize: 10,
                letterSpacing: 2.8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final useRow = constraints.maxWidth >= 420;
            if (!useRow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < stats.length; i++) ...[
                    if (i > 0) const SizedBox(height: 16),
                    _HeroStatItem(stat: stats[i]),
                  ],
                ],
              );
            }

            // Border dividers avoid IntrinsicHeight (incompatible with wrapping labels).
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < stats.length; i++)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: i == 0 ? 0 : 18),
                      padding: const EdgeInsets.only(left: 18),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppColors.primary,
                            width: 2.5,
                          ),
                        ),
                      ),
                      child: _HeroStatItem(stat: stats[i]),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _HeroStatItem extends StatelessWidget {
  const _HeroStatItem({required this.stat});

  final SiteStat stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stat.value,
          style: AppTypography.heroTitle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          stat.label,
          style: AppTypography.heroBody(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _HeroPrimaryButton extends StatelessWidget {
  const _HeroPrimaryButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDeep, AppColors.primary, AppColors.accent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTypography.heroBody(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroOutlineButton extends StatelessWidget {
  const _HeroOutlineButton({
    required this.label,
    required this.onPressed,
    this.accent = false,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final bool accent;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        accent ? AppColors.primary.withValues(alpha: 0.65) : const Color(0xFFD1D5DB);
    const textColor = Colors.black;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: textColor),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: AppTypography.heroBody(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                if (icon == null) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: textColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroGlow extends StatelessWidget {
  const _IntroGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cvGlowBlue,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cvGlowPink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
