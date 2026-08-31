import 'package:michael_david/utils/url_fragment_io.dart'
    if (dart.library.html) 'package:michael_david/utils/url_fragment_web.dart'
    as platform;

void replaceUrlFragment(String fragment) {
  platform.replaceUrlFragment(fragment);
}
