import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/theme/app_colors.dart';
import 'package:michael_david/theme/app_typography.dart';
import 'package:michael_david/utils/download_resume.dart';
import 'package:michael_david/utils/open_external.dart';
import 'package:michael_david/widgets/challenge_grid.dart';
import 'package:michael_david/widgets/content_card.dart';
import 'package:michael_david/widgets/content_section_header.dart';
import 'package:michael_david/widgets/gradient_button.dart';
import 'package:michael_david/widgets/portfolio_sidebar.dart';
import 'package:michael_david/widgets/project_grid.dart';
import 'package:michael_david/widgets/skill_grid.dart';
import 'package:michael_david/widgets/social_rail.dart';
import 'package:michael_david/widgets/stats_row.dart';
import 'package:michael_david/widgets/testimonial_card.dart';
import 'package:michael_david/utils/url_fragment.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, this.initialSection});

  final String? initialSection;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  static const _entranceDuration = Duration(milliseconds: 900);
  static const _sectionOrder = <String>[
    'about',
    'stats',
    'experience',
    'skills',
    'portfolio',
    'challenges',
    'achievements',
    'testimonials',
    'availability',
    'contact',
  ];

  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    for (final id in _sectionOrder) id: GlobalKey(),
  };

  String _activeSection = 'about';
  bool _programmaticScroll = false;
  bool _initialScrollDone = false;

  late final AnimationController _entranceController;
  late final Animation<double> _sidebarFade;
  late final Animation<Offset> _sidebarSlide;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;
  bool _entranceStarted = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _entranceController = AnimationController(
      vsync: this,
      duration: _entranceDuration,
    );
    _sidebarFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
    );
    _sidebarSlide = Tween<Offset>(
      begin: const Offset(-0.14, 0),
      end: Offset.zero,
    ).animate(_sidebarFade);
    _contentFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.12, 1.0, curve: Curves.easeOutCubic),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0.07, 0.035),
      end: Offset.zero,
    ).animate(_contentFade);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_entranceStarted) return;
    _entranceStarted = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _entranceController.value = 1;
    } else {
      _entranceController.forward();
    }
    _scheduleInitialSectionScroll();
  }

  void _scheduleInitialSectionScroll() {
    final section = widget.initialSection;
    if (section == null || !_sectionOrder.contains(section)) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _initialScrollDone) return;
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted || _initialScrollDone) return;
      _initialScrollDone = true;
      await _scrollToSection(section, syncFragment: false);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_programmaticScroll || !mounted) return;
    final next = _sectionAtViewport();
    if (next != null && next != _activeSection) {
      setState(() => _activeSection = next);
      replaceUrlFragment(next);
    }
  }

  String? _sectionAtViewport() {
    final probeY = MediaQuery.sizeOf(context).height * 0.28;
    String? bestId;
    var bestDistance = double.infinity;

    for (final id in _sectionOrder) {
      final ctx = _sectionKeys[id]?.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      final bottom = top + box.size.height;
      if (top <= probeY && bottom >= probeY) return id;
      final distance = (top - probeY).abs();
      if (distance < bestDistance) {
        bestDistance = distance;
        bestId = id;
      }
    }
    return bestId;
  }

  Future<void> _scrollToSection(
    String sectionId, {
    bool syncFragment = true,
  }) async {
    final context = _sectionKeys[sectionId]?.currentContext;
    if (context == null) return;

    setState(() {
      _activeSection = sectionId;
      _programmaticScroll = true;
    });
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
    if (!mounted) return;
    setState(() => _programmaticScroll = false);
    if (syncFragment) {
      replaceUrlFragment(sectionId);
    }
  }

  Widget _animatedSidebar(PortfolioSidebar sidebar) {
    return FadeTransition(
      opacity: _sidebarFade,
      child: SlideTransition(position: _sidebarSlide, child: sidebar),
    );
  }

  Widget _animatedContent(Widget content) {
    return FadeTransition(
      opacity: _contentFade,
      child: SlideTransition(position: _contentSlide, child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final content = _PortfolioContent(
      scrollController: _scrollController,
      sectionKeys: _sectionKeys,
      wide: wide,
    );

    if (!wide) {
      return Scaffold(
        backgroundColor: AppColors.surfaceLight,
        drawer: Drawer(
          backgroundColor: AppColors.sidebarBottom,
          child: SafeArea(
            child: PortfolioSidebar(
              activeSection: _activeSection,
              onSectionTap: (id) {
                Navigator.of(context).pop();
                _scrollToSection(id);
              },
              width: double.infinity,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.sidebarBottom,
          foregroundColor: Colors.white,
          title: Text(
            SiteConfig.name,
            style: AppTypography.display(fontSize: 18, color: Colors.white),
          ),
        ),
        body: _animatedContent(content),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            right: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _animatedSidebar(
                PortfolioSidebar(
                  activeSection: _activeSection,
                  onSectionTap: _scrollToSection,
                ),
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: AppColors.surfaceLight,
              child: _animatedContent(content),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent({
    required this.scrollController,
    required this.sectionKeys,
    required this.wide,
  });

  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final padding = wide
        ? const EdgeInsets.fromLTRB(40, 36, 48, 64)
        : const EdgeInsets.fromLTRB(20, 20, 20, 48);
    final gap = wide ? 44.0 : 36.0;

    return Stack(
      children: [
        const Positioned.fill(child: _ContentGlow()),
        ListView(
          controller: scrollController,
          padding: padding,
          children: [
            KeyedSubtree(
              key: sectionKeys['about'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: SiteConfig.aboutTitle,
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Text(
                      SiteConfig.aboutBody,
                      style: AppTypography.body(
                        color: AppColors.textMutedOnLight,
                        fontSize: 15,
                        height: 1.65,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  GradientButton(
                    label: 'Download CV',
                    onPressed: downloadResume,
                  ),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['stats'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'By the numbers',
                    icon: Icons.insights_outlined,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.statsIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StatsRow(stats: SiteConfig.siteStats),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['experience'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Experience',
                    icon: Icons.work_outline,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.experienceIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (var i = 0; i < SiteConfig.experiences.length; i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    ContentCard(
                      icon: _iconFor(SiteConfig.experiences[i].icon),
                      title: SiteConfig.experiences[i].role,
                      subtitle:
                          '${SiteConfig.experiences[i].org} · ${SiteConfig.experiences[i].period}',
                      body: SiteConfig.experiences[i].detail,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['skills'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Skills',
                    icon: Icons.psychology_outlined,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.skillsIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SkillsGrid(groups: SiteConfig.skillGroups),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['portfolio'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Portfolio',
                    icon: Icons.grid_view_rounded,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.portfolioIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ProjectGrid(
                    projects: SiteConfig.portfolioProjects,
                  ),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['challenges'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Animation & UI Challenges',
                    icon: Icons.auto_awesome,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.challengesIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ChallengeGrid(
                    challenges: SiteConfig.uiChallenges,
                    wide: wide,
                  ),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['achievements'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Certifications',
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.achievementsIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (var i = 0;
                      i < SiteConfig.portfolioAchievements.length;
                      i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    ContentCard(
                      icon: Icons.workspace_premium_outlined,
                      title: SiteConfig.portfolioAchievements[i].title,
                      subtitle: SiteConfig.portfolioAchievements[i].year,
                      body: SiteConfig.portfolioAchievements[i].detail,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['testimonials'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Testimonials',
                    icon: Icons.format_quote_rounded,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.testimonialsIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  TestimonialsGrid(
                    testimonials: SiteConfig.testimonials,
                  ),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['availability'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Availability',
                    icon: Icons.event_available_outlined,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.availabilityIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final option in SiteConfig.availabilityOptions)
                        _StaticChip(label: option),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    SiteConfig.responseTime,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    label: 'Book a call',
                    icon: Icons.calendar_month_outlined,
                    onPressed: () => openExternal(SiteConfig.calendlyUrl),
                  ),
                ],
              ),
            ),
            SizedBox(height: gap),
            KeyedSubtree(
              key: sectionKeys['contact'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContentSectionHeader(
                    title: 'Contact',
                    icon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    SiteConfig.contactIntro,
                    style: AppTypography.body(
                      color: AppColors.textMutedOnLight,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      GradientButton(
                        label: 'Email me',
                        icon: Icons.mail_outline,
                        onPressed: () =>
                            openExternal('mailto:${SiteConfig.email}'),
                      ),
                      GradientButton(
                        label: 'Book a call',
                        icon: Icons.calendar_month_outlined,
                        onPressed: () => openExternal(SiteConfig.calendlyUrl),
                      ),
                      _OutlineChip(
                        label: SiteConfig.phone,
                        onTap: () => openExternal('tel:${SiteConfig.phone}'),
                      ),
                      _OutlineChip(
                        label: 'LinkedIn',
                        onTap: () => openExternal(SiteConfig.linkedin),
                      ),
                      _OutlineChip(
                        label: 'GitHub',
                        onTap: () => openExternal(SiteConfig.github),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const SocialRail(vertical: false, circleSize: 40),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: Text(
                      '← Back to home',
                      style: AppTypography.body(
                        color: AppColors.cvIndigo,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

IconData _iconFor(String key) {
  switch (key) {
    case 'account_balance':
      return Icons.account_balance_outlined;
    case 'movie':
      return Icons.movie_outlined;
    case 'phone_iphone':
      return Icons.phone_iphone;
    case 'architecture':
      return Icons.architecture;
    case 'api':
      return Icons.hub_outlined;
    case 'code':
      return Icons.code;
    case 'work':
    default:
      return Icons.work_outline;
  }
}

class _ContentGlow extends StatelessWidget {
  const _ContentGlow();

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
            bottom: 120,
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

class _OutlineChip extends StatelessWidget {
  const _OutlineChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            label,
            style: AppTypography.body(
              color: AppColors.textOnLight,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _StaticChip extends StatelessWidget {
  const _StaticChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        label,
        style: AppTypography.body(
          color: AppColors.textOnLight,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
