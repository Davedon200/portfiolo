import 'package:flutter/foundation.dart';

/// Resolves asset paths for web (relative to [base href]) vs bundled Flutter assets.
String resolveAssetPath(String assetPath) {
  assert(assetPath.startsWith('assets/'), 'Expected Flutter asset path');
  if (kIsWeb) {
    const version = String.fromEnvironment('APP_VERSION');
    // Production: files live at /{version}/assets/... while the document URL is /.
    if (version.isNotEmpty) {
      return '/$version/$assetPath';
    }
    return assetPath;
  }
  return assetPath;
}

/// Public URL for resume PDF (served from [web/assets/docs] on web).
String get resumePublicUrl => resolveAssetPath('assets/docs/michael_david_resume.pdf');
