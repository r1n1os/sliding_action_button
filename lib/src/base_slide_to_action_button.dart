import 'dart:math';
import 'package:flutter/material.dart';

class BaseSlideToActionButton extends StatefulWidget {
  final Widget slideButtonWidget;

  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

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
    this.height = 56,
    this.width = 240,
    this.slidingBoxBackgroundColor,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.slidingActionLabelPadding =
        const EdgeInsets.symmetric(horizontal: 50.0),
  });

  @override
  State<BaseSlideToActionButton> createState() =>
      _BaseSlideToActionButtonState();
}

class _BaseSlideToActionButtonState extends State<BaseSlideToActionButton>
    with SingleTickerProviderStateMixin {
  double _startingPositionAtX = 0.0;
  double _sliderPosition = 0.0;
  double _maxPosition = 0.0;
  double _current = 0.0;
  late final AnimationController _animationController;
  late final Animation _sliderAnimation;
  final animationDuration = const Duration(milliseconds: 300);

  bool get slidingReachTheMiddle => _current >= _maxPosition / 2;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    _sliderAnimation =
        CurveTween(curve: Curves.easeInQuad).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        _sliderPosition = _sliderAnimation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final sliderRadius = widget.height / 2;
        final xAxisMaxSliderPosition = widget.width - 2 * sliderRadius;
        final xAxisCurrentSliderPosition = xAxisMaxSliderPosition * _sliderPosition;
        _maxPosition = xAxisMaxSliderPosition;
        _current = xAxisCurrentSliderPosition;
        print("dsf: $slidingReachTheMiddle");
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Stack(
            children: [
              Container(
                height: widget.height,
                width: widget.width,
                padding: widget.slidingActionLabelPadding,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    slidingReachTheMiddle ? widget.finalSlidingActionLabel : widget.initialSlidingActionLabel,
                    style: widget.initialSlidingActionLabelTextStyle,
                  ),
                ),
              ),
              Positioned(
                left: xAxisCurrentSliderPosition,
                child: GestureDetector(
                    onHorizontalDragStart: (dragDetails) {
                      _onHorizontalDragStart(dragDetails,
                          xCurrentPosition: xAxisCurrentSliderPosition);
                    },
                    onHorizontalDragUpdate: (dragDetails) {
                      _onHorizontalDragUpdate(dragDetails,
                          xCurrentPosition: xAxisCurrentSliderPosition,
                          xMaxPosition: xAxisMaxSliderPosition);
                    },
                    onHorizontalDragEnd: (dragDetails) {
                      _onHorizontalDragEnd(dragDetails,
                          xCurrentPosition: xAxisCurrentSliderPosition,
                          xMaxPosition: xAxisMaxSliderPosition);
                    },
                    child: widget.slideButtonWidget),
              )
            ],
          ),
        );
      },
    );
  }

  void _onHorizontalDragStart(DragStartDetails dragDetails,
      {required double xCurrentPosition}) {
    _startingPositionAtX = xCurrentPosition;
    _animationController.stop();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails dragDetails,
      {required double xCurrentPosition, required double xMaxPosition}) {
    final newSliderPositionX =
        _startingPositionAtX + dragDetails.localPosition.dx;
    final newSliderRelativePosition = newSliderPositionX / xMaxPosition;
    setState(() {
      _sliderPosition = max(0, min(1, newSliderRelativePosition));
    });
  }

  void _onHorizontalDragEnd(DragEndDetails dragDetails,
      {required double xCurrentPosition, required double xMaxPosition}) {
    if (xCurrentPosition >= xMaxPosition / 2) {
      const newSliderRelativePosition = 1.0;
      setState(() {
        _sliderPosition = max(0, min(1, newSliderRelativePosition));
      });
      widget.onSlideActionCompleted();
    } else {
      setState(() {
        _sliderPosition = max(0, min(1, 0.0));
      });
      widget.onSlideActionCanceled();
    }
  }
}
