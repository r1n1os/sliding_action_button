import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/base_slide_to_action_button.dart';

class SquareSlideToActionButton extends StatefulWidget {
  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  ///This field will be the double value for the BorderRadius.circular() attribute to configure the cornenrs
  ///of parent box
  final double parentBoxRadiusValue;

  ///This will be the background color of the parent box
  final Color? slidingBoxBackgroundColor;

  ///This field will be the width and height of the square(draggable) button
  final double squareSlidingButtonSize;

  ///This field will be the double value for the BorderRadius.circular() attribute
  final double squareSlidingButtonRadiusValue;

  ///This will be used to align the left side of square button.
  ///We cannot do what we do with the other sides as the left attribute of Positioned widget is used to handle the
  ///dragging of the button
  final double leftEdgeSpacing;

  ///This field will determined the space between the sliding button and the parent widget on the right end.
  ///In case you have Padding left
  final double rightEdgeSpacing;

  ///This field will determined the space between the sliding button and the parent widget on the top.
  final double topEdgeSpacing;

  ///This field will determined the space between the sliding button and the parent widget on the bottom.
  final double bottomEdgeSpacing;

  ///This field is responsible for the text appear in the button before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the button after the sliding action
  final String finalSlidingActionLabel;

  ///This will be the icon appear on the sliding button
  final Widget squareSlidingButtonIcon;

  ///This will be the text styling of the label appear before the sliding action
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action. In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This will be the background color of the circle sliding button
  final Color? squareSlidingButtonBackgroundColor;

  ///This Function is used to indicate the end of the sliding action with success
  final Function() onSlideActionCompleted;

  ///This Function is used to indicate the end of the sliding action with cancel
  final Function() onSlideActionCanceled;

  const SquareSlideToActionButton({
    super.key,
    required this.initialSlidingActionLabel,
    required this.finalSlidingActionLabel,
    required this.squareSlidingButtonIcon,
    required this.onSlideActionCompleted,
    required this.onSlideActionCanceled,
    required this.parentBoxRadiusValue,
    this.height = 56,
    this.width = 240,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.slidingBoxBackgroundColor,
    this.squareSlidingButtonSize = 50,
    this.squareSlidingButtonRadiusValue = 10,
    this.rightEdgeSpacing = 10,
    this.topEdgeSpacing = 0,
    this.bottomEdgeSpacing = 0,
    this.squareSlidingButtonBackgroundColor,
    this.leftEdgeSpacing = 0,
  });

  @override
  State<SquareSlideToActionButton> createState() =>
      _CircleSlideToActionButtonState();
}

class _CircleSlideToActionButtonState extends State<SquareSlideToActionButton> {
  @override
  Widget build(BuildContext context) {
    return BaseSlideToActionButton(
      height: widget.height,
      width: widget.width,
      parentBoxRadiusValue: widget.parentBoxRadiusValue,
      slideButtonWidget: _buildCircleButton(),
      slidingButtonWidth: widget.squareSlidingButtonSize,
      rightEdgeSpacing: widget.rightEdgeSpacing,
      topEdgeSpacing: widget.topEdgeSpacing,
      bottomEdgeSpacing: widget.bottomEdgeSpacing,
      initialSlidingActionLabel: widget.initialSlidingActionLabel,
      finalSlidingActionLabel: widget.finalSlidingActionLabel,
      initialSlidingActionLabelTextStyle:
          widget.initialSlidingActionLabelTextStyle,
      finalSlidingActionLabelTextStyle: widget.finalSlidingActionLabelTextStyle,
      onSlideActionCompleted: widget.onSlideActionCompleted,
      onSlideActionCanceled: widget.onSlideActionCanceled,
      slidingBoxBackgroundColor: widget.slidingBoxBackgroundColor,
    );
  }

  Widget _buildCircleButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.squareSlidingButtonSize,
          width: widget.squareSlidingButtonSize,
          margin: EdgeInsets.only(left: widget.leftEdgeSpacing),
          decoration: BoxDecoration(
              color: widget.squareSlidingButtonBackgroundColor,
              borderRadius:
                  BorderRadius.circular(widget.squareSlidingButtonRadiusValue)),
          child: widget.squareSlidingButtonIcon,
        ),
      ],
    );
  }
}
