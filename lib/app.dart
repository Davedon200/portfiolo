import 'package:flutter/material.dart';
import 'package:michael_david/router/app_router.dart';
import 'package:michael_david/theme/app_colors.dart';

class MichaelDavidApp extends StatelessWidget {
  const MichaelDavidApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primary,
      fontFamily: 'Manrope',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.accent,
      ),
    );

    return MaterialApp.router(
      title: 'Michael David',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: base.copyWith(
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
    );
  }
}
