import 'challenge_video_stub.dart'
    if (dart.library.js_interop) 'challenge_video_web.dart';

import 'package:flutter/widgets.dart';

Widget challengeVideo(String webmUrl, String mp4Url) {
  return buildChallengeVideo(webmUrl, mp4Url);
}
