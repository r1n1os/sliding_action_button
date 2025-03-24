import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/basic_slide_action_widgets/base_slide_to_action_button.dart';
import 'package:sliding_action_button/src/slide_to_action_with_loader/base_slide_to_action_with_loader_button.dart';
import 'package:sliding_action_button/src/utils/enums/slide_action_button_type.dart';
import 'package:sliding_action_button/src/utils/slide_to_action_controller.dart';

class CircleSlideToActionButton extends StatefulWidget {
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
  ///You cannot have both parentBoxBackgroundColor and parentBoxGradientBackgroundColor
  final Gradient? parentBoxGradientBackgroundColor;

  ///This will be the background color of the parent box in case you want to use gradient when isEnable is False.
  ///You cannot have both parentBoxDisableBackgroundColor and parentBoxDisableGradientBackgroundColor
  final Gradient? parentBoxDisableGradientBackgroundColor;

  ///This field will be the width and height of the circle(draggable) button
  final double circleSlidingButtonSize;

  ///This field will be the double value for the BorderRadius.circular() attribute
  final double circleSlidingButtonRadiusValue;

  ///This will be used to align the left side of circle button.
  ///We cannot do what we do with the other sides as the left attribute of Positioned widget is used to handle the
  ///dragging of the button
  final double leftEdgeSpacing;

  ///This field will determined the space between the circle sliding button widget and the parent widget on the right end.
  ///In case you have Padding left
  final double rightEdgeSpacing;

  ///This field is responsible for the text appear in the parent box before the sliding action
  final String initialSlidingActionLabel;

  ///This field is responsible for the text appear in the parent box after the swipe action
  final String finalSlidingActionLabel;

  ///This will be the text styling of the label appear before the sliding action
  final TextStyle? initialSlidingActionLabelTextStyle;

  ///This will be the text styling of the label appear after the sliding action. In case this field is null the same style as the
  ///#initialSlidingActionLabelTextStyle will be used
  final TextStyle? finalSlidingActionLabelTextStyle;

  ///This will be the icon appear on the sliding button
  final Widget circleSlidingButtonIcon;

  ///This will be the background color of the circle sliding button when isEnable = True
  final Color? circleSlidingButtonBackgroundColor;

  ///This will be the background color of the circle sliding button when isEnable = False
  final Color? circleSlidingButtonDisableBackgroundColor;

  ///This field is used to enable or disable the circle sliding button(The slide action)
  ///By default is True
  final bool isEnable;

  ///This field indicating the basic behavior of the slide action (Type)
  ///By default is basicSlideActionButton
  final SlideActionButtonType slideActionButtonType;

  ///This field is styling the color of the loader
  ///ByD default is white
  final Color loaderColor;

  ///This field is configure the time needed for container to change to loader
  ///By default is 700 milliseconds
  final Duration animationDuration;

  ///This field is used to control the circle sliding action state (Loading, resetting etc)
  ///And controlling the slider position
  final SlideToActionController? slideToActionController;

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
    required this.parentBoxRadiusValue,
    this.slideToActionController,
    this.height = 56,
    this.width = 240,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.parentBoxBackgroundColor,
    this.parentBoxDisableBackgroundColor,
    this.parentBoxGradientBackgroundColor,
    this.parentBoxDisableGradientBackgroundColor,
    this.circleSlidingButtonSize = 50,
    this.circleSlidingButtonRadiusValue = 45,
    this.leftEdgeSpacing = 0,
    this.rightEdgeSpacing = 0,
    this.circleSlidingButtonBackgroundColor = Colors.green,
    this.circleSlidingButtonDisableBackgroundColor = Colors.black12,
    this.isEnable = true,
    this.slideActionButtonType = SlideActionButtonType.basicSlideActionButton,
    this.loaderColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 700),
  });

  @override
  State<CircleSlideToActionButton> createState() =>
      _CircleSlideToActionButtonState();
}

