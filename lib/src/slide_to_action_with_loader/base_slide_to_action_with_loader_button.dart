import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/utils/loader_button_enum_states.dart';
import 'package:sliding_action_button/src/utils/slide_to_action_controller.dart';

class BaseSlideToActionWithLoaderButton extends StatefulWidget {
  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  ///This field will be the double value for the BorderRadius.circular() attribute to configure the corners
  ///of parent box
  final double parentBoxRadiusValue;

  ///This will be the background color of the parent box when isEnable is True
  final Color? parentBoxBackgroundColor;

  ///This will be the background color of the parent box when isEnable is False
  final Color? parentBoxDisableBackgroundColor;

  ///This will be the background color of the parent box in case you want to use gradient when isEnable is True.
  ///You cannot have both slidingBoxBackgroundColor and slidingBoxGradientBackgroundColor
  final Gradient? parentBoxGradientBackgroundColor;

  ///This will be the background color of the parent box in case you want to use gradient when isEnable is False.
  ///You cannot have both slidingBoxBackgroundColor and slidingBoxGradientBackgroundColor
  final Gradient? parentBoxDisableGradientBackgroundColor;

  ///This field is passing the button widget which user can slide
  final Widget slideButtonWidget;

  ///This field will be the width and height of the sliding button
  final double slidingButtonSize;

  ///This will be used to align the left side of circle button.
  ///We cannot do what we do with the other sides as the left attribute of Positioned widget is used to handle the
  ///dragging of the button
  final double leftEdgeSpacing;

  ///This field will determined the space between the sliding button widget and the parent widget on the right end.
  final double rightEdgeSpacing;

  ///This field will determined the space between the sliding button and the parent widget on the top.
  final double topEdgeSpacing;

  ///This field will determined the space between the sliding button and the parent widget on the bottom.
  final double bottomEdgeSpacing;

  ///This field is responsible for the text appear in the parent box before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the parent box after the swipe action
  final String finalSlidingActionLabel;

  ///This will be the text styling of the label appear before the sliding action (initialSlidingActionLabel)
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action (finalSlidingActionLabel). In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This field is used to enable or disable the sliding button(The slide action)
  ///By default is True
  final bool isEnable;

  ///This field is styling the color of the loader
  ///By default is white
  final Color loaderColor;

  ///This field is configure the time needed for container to change to loader
  ///By default is 700 milliseconds
  final Duration animationDuration;

  ///This field is used to handle the state of the button. i.e loading, initial etc
  ///By default is initial
  final SlideToActionController slideToActionController;

  ///This Function is used to indicate the end of the sliding action with success
  final Function() onSlideActionCompleted;

  ///This Function is used to indicate the end of the sliding action with cancel
  final Function() onSlideActionCanceled;

  const BaseSlideToActionWithLoaderButton({
    super.key,
    required this.slideButtonWidget,
    required this.initialSlidingActionLabel,
    required this.finalSlidingActionLabel,
    required this.onSlideActionCompleted,
    required this.onSlideActionCanceled,
    required this.slidingButtonSize,
    required this.parentBoxRadiusValue,
    required this.slideToActionController,
    this.height = 56,
    this.width = 240,
    this.leftEdgeSpacing = 0,
    this.rightEdgeSpacing = 0,
    this.topEdgeSpacing = 0,
    this.bottomEdgeSpacing = 0,
    this.parentBoxBackgroundColor,
    this.parentBoxDisableBackgroundColor,
    this.parentBoxGradientBackgroundColor,
    this.parentBoxDisableGradientBackgroundColor,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.isEnable = true,
    this.loaderColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 700),
  })  : assert(
            (parentBoxBackgroundColor != null &&
                    parentBoxGradientBackgroundColor == null) ||
                (parentBoxBackgroundColor == null &&
                    parentBoxGradientBackgroundColor != null),
            "Please make sure you have set either slidingBoxBackgroundColor or slidingBoxGradientBackgroundColor. You cannot set both at the same time"),
        assert(
            (parentBoxBackgroundColor != null &&
                    parentBoxDisableBackgroundColor != null) ||
                (parentBoxGradientBackgroundColor != null &&
                    parentBoxDisableGradientBackgroundColor != null),
            "Please make sure you have set either slidingBoxBackgroundColor or slidingBoxGradientBackgroundColor. You cannot set both at the same time"),
        assert(width != double.infinity,
            "Please replace double.infinity with MediaQuery.of(context).size.width");

  @override
  State<BaseSlideToActionWithLoaderButton> createState() =>
      _BaseSlideToActionWithLoaderButtonState();
}

