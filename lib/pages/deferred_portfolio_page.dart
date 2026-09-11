import 'package:flutter/material.dart';
import 'package:michael_david/pages/portfolio_page.dart' deferred as portfolio;

/// Loads [PortfolioPage] on demand so the home route stays lean.
class DeferredPortfolioPage extends StatefulWidget {
  const DeferredPortfolioPage({super.key, this.initialSection});

  final String? initialSection;

  @override
  State<DeferredPortfolioPage> createState() => _DeferredPortfolioPageState();
}

class _DeferredPortfolioPageState extends State<DeferredPortfolioPage> {
  late final Future<void> _library = portfolio.loadLibrary();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _library,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Could not load portfolio: ${snapshot.error}'),
            ),
          );
        }
        return portfolio.PortfolioPage(initialSection: widget.initialSection);
      },
    );
  }
}
