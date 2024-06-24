import 'package:flutter/material.dart';

class BaseSlideToActionButton extends StatefulWidget {
  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  ///This field will be the double value for the BorderRadius.circular() attribute to configure the cornenrs
  ///of parent box
  final double parentBoxRadiusValue;

  ///This will be the background color of the parent box
  final Color? slidingBoxBackgroundColor;

  ///This field is passing the button widget which user can slide
  final Widget slideButtonWidget;

  ///This field will be the width and height of the sliding button
  final double slidingButtonWidth;

  ///This field will determined the space between the sliding button and the parent widget on the right end.
  final double rightEdgeSpacing;

  ///This field is responsible for the text appear in the button before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the button after the swipe action
  final String finalSlidingActionLabel;

  ///This will be the text styling of the label appear before the sliding action
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action. In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This Function is used to indicate the end of the sliding action with success
  final Function() onSlideActionCompleted;

  ///This Function is used to indicate the end of the sliding action with cancel
  final Function() onSlideActionCanceled;

  const BaseSlideToActionButton({
    super.key,
    required this.slideButtonWidget,
    required this.initialSlidingActionLabel,
    required this.finalSlidingActionLabel,
    required this.onSlideActionCompleted,
    required this.onSlideActionCanceled,
    required this.slidingButtonWidth,
    required this.parentBoxRadiusValue,
    this.height = 56,
    this.width = 240,
    this.rightEdgeSpacing = 10,
    this.slidingBoxBackgroundColor,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
  });

  @override
  State<BaseSlideToActionButton> createState() =>
      _BaseSlideToActionButtonState();
}

class _BaseSlideToActionButtonState extends State<BaseSlideToActionButton>
    with SingleTickerProviderStateMixin {
  double _sliderPosition = 0;

  bool get hasSliderReachTheMiddle =>
      _sliderPosition >= (widget.width - widget.slidingButtonWidth) / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(widget.parentBoxRadiusValue)),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              hasSliderReachTheMiddle
                  ? widget.finalSlidingActionLabel
                  : widget.initialSlidingActionLabel,
              style: widget.initialSlidingActionLabelTextStyle,
            ),
          ),
        ),
        Positioned(
          left: _sliderPosition,
          child: GestureDetector(
              onHorizontalDragUpdate: (dragDetails) {
                _onHorizontalDragUpdate(
                  dragDetails,
                );
              },
              onHorizontalDragEnd: (dragDetails) {
                _onHorizontalDragEnd(dragDetails);
              },
              child: widget.slideButtonWidget),
        )
      ],
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails dragDetails) {
    setState(() {
      _sliderPosition += dragDetails.delta.dx;
      if (_sliderPosition > widget.width - widget.slidingButtonWidth) {
        _sliderPosition = widget.width - widget.slidingButtonWidth - widget.rightEdgeSpacing;
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails dragDetails) {
    if (_sliderPosition >= (widget.width - widget.slidingButtonWidth) / 2) {
      setState(() {
        _sliderPosition = widget.width - widget.slidingButtonWidth - widget.rightEdgeSpacing;
      });
      widget.onSlideActionCompleted();
    } else {
      setState(() {
        _sliderPosition = 0.0;
      });
      widget.onSlideActionCanceled();
    }
  }
}
