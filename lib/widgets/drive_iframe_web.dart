import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

var _seq = 0;

Widget driveIframe(String url) {
  final viewType = 'drive-iframe-${_seq++}';
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final iframe = web.HTMLIFrameElement()
      ..src = url
      ..allow = 'autoplay; encrypted-media; fullscreen'
      ..allowFullscreen = true;
    iframe.style
      ..border = 'none'
      ..width = '100%'
      ..height = '100%';
    return iframe;
  });
  return HtmlElementView(viewType: viewType);
}
