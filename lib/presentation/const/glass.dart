import 'dart:math' as math;
import 'dart:ui';

import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AppGlass {
  const AppGlass._();

  static LiquidGlassSettings settings({
    required Color glassColor,
    double refraction = 80,
    double depth = 20,
    double dispersion = 50,
    double frost = 24,
    double lightIntensity = 80,
    double lightAngle = -45 * math.pi / 180,
    double shadowElevation = 1.0,
    double whitenStrength = 0.0,
  }) {
    return LiquidGlassSettings(
      glassColor: glassColor,
      refractiveIndex: 1 + (refraction / 100) * 0.2,
      thickness: depth,
      chromaticAberration: 4 * (dispersion / 100),
      blur: frost,
      lightIntensity: lightIntensity / 100,
      lightAngle: lightAngle,
      ambientStrength: 0.1,
      saturation: 1.5,
      shadowElevation: shadowElevation,
      whitenStrength: whitenStrength,
      fresnelStrength: 0,
      glowIntensity: 0,
    );
  }

  /// Flat frosted panel — blur and tint only.
  ///
  /// Zeroing depth removes the glass bevel, whose lit edge traces the whole
  /// outline as a light band on a surface this large. Refraction and dispersion
  /// go with it so the edge stops bending the content behind it, and no light
  /// means no specular highlight running along the rim.
  static LiquidGlassSettings panel({
    required Color glassColor,
    double frost = 20,
    double whitenStrength = 0.3,
    double shadowElevation = 1.0,
  }) {
    return settings(
      glassColor: glassColor,
      refraction: 0,
      depth: 0,
      dispersion: 0,
      frost: frost,
      lightIntensity: 0,
      whitenStrength: whitenStrength,
      shadowElevation: shadowElevation,
    );
  }

  static GlassThemeData themeData() {
    GlassThemeVariant withoutRim(GlassThemeVariant variant) => variant.copyWith(
      settings: (variant.settings ?? const GlassThemeSettings()).copyWith(
        fresnelStrength: 0,
      ),
    );

    return GlassThemeData(
      light: withoutRim(GlassThemeVariant.light),
      dark: withoutRim(GlassThemeVariant.dark),
    );
  }
}
