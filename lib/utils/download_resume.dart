import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/utils/asset_paths.dart';
import 'package:michael_david/utils/download_resume_web.dart'
    if (dart.library.io) 'package:michael_david/utils/download_resume_io.dart'
    as platform;

Future<void> downloadResume() async {
  if (kIsWeb) {
    platform.downloadFromUrl(resumePublicUrl, SiteConfig.resumeFileName);
    return;
  }

  final data = await rootBundle.load(SiteConfig.resumeAsset);
  final bytes = data.buffer.asUint8List();
  platform.downloadBytes(bytes, SiteConfig.resumeFileName);
}
