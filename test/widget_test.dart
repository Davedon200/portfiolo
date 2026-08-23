import 'package:flutter_test/flutter_test.dart';
import 'package:michael_david/main.dart';

void main() {
  testWidgets('Home shows Michael David', (tester) async {
    await tester.pumpWidget(const MichaelDavidApp());
    await tester.pumpAndSettle();
    expect(find.text('Michael David'), findsWidgets);
    expect(find.text('View more'), findsOneWidget);
  });
}
