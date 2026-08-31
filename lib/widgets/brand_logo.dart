import 'package:flutter/material.dart';
import 'package:michael_david/theme/app_colors.dart';

/// Full-color brand mark — no white badge; pink circle is part of the artwork.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 36});

  final double size;

  static const assetPath = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: AppColors.logoPink,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'MD',
            style: TextStyle(
              color: AppColors.primaryDeep,
              fontWeight: FontWeight.w700,
              fontSize: size * 0.32,
            ),
          ),
        ),
      ),
    );
  }
}
