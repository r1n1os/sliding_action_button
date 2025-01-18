import 'package:flutter/material.dart';

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
  ///This variable is holding the current sliding position when user is dragging the button
  double _sliderPosition = 0;

  ///This variable is used to indicate that the sliding action is completed
  bool _hasSlidingActionCompleted = false;

  ///Detecting when the user slide the button in the half of the parent box
  bool get hasSliderReachTheMiddle =>
      _sliderPosition >= (widget.width - widget.slidingButtonSize) / 2;

  @override
  void initState() {
    _sliderPosition = widget.leftEdgeSpacing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          height: widget.height,

          ///To make the loader perfect circle when loader is activated
          ///I'm setting the width to be the same as the height
          width: _hasSlidingActionCompleted ? widget.height : widget.width,
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
            child: _hasSlidingActionCompleted
                ? CircularProgressIndicator(
                    color: widget.loaderColor,
                  )
                : Text(
                    hasSliderReachTheMiddle
                        ? widget.finalSlidingActionLabel
                        : widget.initialSlidingActionLabel,
                    style: widget.initialSlidingActionLabelTextStyle,
                  ),
          ),
        ),
        if (!_hasSlidingActionCompleted)
          Positioned(
            left: _sliderPosition,
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
    setState(() {
      _sliderPosition += dragDetails.delta.dx;
      if (_sliderPosition > widget.width - widget.slidingButtonSize) {
        _hasSlidingActionCompleted = true;
        _sliderPosition =
            widget.width - widget.slidingButtonSize - widget.rightEdgeSpacing;
      } else if (_sliderPosition <= widget.leftEdgeSpacing) {
        _sliderPosition = widget.leftEdgeSpacing;
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails dragDetails) {
    if (_sliderPosition >= (widget.width - widget.slidingButtonSize) / 2) {
      setState(() {
        _hasSlidingActionCompleted = true;
        _sliderPosition =
            widget.width - widget.slidingButtonSize - widget.rightEdgeSpacing;
      });
      widget.onSlideActionCompleted();
    } else {
      setState(() {
        _sliderPosition = widget.leftEdgeSpacing;
      });
      widget.onSlideActionCanceled();
    }
  }
}
