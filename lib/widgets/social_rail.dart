import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:michael_david/config/site_config.dart';
import 'package:michael_david/utils/open_external.dart';

class ContactLink {
  const ContactLink({
    required this.label,
    required this.assetPath,
    required this.url,
    required this.color,
  });

  final String label;
  final String assetPath;
  final String url;
  final Color color;
}

List<ContactLink> contactLinks() => [
      ContactLink(
        label: 'Email',
        assetPath: 'assets/icons/mail.svg',
        url: 'mailto:${SiteConfig.email}',
        color: const Color(0xFFEA4335),
      ),
      ContactLink(
        label: 'WhatsApp',
        assetPath: 'assets/icons/whatsapp.svg',
        url: 'https://wa.me/${SiteConfig.whatsapp}',
        color: const Color(0xFF25D366),
      ),
      ContactLink(
        label: 'Call',
        assetPath: 'assets/icons/phone.svg',
        url: 'tel:${SiteConfig.phone}',
        color: const Color(0xFF34B7F1),
      ),
      ContactLink(
        label: 'LinkedIn',
        assetPath: 'assets/icons/linkedin.svg',
        url: SiteConfig.linkedin,
        color: const Color(0xFF0A66C2),
      ),
    ];

class SocialRail extends StatelessWidget {
  const SocialRail({
    super.key,
    this.vertical = true,
    this.circleSize = 36,
    this.maxItems,
  });

  final bool vertical;
  final double circleSize;
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final iconSize = circleSize * 0.48;
    final links = maxItems == null
        ? contactLinks()
        : contactLinks().take(maxItems!).toList();
    final children = links
        .map(
          (c) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: vertical ? 4 : 0,
              horizontal: vertical ? 0 : 4,
            ),
            child: Tooltip(
              message: c.label,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => openExternal(c.url),
                  customBorder: const CircleBorder(),
                  child: Ink(
                    width: circleSize,
                    height: circleSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        c.assetPath,
                        width: iconSize,
                        height: iconSize,
                        colorFilter: ColorFilter.mode(c.color, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();

    return vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: children)
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
