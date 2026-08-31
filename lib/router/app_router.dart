import 'package:go_router/go_router.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/pages/home_page.dart';
import 'package:michael_david/pages/portfolio_page.dart';
import 'package:michael_david/pages/section_page.dart';
import 'package:michael_david/router/page_transitions.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final loc = state.uri.path;
    if (loc.length > 1 && loc.endsWith('/')) {
      return loc.substring(0, loc.length - 1);
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondary, child) {
          return PageTransitions.fade(animation, child);
        },
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) {
        final fragment = state.uri.fragment;
        final initialSection =
            fragment.isNotEmpty && fragment != 'home' ? fragment : null;
        return CustomTransitionPage(
          key: state.pageKey,
          child: PortfolioPage(initialSection: initialSection),
          transitionDuration: PageTransitions.portfolioDuration,
          reverseTransitionDuration: PageTransitions.portfolioReverseDuration,
          transitionsBuilder: (context, animation, secondary, child) {
            return PageTransitions.portfolioEnter(animation, child);
          },
        );
      },
    ),
    ...SiteConfig.sections.map(
      (section) => GoRoute(
        path: section.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: SectionPage(section: section),
          transitionsBuilder: (context, animation, secondary, child) {
            return PageTransitions.fade(animation, child);
          },
        ),
      ),
    ),
  ],
);
