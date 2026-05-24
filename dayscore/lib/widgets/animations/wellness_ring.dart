import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/text_styles.dart';

class WellnessRing extends StatelessWidget {
  final double score; // 0.0 to 100.0
  final double size;
  final double strokeWidth;
  final Widget? centerWidget;

  const WellnessRing({
    super.key,
    required this.score,
    this.size = 180.0,
    this.strokeWidth = 14.0,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final cleanScore = score.clamp(0.0, 100.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: cleanScore / 100.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _RingPainter(
                  progress: value,
                  strokeWidth: strokeWidth,
                ),
              ),
              centerWidget ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (value * 100).toInt().toString(),
                        style: TextStyles.h1.copyWith(
                          fontSize: size * 0.24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'DayScore',
                        style: TextStyles.bodySmall.copyWith(
                          color: AppColors.cyan,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Draw Background Track Ring
    final trackPaint = Paint()
      ..color = AppColors.surfaceLight.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // 2. Draw Progress Ring with Gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final progressPaint = Paint()
        ..shader = const SweepGradient(
          colors: [
            AppColors.purple,
            AppColors.cyan,
            AppColors.lime,
            AppColors.purple, // wrap-around match
          ],
          stops: [0.0, 0.4, 0.8, 1.0],
          transform: GradientRotation(-pi / 2),
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;

      // Draw arc starting from the top (-pi/2)
      canvas.drawArc(
        rect,
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.strokeWidth != strokeWidth;
  }
}
