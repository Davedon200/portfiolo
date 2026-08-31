import 'dart:typed_data';

import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/utils/open_external.dart';

void downloadBytes(Uint8List bytes, String fileName) {
  // Non-web: open LinkedIn until a native file-share path is added.
  // ignore: discarded_futures
  openExternal(SiteConfig.linkedin);
}
