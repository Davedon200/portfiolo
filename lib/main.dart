import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ——— Site content (edit me) ———

class SiteConfig {
  static const name = 'Michael David';
  static const bornLabel = 'Born in';
  static const bornValue = '19XX, Country';
  static const roles = <({String title, String org})>[
    (title: 'Senior Software Designer', org: 'Your Company'),
    (title: 'Creative director', org: 'Your Studio'),
  ];

  static const email = 'you@email.com';
  static const whatsapp = '2348012345678';
  static const phone = '+2348012345678';
  static const linkedin = 'https://www.linkedin.com/in/your-profile';
  static const instagram = 'https://www.instagram.com/your-handle';
  static const x = 'https://x.com/your-handle';

  static final sections = <SiteSection>[
    SiteSection(
      path: '/tech',
      eyebrow: '/tech',
      title: 'Technology',
      lead:
          'Software, product design, and digital systems — the work that ships, scales, and shapes how people interact with technology.',
      navLabel: 'Tech',
      achievements: const [
        SiteAchievement(
          year: '2024',
          title: 'Replace with your achievement',
          detail:
              'Short outcome-focused line — what you led, shipped, or won (award, launch, metric).',
        ),
        SiteAchievement(
          year: '2022',
          title: 'Another milestone',
          detail:
              'Certifications, promotions, patents, open-source impact, or conference talks.',
        ),
        SiteAchievement(
          year: '2020',
          title: 'Career highlight',
          detail: 'Keep each entry tight: context + your role + the result.',
        ),
      ],
      projects: const [
        SiteProject(
          title: 'Project name',
          detail: 'One-sentence description of what you built and who it was for.',
          tag: 'Product',
        ),
        SiteProject(
          title: 'Another build',
          detail: 'Stack, scope, and outcome — link out to the live site or case study.',
          tag: 'Engineering',
        ),
        SiteProject(
          title: 'Internal / confidential work',
          detail: 'Describe without a link if you can’t share URLs publicly.',
          tag: 'Design',
        ),
      ],
    ),
    SiteSection(
      path: '/admin',
      eyebrow: '/admin',
      title: 'Administration',
      lead:
          'Operations, leadership, and organizational systems — how teams, processes, and institutions actually get things done.',
      navLabel: 'Admin',
      achievements: const [
        SiteAchievement(
          year: '2025',
          title: 'Replace with your achievement',
          detail:
              'Policy wins, process overhauls, team growth, budget stewardship, or recognitions.',
        ),
        SiteAchievement(
          year: '2023',
          title: 'Leadership milestone',
          detail: 'Roles held, committees chaired, or reforms you drove end-to-end.',
        ),
        SiteAchievement(
          year: '2021',
          title: 'Operational impact',
          detail:
              'Quantify where you can — time saved, compliance improved, people served.',
        ),
      ],
      projects: const [
        SiteProject(
          title: 'Initiative name',
          detail: 'What problem you tackled, the approach, and the lasting change.',
          tag: 'Operations',
        ),
        SiteProject(
          title: 'Program or reform',
          detail: 'Stakeholders, timeline, and outcome — keep it scannable.',
          tag: 'Governance',
        ),
        SiteProject(
          title: 'Cross-functional effort',
          detail: 'Where admin work unlocked tech, property, or community results.',
          tag: 'Strategy',
        ),
      ],
    ),
    SiteSection(
      path: '/real-estate',
      eyebrow: '/real-estate',
      title: 'Real Estate',
      lead:
          'Property, development, and deals — the portfolio of places and projects you’ve shaped on the ground.',
      navLabel: 'Real Estate',
      achievements: const [
        SiteAchievement(
          year: '2025',
          title: 'Replace with your achievement',
          detail:
              'Closings, portfolio value, licenses, or market recognition worth calling out.',
        ),
        SiteAchievement(
          year: '2023',
          title: 'Deal or development win',
          detail:
              'Location, scale, and your role — keep numbers where you’re comfortable sharing.',
        ),
        SiteAchievement(
          year: '2021',
          title: 'Industry milestone',
          detail: 'Partnerships, awards, or firsts in your market.',
        ),
      ],
      projects: const [
        SiteProject(
          title: 'Property or development name',
          detail: 'Type, location, and what made the project distinctive.',
          tag: 'Residential',
        ),
        SiteProject(
          title: 'Commercial / mixed-use',
          detail: 'Scope, partners, and outcome for buyers, tenants, or community.',
          tag: 'Commercial',
        ),
        SiteProject(
          title: 'Investment or brokerage highlight',
          detail: 'Transaction story without exposing private client details.',
          tag: 'Investment',
        ),
      ],
    ),
  ];
}

class SiteSection {
  const SiteSection({
    required this.path,
    required this.eyebrow,
    required this.title,
    required this.lead,
    required this.navLabel,
    required this.achievements,
    required this.projects,
  });

  final String path;
  final String eyebrow;
  final String title;
  final String lead;
  final String navLabel;
  final List<SiteAchievement> achievements;
  final List<SiteProject> projects;
}

class SiteAchievement {
  const SiteAchievement({
    required this.year,
    required this.title,
    required this.detail,
  });

  final String year;
  final String title;
  final String detail;
}

class SiteProject {
  const SiteProject({
    required this.title,
    required this.detail,
    required this.tag,
    this.url,
  });

  final String title;
  final String detail;
  final String tag;
  final String? url;
}

class AppColors {
  static const purple = Color(0xFF2B1154);
  static const purpleDeep = Color(0xFF1A0A33);
  static const purpleMid = Color(0xFF3D1A6E);
  static const magenta = Color(0xFFD81B60);
  static const whiteMuted = Color(0xB8FFFFFF);
  static const whiteSoft = Color(0x1FFFFFFF);
}

