import 'package:flutter/widgets.dart';
import 'package:michael_david/widgets/drive_iframe_stub.dart'
    if (dart.library.html) 'package:michael_david/widgets/drive_iframe_web.dart'
    as impl;

Widget driveIframe(String url) => impl.driveIframe(url);
