import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/utils/open_external.dart';
import 'package:michael_david/utils/download_resume_web.dart'
    if (dart.library.io) 'package:michael_david/utils/download_resume_io.dart'
    as platform;

Future<void> downloadResume() async {
  final data = await rootBundle.load(SiteConfig.resumeAsset);
  final bytes = data.buffer.asUint8List();

  if (kIsWeb) {
    platform.downloadBytes(bytes, SiteConfig.resumeFileName);
    return;
  }

  // Desktop / mobile: open the bundled asset URL if served, else GitHub profile.
  final uri = Uri.base.resolve('assets/${SiteConfig.resumeAsset}');
  try {
    await openExternal(uri.toString());
  } catch (_) {
    await openExternal(SiteConfig.github);
  }
}
