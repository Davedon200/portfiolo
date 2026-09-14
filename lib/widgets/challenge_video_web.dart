import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

final _registered = <String>{};

Widget buildChallengeVideo(String webmUrl, String mp4Url) {
  final viewType = 'challenge-video-${webmUrl.hashCode}-${mp4Url.hashCode}';
  if (_registered.add(viewType)) {
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final video = web.HTMLVideoElement()
        ..autoplay = true
        ..loop = true
        ..muted = true
        ..controls = false
        ..setAttribute('playsinline', 'true')
        ..setAttribute('muted', 'true');
      video.style
        ..border = 'none'
        ..width = '100%'
        ..height = '100%'
        ..objectFit = 'cover'
        ..background = '#e8e0d8';
      video.append(
        web.HTMLSourceElement()
          ..src = mp4Url
          ..type = 'video/mp4',
      );
      video.append(
        web.HTMLSourceElement()
          ..src = webmUrl
          ..type = 'video/webm',
      );
      return video;
    });
  }
  return Stack(
    fit: StackFit.expand,
    children: [
      const ColoredBox(color: Color(0xFFE8E0D8)),
      HtmlElementView(viewType: viewType),
    ],
  );
}
