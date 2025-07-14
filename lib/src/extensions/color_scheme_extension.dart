import 'package:flutter/material.dart';

class CustomColorsExtension extends ThemeExtension<CustomColorsExtension> {
  const CustomColorsExtension({required this.onSurfaceSecondary, required this.onSurfaceBlock});

  final Color? onSurfaceSecondary;
  final Color? onSurfaceBlock;

  @override
  CustomColorsExtension copyWith({Color? secondaryOnSurface, Color? fadeButton}) {
    return CustomColorsExtension(onSurfaceSecondary: secondaryOnSurface ?? this.onSurfaceBlock, onSurfaceBlock: fadeButton ?? this.onSurfaceBlock);
  }

  @override
  CustomColorsExtension lerp(CustomColorsExtension? other, double t) {
    if (other is! CustomColorsExtension) {
      return this;
    }
    return CustomColorsExtension(
      onSurfaceSecondary: Color.lerp(onSurfaceSecondary, other.onSurfaceSecondary, t),
      onSurfaceBlock: Color.lerp(onSurfaceBlock, other.onSurfaceBlock, t),
    );
  }

  // Optional
  @override
  String toString() => 'CustomColors(secondaryOnSurface: $onSurfaceSecondary, fadeButton: $onSurfaceBlock)';
}
