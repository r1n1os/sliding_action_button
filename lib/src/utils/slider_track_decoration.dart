import 'dart:ui';
import 'package:flutter/cupertino.dart';

class SliderTrackDecoration {
  final Color? color;
  final Gradient? gradient;

  const SliderTrackDecoration.color(Color this.color)
  : gradient = null;

  const SliderTrackDecoration.gradient(Gradient this.gradient)
      : color = null;

  BoxDecoration toBoxDecoration({required double borderRadius}) {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}