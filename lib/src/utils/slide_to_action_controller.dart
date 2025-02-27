import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/utils/loader_button_enum_states.dart';

class SlideToActionController extends ChangeNotifier {
  ///This variable is holding the current sliding position when user is dragging the button
  double _sliderPosition = 0;

  ///This variable is a flag used to avoid callback getting called more than one
  bool _isSlideActionCompletedCallbackCalled = false;

  ///This variable is holding the state of the button
  LoaderButtonEnumStates _loaderButtonEnumStates =
      LoaderButtonEnumStates.initial;

  /// Getters
  double get sliderPosition => _sliderPosition;

  bool get isSlideActionCompletedCallbackCalled =>
      _isSlideActionCompletedCallbackCalled;

  LoaderButtonEnumStates get loaderButtonEnumStates => _loaderButtonEnumStates;

  ///
  /// IMPORTANT: The method #updateSliderPosition should be used only by the library
  ///
  void updateSliderPosition(double newPosition) {
    _sliderPosition = newPosition;
    notifyListeners();
  }

  void loading() {
    _isSlideActionCompletedCallbackCalled = true;
    _loaderButtonEnumStates = LoaderButtonEnumStates.loading;
    notifyListeners();
  }

  void reset(double leftEdgeSpacing) {
    _isSlideActionCompletedCallbackCalled = false;
    _loaderButtonEnumStates = LoaderButtonEnumStates.initial;
    _sliderPosition = leftEdgeSpacing;
    notifyListeners();
  }
}
