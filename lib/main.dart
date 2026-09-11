import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:michael_david/app.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MichaelDavidApp());
}
