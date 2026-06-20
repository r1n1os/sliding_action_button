import 'dart:ui';
import 'package:flutter/cupertino.dart';

class SlideTrackDecoration {
  final Color? color;
  final Gradient? gradient;

  const SlideTrackDecoration.color(Color this.color)
  : gradient = null;

  const SlideTrackDecoration.gradient(Gradient this.gradient)
      : color = null;

  BoxDecoration toBoxDecoration({required double borderRadius}) {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}