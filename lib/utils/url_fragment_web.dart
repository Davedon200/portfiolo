import 'package:web/web.dart' as web;

void replaceUrlFragment(String fragment) {
  final path = web.window.location.pathname;
  web.window.history.replaceState(null, '', '$path#$fragment');
}
