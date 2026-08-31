import 'package:flutter/material.dart';

abstract class PageTransitions {
  static const portfolioDuration = Duration(milliseconds: 750);
  static const portfolioReverseDuration = Duration(milliseconds: 520);

  /// Fade + gentle slide — used when entering the portfolio page from home.
  static Widget portfolioEnter(
    Animation<double> animation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.035, 0.025),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }

  static Widget fade(
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
      child: child,
    );
  }
}
