/// Defines the shape of the draggable thumb and determines the default
/// corner radius of both the thumb and the track.
///
/// Replaces the old `CircleSlideToActionButton` and `SquareSlideToActionButton`
/// widgets — now controlled via [SlideToActionButton.slideButtonShape].
enum SlideButtonShape {
  /// Fully rounded thumb and pill-shaped track.
  /// Thumb radius defaults to [SlideToActionButton.thumbSize] / 2.
  /// Track radius defaults to [SlideToActionButton.height] / 2.
  circle,

  /// Rectangular thumb and track with subtle rounding.
  /// Thumb radius defaults to 6dp.
  /// Track radius defaults to 8dp.
  /// Override via [SlideToActionButton.thumbBorderRadius] and
  /// [SlideToActionButton.parentBoxRadiusValue].
  square
}
