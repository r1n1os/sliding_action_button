import 'package:flutter/material.dart';

/// Defines the visual decoration of the [SlideToActionButton] track.
///
/// Use [SlideTrackDecoration.fromColor] for a solid color or
/// [SlideTrackDecoration.fromGradient] for a gradient — never both.
/// The named constructors enforce this at compile time.
///
/// ```dart
/// // Solid color
/// enabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.orange),
///
/// // Gradient
/// enabledTrackDecoration: SlideTrackDecoration.fromGradient(
///   LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
/// ),
/// ```
class SlideTrackDecoration {
  /// The solid color of the track. Null when a [gradient] is used.
  final Color? color;

  /// The gradient of the track. Null when a solid [color] is used.
  final Gradient? gradient;

  /// Creates a solid color track decoration.
  const SlideTrackDecoration.fromColor(Color this.color) : gradient = null;

  /// Creates a gradient track decoration.
  const SlideTrackDecoration.fromGradient(Gradient this.gradient)
      : color = null;

  // Converts to [BoxDecoration] for use inside [AnimatedContainer].
  // borderRadius is passed in from the widget since SlideTrackDecoration
  // has no knowledge of the button's dimensions.
  BoxDecoration toBoxDecoration({required double borderRadius}) {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}