class _CircleSlideToActionButtonState extends State<CircleSlideToActionButton> {
  @override
  Widget build(BuildContext context) {
    return _buildBaseSlideActionWidget();
  }

  Widget _buildBaseSlideActionWidget() {
    switch (widget.slideActionButtonType) {
      case SlideActionButtonType.basicSlideActionButton:
        return BaseSlideToActionButton(
          slideToActionController:
              widget.slideToActionController ?? SlideToActionController(),
          height: widget.height,
          width: widget.width,
          parentBoxRadiusValue: widget.parentBoxRadiusValue,
          parentBoxBackgroundColor: widget.parentBoxBackgroundColor,
          parentBoxDisableBackgroundColor:
              widget.parentBoxDisableBackgroundColor,
          parentBoxGradientBackgroundColor:
              widget.parentBoxGradientBackgroundColor,
          parentBoxDisableGradientBackgroundColor:
              widget.parentBoxDisableGradientBackgroundColor,
          leftEdgeSpacing: widget.leftEdgeSpacing,
          rightEdgeSpacing: widget.rightEdgeSpacing,
          initialSlidingActionLabel: widget.initialSlidingActionLabel,
          finalSlidingActionLabel: widget.finalSlidingActionLabel,
          initialSlidingActionLabelTextStyle:
              widget.initialSlidingActionLabelTextStyle,
          finalSlidingActionLabelTextStyle:
              widget.finalSlidingActionLabelTextStyle,
          isEnable: widget.isEnable,
          onSlideActionCompleted: widget.onSlideActionCompleted,
          onSlideActionCanceled: widget.onSlideActionCanceled,
          slidingButtonSize: widget.circleSlidingButtonSize,
          slideButtonWidget: _buildCircleButton(),
        );
      case SlideActionButtonType.slideActionWithLoaderButton:
        return BaseSlideToActionWithLoaderButton(
          slideToActionController:
              widget.slideToActionController ?? SlideToActionController(),
          height: widget.height,
          width: widget.width,
          parentBoxRadiusValue: widget.parentBoxRadiusValue,
          parentBoxBackgroundColor: widget.parentBoxBackgroundColor,
          parentBoxDisableBackgroundColor:
              widget.parentBoxDisableBackgroundColor,
          parentBoxGradientBackgroundColor:
              widget.parentBoxGradientBackgroundColor,
          parentBoxDisableGradientBackgroundColor:
              widget.parentBoxDisableGradientBackgroundColor,
          leftEdgeSpacing: widget.leftEdgeSpacing,
          rightEdgeSpacing: widget.rightEdgeSpacing,
          initialSlidingActionLabel: widget.initialSlidingActionLabel,
          finalSlidingActionLabel: widget.finalSlidingActionLabel,
          initialSlidingActionLabelTextStyle:
              widget.initialSlidingActionLabelTextStyle,
          finalSlidingActionLabelTextStyle:
              widget.finalSlidingActionLabelTextStyle,
          isEnable: widget.isEnable,
          loaderColor: widget.loaderColor,
          animationDuration: widget.animationDuration,
          onSlideActionCompleted: widget.onSlideActionCompleted,
          onSlideActionCanceled: widget.onSlideActionCanceled,
          slidingButtonSize: widget.circleSlidingButtonSize,
          slideButtonWidget: _buildCircleButton(),
        );
    }
  }

  Widget _buildCircleButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.circleSlidingButtonSize,
          width: widget.circleSlidingButtonSize,
          decoration: BoxDecoration(
              color: widget.isEnable
                  ? widget.circleSlidingButtonBackgroundColor
                  : widget.circleSlidingButtonDisableBackgroundColor,
              borderRadius:
                  BorderRadius.circular(widget.circleSlidingButtonRadiusValue)),
          child: widget.circleSlidingButtonIcon,
        ),
      ],
    );
  }
}
