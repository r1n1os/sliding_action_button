import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/utils/enums/loader_button_enum_states.dart';

/// Controls the state of [SlideToActionButton] from outside the widget.
///
/// Pass an instance to [SlideToActionButton.slideToActionController] when
/// using [SlideActionButtonType.slideActionWithLoaderButton] to drive the
/// loading and reset transitions after an async operation.
///
/// ```dart
/// final controller = SlideToActionController();
///
/// SlideToActionButton(
///   slideToActionController: controller,
///   slideActionButtonType: SlideActionButtonType.slideActionWithLoaderButton,
///   onSlideActionCompleted: () async {
///     controller.loading();
///     await myApiCall();
///     controller.reset();
///   },
/// )
/// ```
class SlideToActionController extends ChangeNotifier {
  LoaderButtonEnumStates _loaderButtonEnumStates =
      LoaderButtonEnumStates.initial;

  /// Current state of the button.
  /// Read by [SlideToActionButton] on every controller update.
  LoaderButtonEnumStates get state => _loaderButtonEnumStates;

  /// Transitions the button to the loading state, showing a
  /// [CircularProgressIndicator] in place of the label.
  /// Call this immediately inside [SlideToActionButton.onSlideActionCompleted]
  /// before starting the async operation.
  void loading() {
    _loaderButtonEnumStates = LoaderButtonEnumStates.loading;
    notifyListeners();
  }

  /// Resets the button to its initial state, snapping the thumb back
  /// and restoring the initial label.
  /// Call this after the async operation completes or fails.
  void reset() {
    _loaderButtonEnumStates = LoaderButtonEnumStates.initial;
    notifyListeners();
  }
}
