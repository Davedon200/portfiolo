import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Faint architectural / geometric line overlay for the portfolio sidebar.
class SidebarPatternPainter extends CustomPainter {
  const SidebarPatternPainter({this.color = const Color(0x33C4A574)});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final w = size.width;
    final h = size.height;

    // Vertical / horizontal grid accents
    for (var i = 1; i < 6; i++) {
      final x = w * (i / 6);
      canvas.drawLine(Offset(x, 0), Offset(x, h), paint);
    }
    for (var i = 1; i < 10; i++) {
      final y = h * (i / 10);
      canvas.drawLine(Offset(0, y), Offset(w, y), paint);
    }

    // Diagonal construction lines
    canvas.drawLine(Offset(0, h * 0.15), Offset(w * 0.7, h), paint);
    canvas.drawLine(Offset(w * 0.2, 0), Offset(w, h * 0.55), paint);
    canvas.drawLine(Offset(0, h * 0.7), Offset(w, h * 0.35), paint);

    // Circles / arcs (blueprint feel)
    canvas.drawCircle(Offset(w * 0.5, h * 0.22), w * 0.42, paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.22), w * 0.28, paint);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w * 0.15, h * 0.75), radius: w * 0.55),
      -math.pi / 2,
      math.pi,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w * 0.85, h * 0.55), radius: w * 0.4),
      0,
      math.pi * 1.2,
      false,
      paint,
    );

    // Small rectangles
    canvas.drawRect(
      Rect.fromLTWH(w * 0.08, h * 0.48, w * 0.22, h * 0.08),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.65, h * 0.82, w * 0.25, h * 0.1),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant SidebarPatternPainter oldDelegate) =>
      oldDelegate.color != color;
}
