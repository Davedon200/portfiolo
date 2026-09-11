import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

void downloadBytes(Uint8List bytes, String fileName) {
  final parts = [bytes.toJS].toJS;
  final blob = web.Blob(parts, web.BlobPropertyBag(type: 'application/pdf'));
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName;
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
}

void downloadFromUrl(String url, String fileName) {
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..rel = 'noopener';
  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
