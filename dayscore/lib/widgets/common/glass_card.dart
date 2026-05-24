import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme_extensions.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? blur;
  final Color? borderColor;
  final Color? color;
  final bool hasGlow;
  final Color? glowColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blur,
    this.borderColor,
    this.color,
    this.hasGlow = false,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;
    final radius = BorderRadius.circular(borderRadius ?? 16.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: (glowColor ?? glassTheme.borderColor).withValues(alpha: 0.15),
                  blurRadius: 16.0,
                  spreadRadius: 2.0,
                )
              ]
            : [
                BoxShadow(
                  color: glassTheme.shadowColor,
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blur ?? glassTheme.blur,
            sigmaY: blur ?? glassTheme.blur,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color ?? Colors.white.withValues(alpha: glassTheme.opacity),
              borderRadius: radius,
              border: Border.all(
                color: borderColor ?? glassTheme.borderColor,
                width: glassTheme.borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
