import 'dart:math';
import 'package:flutter/material.dart';

class BaseSlideToActionButton extends StatefulWidget {
  final Widget slideButtonWidget;

  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  final double slidingButtonWidth;

  ///This field is responsible for the text appear in the button before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the button after the swipe action
  final String finalSlidingActionLabel;

  ///This will be the background color of the parent box
  final Color? slidingBoxBackgroundColor;

  ///This will be the text styling of the label appear before the sliding action
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action. In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This will be used to align the text of the button
  final EdgeInsets? slidingActionLabelPadding;

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
    this.height = 56,
    this.width = 240,
    this.slidingBoxBackgroundColor,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.slidingActionLabelPadding =
        const EdgeInsets.only(right: 5.0),
  });

  @override
  State<BaseSlideToActionButton> createState() =>
      _BaseSlideToActionButtonState();
}

class _BaseSlideToActionButtonState extends State<BaseSlideToActionButton>
    with SingleTickerProviderStateMixin {
  double _sliderPosition = 0.0;

  bool get hasSliderReachTheMiddle =>
      _sliderPosition >= (widget.width - widget.slidingButtonWidth) / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
          //padding: widget.slidingActionLabelPadding,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(15)),
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
        _sliderPosition = widget.width - widget.slidingButtonWidth;
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails dragDetails) {
    if (_sliderPosition >= (widget.width - widget.slidingButtonWidth) / 2) {
      setState(() {
        _sliderPosition = widget.width - widget.slidingButtonWidth;
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
