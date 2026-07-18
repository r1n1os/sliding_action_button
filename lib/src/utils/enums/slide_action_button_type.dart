/// Defines the behaviour of [SlideToActionButton] after the slide completes.
enum SlideActionButtonType {
  /// Fires [SlideToActionButton.onSlideActionCompleted] and shows
  /// [SlideToActionButton.finalSlidingActionLabel]. No loader is shown.
  basicSlideActionButton,
  /// Shows a [CircularProgressIndicator] after completion until
  /// [SlideToActionController.reset] is called.
  /// Requires a [SlideToActionController] passed to
  /// [SlideToActionButton.slideToActionController] to dismiss the loader.
  slideActionWithLoaderButton,
}