class _BaseSlideToActionWithLoaderButtonState
    extends State<BaseSlideToActionWithLoaderButton>
    with SingleTickerProviderStateMixin {

  ///Detecting when the user slide the button in the half of the parent box
  bool get hasSliderReachTheMiddle =>
      _controller.sliderPosition >=
      (widget.width - widget.slidingButtonSize) / 2;

  SlideToActionController get _controller => widget.slideToActionController;

  bool get _shouldShowLoadingState =>
      _controller.loaderButtonEnumStates == LoaderButtonEnumStates.loading;

  ///This variable is used to control when to show the text on the sliding action button.
  bool _showText = true;

  @override
  void initState() {
    _controller.reset(widget.leftEdgeSpacing);
    _controller.addListener(_onControllerChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (_controller.loaderButtonEnumStates == LoaderButtonEnumStates.loading) {
      setState(() {
        _showText = false;
      });
    } else if (_controller.loaderButtonEnumStates ==
        LoaderButtonEnumStates.reset && _showText == false) {
      Future.delayed(
          widget.animationDuration + const Duration(milliseconds: 300), () {
        setState(() {
          _showText = true;
        });
      });
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant BaseSlideToActionWithLoaderButton oldWidget) {
    if (oldWidget.key != widget.key) {
      //_controller.reset(widget.leftEdgeSpacing);
    }    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          height: widget.height,
          ///To make the loader perfect circle when loader is activated
          ///I'm setting the width to be the same as the height
          width: _shouldShowLoadingState ? widget.height : widget.width,
          duration: widget.animationDuration,
          decoration: BoxDecoration(
              gradient: widget.isEnable
                  ? widget.parentBoxGradientBackgroundColor
                  : widget.parentBoxDisableGradientBackgroundColor,
              color: widget.isEnable
                  ? widget.parentBoxBackgroundColor
                  : widget.parentBoxDisableBackgroundColor,
              borderRadius: BorderRadius.circular(widget.parentBoxRadiusValue)),
          child: Align(
            alignment: Alignment.center,
            child: _shouldShowLoadingState
                ? CircularProgressIndicator(
                    color: widget.loaderColor,
                  )
                : AnimatedOpacity(
                    opacity: _showText ? 1.0 : 0.0,
                    duration: widget.animationDuration,
                    child: Text(
                      hasSliderReachTheMiddle
                          ? widget.finalSlidingActionLabel
                          : widget.initialSlidingActionLabel,
                      style: widget.initialSlidingActionLabelTextStyle,
                    ),
                  ),
          ),
        ),
        if (!_shouldShowLoadingState)
          Positioned(
            left: _controller.sliderPosition,
            top: 0,
            bottom: 0,
            child: GestureDetector(
                onHorizontalDragUpdate: widget.isEnable
                    ? (dragDetails) {
                        _onHorizontalDragUpdate(
                          dragDetails,
                        );
                      }
                    : null,
                onHorizontalDragEnd: widget.isEnable
                    ? (dragDetails) {
                        _onHorizontalDragEnd(dragDetails);
                      }
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.slideButtonWidget,
                  ],
                )),
          )
      ],
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails dragDetails) {
    if (!mounted) return;
    if (_controller.sliderPosition > widget.width - widget.slidingButtonSize) {
      setState(() {
        _controller.updateSliderPosition(
            widget.width - widget.slidingButtonSize - widget.rightEdgeSpacing);
      });
      if (!_controller.isSlideActionCompletedCallbackCalled) {
        widget.onSlideActionCompleted();
      }
    }/* else if (_controller.sliderPosition <
        widget.width + widget.leftEdgeSpacing) {
      setState(() {
        _controller.reset(widget.leftEdgeSpacing);
      });
    }*/ else {
      setState(() {
        _controller.updateSliderPosition(
            _controller.sliderPosition + dragDetails.delta.dx);
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails dragDetails) {
    if (_controller.sliderPosition >=
        (widget.width - widget.slidingButtonSize) / 2) {
      setState(() {
        _controller.updateSliderPosition(
            widget.width - widget.slidingButtonSize - widget.rightEdgeSpacing);
      });
      if (!_controller.isSlideActionCompletedCallbackCalled) {
        widget.onSlideActionCompleted();
      }
    } else {
      setState(() {
        _controller.reset(widget.leftEdgeSpacing);
      });
      widget.onSlideActionCanceled();
    }
  }
}