import 'package:flutter/material.dart';
import 'package:sliding_action_button/src/basic_slide_action_widgets/base_slide_to_action_button.dart';
import 'package:sliding_action_button/src/slide_to_action_with_loader/base_slide_to_action_with_loader_button.dart';
import 'package:sliding_action_button/src/utils/enums/slide_action_button_type.dart';
import 'package:sliding_action_button/src/utils/slide_to_action_controller.dart';

class SquareSlideToActionButton extends StatefulWidget {
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

  ///This field will be the width and height of the square(draggable) button
  final double squareSlidingButtonSize;

  ///This field will be the double value for the BorderRadius.circular() attribute
  final double squareSlidingButtonRadiusValue;

  ///This will be used to align the left side of square button.
  ///We cannot do what we do with the other sides as the left attribute of Positioned widget is used to handle the
  ///dragging of the button
  final double leftEdgeSpacing;

  ///This field will determined the space between the square sliding button widget and the parent widget on the right end.
  ///In case you have Padding left
  final double rightEdgeSpacing;

  /*///This field will determined the space between the square sliding button and the parent widget on the top.
  final double topEdgeSpacing;

  ///This field will determined the space between the square sliding button and the parent widget on the bottom.
  final double bottomEdgeSpacing;*/

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
  final Widget squareSlidingButtonIcon;

  ///This will be the background color of the circle sliding button when isEnable = False
  final Color? squareSlidingButtonBackgroundColor;

  ///This will be the background color of the square sliding button when isEnable = False
  final Color? squareSlidingButtonDisableBackgroundColor;

  ///This field is used to enable or disable the sliding square button(The slide action)
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

  final SlideToActionController? slideToActionController;

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
    this.slideToActionController,
    this.height = 56,
    this.width = 240,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.parentBoxBackgroundColor,
    this.parentBoxDisableBackgroundColor,
    this.parentBoxGradientBackgroundColor,
    this.parentBoxDisableGradientBackgroundColor,
    this.squareSlidingButtonSize = 50,
    this.squareSlidingButtonRadiusValue = 10,
    this.rightEdgeSpacing = 10,
    /*this.topEdgeSpacing = 0,
      this.bottomEdgeSpacing = 0,*/
    this.squareSlidingButtonBackgroundColor = Colors.green,
    this.squareSlidingButtonDisableBackgroundColor = Colors.black12,
    this.leftEdgeSpacing = 0,
    this.isEnable = true,
    this.slideActionButtonType = SlideActionButtonType.basicSlideActionButton,
    this.loaderColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 700),
  });

  @override
  State<SquareSlideToActionButton> createState() =>
      _CircleSlideToActionButtonState();
}

class _CircleSlideToActionButtonState extends State<SquareSlideToActionButton> {
  @override
  Widget build(BuildContext context) {
    return _buildBaseSlideActionWidget();
  }

  Widget _buildBaseSlideActionWidget() {
    switch (widget.slideActionButtonType) {
      case SlideActionButtonType.basicSlideActionButton:
        return BaseSlideToActionButton(
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
          slidingButtonSize: widget.squareSlidingButtonSize,
          slideButtonWidget: _buildSquareButton(),
        );
      case SlideActionButtonType.slideActionWithLoaderButton:
        return BaseSlideToActionWithLoaderButton(
          slideToActionController: widget.slideToActionController ?? SlideToActionController(),
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
          slidingButtonSize: widget.squareSlidingButtonSize,
          slideButtonWidget: _buildSquareButton(),
        );
    }
  }

  Widget _buildSquareButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.squareSlidingButtonSize,
          width: widget.squareSlidingButtonSize,
          decoration: BoxDecoration(
              color: widget.isEnable
                  ? widget.squareSlidingButtonBackgroundColor
                  : widget.squareSlidingButtonDisableBackgroundColor,
              borderRadius:
                  BorderRadius.circular(widget.squareSlidingButtonRadiusValue)),
          child: widget.squareSlidingButtonIcon,
        ),
      ],
    );
  }
}
