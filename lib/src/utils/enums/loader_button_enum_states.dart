/// Internal state machine for [SlideToActionController].
/// Not part of the public API — use [SlideToActionController.loading]
/// and [SlideToActionController.reset] to drive state changes.
enum LoaderButtonEnumStates {
  /// Button is idle and ready for interaction.
  initial,

  /// Button is showing a [CircularProgressIndicator].
  loading,
}
