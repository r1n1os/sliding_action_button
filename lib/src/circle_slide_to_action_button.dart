import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/base_slide_to_action_button.dart';

class CircleSlideToActionButton extends StatefulWidget {
  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  ///This will be the background color of the parent box
  final Color? slidingBoxBackgroundColor;

  ///This field will be the width and height of the circle(draggable) button
  final double circleSlidingButtonSize;

  ///This field will be the double value for the BorderRadius.circular() attribute
  final double circleSlidingButtonRadiusValue;

  ///This field will determined the space between the sliding button and the parent widget on the right end.
  final double rightEdgeSpacing;

  ///This field is responsible for the text appear in the button before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the button after the sliding action
  final String finalSlidingActionLabel;

  ///This will be the icon appear on the sliding button
  final Widget circleSlidingButtonIcon;

  ///This will be the text styling of the label appear before the sliding action
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action. In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This will be the background color of the circle sliding button
  final Color? circleSlidingButtonBackgroundColor;

  ///This will be used to align the circle button
  final EdgeInsets? circleButtonMargin;

  ///This Function is used to indicate the end of the sliding action with success
  final Function() onSlideActionCompleted;

  ///This Function is used to indicate the end of the sliding action with cancel
  final Function() onSlideActionCanceled;

  const CircleSlideToActionButton({
    super.key,
    required this.initialSlidingActionLabel,
    required this.finalSlidingActionLabel,
    required this.circleSlidingButtonIcon,
    required this.onSlideActionCompleted,
    required this.onSlideActionCanceled,
    this.height = 56,
    this.width = 240,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.slidingBoxBackgroundColor,
    this.circleSlidingButtonSize = 50,
    this.circleSlidingButtonRadiusValue = 45,
    this.rightEdgeSpacing = 10,
    this.circleSlidingButtonBackgroundColor,
    this.circleButtonMargin =
        const EdgeInsets.only(left: 5,),
  });

  @override
  State<CircleSlideToActionButton> createState() =>
      _CircleSlideToActionButtonState();
}

class _CircleSlideToActionButtonState extends State<CircleSlideToActionButton> {

  @override
  Widget build(BuildContext context) {
    return BaseSlideToActionButton(
      height: widget.height,
      width: widget.width,
      slideButtonWidget: _buildCircleButton(),
      slidingButtonWidth: widget.circleSlidingButtonSize,
      rightEdgeSpacing: widget.rightEdgeSpacing,
      initialSlidingActionLabel: widget.initialSlidingActionLabel,
      finalSlidingActionLabel: widget.finalSlidingActionLabel,
      initialSlidingActionLabelTextStyle: widget.initialSlidingActionLabelTextStyle,
      finalSlidingActionLabelTextStyle: widget.finalSlidingActionLabelTextStyle,
      onSlideActionCompleted: widget.onSlideActionCompleted,
      onSlideActionCanceled: widget.onSlideActionCanceled,
      slidingBoxBackgroundColor: widget.slidingBoxBackgroundColor,
    );
  }

  Widget _buildCircleButton(){
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: widget.circleSlidingButtonSize,
        width: widget.circleSlidingButtonSize,
        margin: widget.circleButtonMargin,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(widget.circleSlidingButtonRadiusValue)),
        child: widget.circleSlidingButtonIcon,
      ),
    );
  }
}