Future<void> openExternal(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondary, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    ...SiteConfig.sections.map(
      (section) => GoRoute(
        path: section.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: SectionPage(section: section),
          transitionsBuilder: (context, animation, secondary, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
    ),
  ],
);

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MichaelDavidApp());
}

class MichaelDavidApp extends StatelessWidget {
  const MichaelDavidApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.purple,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        brightness: Brightness.dark,
        primary: AppColors.magenta,
      ),
    );

    return MaterialApp.router(
      title: 'Michael David',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: base.copyWith(
        textTheme: GoogleFonts.manropeTextTheme(base.textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
    );
  }
}

// ——— Contact ———

class ContactLink {
  const ContactLink({
    required this.label,
    required this.icon,
    required this.url,
  });

  final String label;
  final IconData icon;
  final String url;
}

List<ContactLink> contactLinks() => [
      ContactLink(
        label: 'Email',
        icon: Icons.mail_outline,
        url: 'mailto:${SiteConfig.email}',
      ),
      ContactLink(
        label: 'WhatsApp',
        icon: Icons.chat_bubble_outline,
        url: 'https://wa.me/${SiteConfig.whatsapp}',
      ),
      ContactLink(
        label: 'Call',
        icon: Icons.phone_outlined,
        url: 'tel:${SiteConfig.phone}',
      ),
      ContactLink(
        label: 'LinkedIn',
        icon: Icons.work_outline,
        url: SiteConfig.linkedin,
      ),
      ContactLink(
        label: 'Instagram',
        icon: Icons.camera_alt_outlined,
        url: SiteConfig.instagram,
      ),
      ContactLink(
        label: 'X',
        icon: Icons.alternate_email,
        url: SiteConfig.x,
      ),
    ];

class SocialRail extends StatelessWidget {
  const SocialRail({super.key, this.vertical = true});

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final children = contactLinks()
        .map(
          (c) => IconButton(
            tooltip: c.label,
            onPressed: () => openExternal(c.url),
            icon: Icon(c.icon, size: 18, color: Colors.white.withValues(alpha: 0.85)),
          ),
        )
        .toList();

    return vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: children)
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

class NavMenuButton extends StatelessWidget {
  const NavMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Menu',
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Close menu',
          barrierColor: AppColors.purpleDeep.withValues(alpha: 0.92),
          transitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (context, animation, secondary) {
            return FadeTransition(
              opacity: animation,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavLink(label: 'Home', path: '/'),
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
      icon: const Icon(Icons.menu, color: Colors.white),
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
            color: active ? AppColors.magenta : Colors.white,
          ),
        ),
      ),
    );
  }
}

// ——— Home ———

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: Stack(
        children: [
          wide
              ? Row(
                  children: [
                    const Expanded(child: _PortraitPanel()),
                    Expanded(child: _IntroPanel(wide: wide)),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 280, child: _PortraitPanel()),
                    Expanded(child: _IntroPanel(wide: wide)),
                  ],
                ),
          const Positioned(top: 12, right: 12, child: NavMenuButton()),
          const Positioned(right: 10, bottom: 16, child: SocialRail()),
        ],
      ),
    );
  }
}

class _PortraitPanel extends StatelessWidget {
  const _PortraitPanel();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.purpleMid, AppColors.purpleDeep, Color(0xFF0D041C)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Add assets/images/portrait.jpg',
            textAlign: TextAlign.center,
            style: GoogleFonts.syne(
              color: AppColors.whiteMuted,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroPanel extends StatelessWidget {
  const _IntroPanel({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.purple),
        // Subtle grain substitute
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withValues(alpha: 0.03),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.18),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(wide ? 56 : 28, 48, wide ? 72 : 28, 72),
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
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SiteConfig.name,
                      style: GoogleFonts.syne(
                        fontSize: wide ? 52 : 36,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteMuted,
                        ),
                        children: [
                          TextSpan(text: '${SiteConfig.bornLabel} '),
                          TextSpan(
                            text: SiteConfig.bornValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...SiteConfig.roles.map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.whiteMuted,
                            ),
                            children: [
                              TextSpan(
                                text: r.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: ' — ${r.org}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.magenta,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () => context.go('/tech'),
                      child: const Text(
                        'View more',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ——— Section pages ———

class SectionPage extends StatelessWidget {
  const SectionPage({super.key, required this.section});

  final SiteSection section;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      body: Column(
        children: [
          _SiteHeader(wide: wide),
          Expanded(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.purple,
                        AppColors.purpleDeep.withValues(alpha: 0.9),
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
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.2,
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      section.title,
                      style: GoogleFonts.syne(
                        fontSize: wide ? 42 : 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
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
                      style: GoogleFonts.syne(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
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
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: AppColors.magenta,
                                ),
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
                      style: GoogleFonts.syne(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
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
                                      style: GoogleFonts.syne(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
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
                                style: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  color: AppColors.whiteMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Divider(color: AppColors.whiteSoft),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Reach out anytime.',
                          style: TextStyle(color: AppColors.whiteMuted),
                        ),
                        const Spacer(),
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

class _SiteHeader extends StatelessWidget {
  const _SiteHeader({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;

    return Material(
      color: AppColors.purple.withValues(alpha: 0.92),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wide ? 40 : 12, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.whiteSoft)),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                SiteConfig.name,
                style: GoogleFonts.syne(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            if (wide)
              ...[
                _HeaderLink(label: 'Home', path: '/', current: path),
                ...SiteConfig.sections.map(
                  (s) => _HeaderLink(
                    label: s.navLabel,
                    path: s.path,
                    current: path,
                  ),
                ),
              ]
            else
              const NavMenuButton(),
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
