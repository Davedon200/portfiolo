import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michael_david/app.dart';
import 'package:michael_david/router/app_router.dart';

void main() {
  testWidgets('Home shows hero content', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MichaelDavidApp());
    await tester.pump();
    expect(find.text('Software Engineer &'), findsOneWidget);
    expect(find.text('Senior Full stack'), findsOneWidget);
    expect(find.text('Mobile Developer'), findsOneWidget);
    expect(find.text('Available for hire'), findsOneWidget);
    expect(find.text('View Case Studies'), findsOneWidget);
    expect(find.text('CV / Resume'), findsOneWidget);
    expect(find.text('Book a 20-min call'), findsOneWidget);
  });

  testWidgets('Portfolio page shows Professional Summary', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MichaelDavidApp());
    await tester.pump();
    appRouter.go('/projects');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1000));

    expect(find.text('Professional Summary'), findsOneWidget);
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.text('By the numbers'), findsOneWidget);
    expect(find.textContaining('Mobile Engineer'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Availability'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Availability'), findsOneWidget);
    expect(find.text('Book a call'), findsWidgets);
  });
}
