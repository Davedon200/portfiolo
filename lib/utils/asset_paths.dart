import 'package:flutter/foundation.dart';

/// Resolves asset paths for web (static `/assets/...`) vs bundled Flutter assets.
String resolveAssetPath(String assetPath) {
  assert(assetPath.startsWith('assets/'), 'Expected Flutter asset path');
  if (kIsWeb) {
    return '/$assetPath';
  }
  return assetPath;
}

/// Public URL for resume PDF (served from [web/assets/docs] on web).
String get resumePublicUrl => resolveAssetPath('assets/docs/michael_david_resume.pdf');
