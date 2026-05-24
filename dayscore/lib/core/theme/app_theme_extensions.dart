import 'dart:ui';
import 'package:flutter/material.dart';

class GlassTheme extends ThemeExtension<GlassTheme> {
  final double blur;
  final double opacity;
  final double borderWidth;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color shadowColor;
  final LinearGradient primaryGradient;
  final LinearGradient secondaryGradient;
  final LinearGradient darkSurfaceGradient;

  const GlassTheme({
    required this.blur,
    required this.opacity,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.shadowColor,
    required this.primaryGradient,
    required this.secondaryGradient,
    required this.darkSurfaceGradient,
  });

  @override
  GlassTheme copyWith({
    double? blur,
    double? opacity,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? borderColor,
    Color? shadowColor,
    LinearGradient? primaryGradient,
    LinearGradient? secondaryGradient,
    LinearGradient? darkSurfaceGradient,
  }) {
    return GlassTheme(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      secondaryGradient: secondaryGradient ?? this.secondaryGradient,
      darkSurfaceGradient: darkSurfaceGradient ?? this.darkSurfaceGradient,
    );
  }

  @override
  GlassTheme lerp(ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this;
    return GlassTheme(
      blur: lerpDouble(blur, other.blur, t) ?? blur,
      opacity: lerpDouble(opacity, other.opacity, t) ?? opacity,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t) ?? primaryGradient,
      secondaryGradient: LinearGradient.lerp(secondaryGradient, other.secondaryGradient, t) ?? secondaryGradient,
      darkSurfaceGradient: LinearGradient.lerp(darkSurfaceGradient, other.darkSurfaceGradient, t) ?? darkSurfaceGradient,
    );
  }
}
