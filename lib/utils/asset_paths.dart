/// Resolves asset paths. On web they stay relative so `<base href="/VERSION/">`
/// maps `assets/...` to `/VERSION/assets/...`.
String resolveAssetPath(String assetPath) {
  assert(assetPath.startsWith('assets/'), 'Expected Flutter asset path');
  return assetPath;
}

/// Public URL for resume PDF (served from [web/assets/docs] on web).
String get resumePublicUrl => resolveAssetPath('assets/docs/michael_david_resume.pdf');
