import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_action_button/sliding_action_button.dart';
import 'package:sliding_action_button/src/utils/enums/slide_button_shapes.dart';
import 'package:sliding_action_button/src/utils/slider_track_decoration.dart';

class SlideToActionButton extends StatefulWidget {
  ///This field is configure the shape of the thumb
  ///By default is circle
  final SlideButtonShape slideButtonShape;

  ///This field will be the height of the whole widget
  final double height;

  ///This field will be the width of the whole widget
  final double width;

  ///This field will be the width and height of the draggable button
  final double thumbSize;

  ///This field will be the radius of the draggable button
  final double? thumbBorderRadius;

  ///This field will be the double value for the BorderRadius.circular() attribute to configure the corners
  ///of parent box
  final double? parentBoxRadiusValue;

  final SliderTrackDecoration enabledTrackDecoration;
  final SliderTrackDecoration disabledTrackDecoration;
  final Color thumbEnabledColor;
  final Color thumbDisabledColor;

  ///This will be the icon appear on the sliding button
  final Widget? thumbIcon;

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

  ///This field is used to enable or disable the circle sliding button(The slide action)
  ///By default is True
  final bool isEnable;

  final double completionThreshold;
  final bool enableHapticFeedback;
  final Duration animationDuration;

  ///This field indicating the basic behavior of the slide action (Type)
  ///By default is basicSlideActionButton
  final SlideActionButtonType slideActionButtonType;

  ///This field is styling the color of the loader
  ///ByD default is white
  final Color loaderColor;

  ///This field is used to control the circle sliding action state (Loading, resetting etc)
  ///And controlling the slider position
  final SlideToActionController? slideToActionController;

  ///This Function is used to indicate the end of the sliding action with success
  final Function() onSlideActionCompleted;

  ///This Function is used to indicate the end of the sliding action with cancel
  final Function() onSlideActionCanceled;

  ///This will be the background color of the parent box when isEnable is True
  // final Color? parentBoxBackgroundColor;

  ///This will be the background color of the parent box when isEnable is False
  //final Color? parentBoxDisableBackgroundColor;

  ///This will be the background color of the parent box in case you want to use gradient when isEnable is True.
  ///You cannot have both parentBoxBackgroundColor and parentBoxGradientBackgroundColor
  //final Gradient? parentBoxGradientBackgroundColor;

  ///This will be the background color of the parent box in case you want to use gradient when isEnable is False.
  ///You cannot have both parentBoxDisableBackgroundColor and parentBoxDisableGradientBackgroundColor
  //final Gradient? parentBoxDisableGradientBackgroundColor;

  ///This field will be the double value for the BorderRadius.circular() attribute
  //final double circleSlidingButtonRadiusValue;

  ///This will be the background color of the circle sliding button when isEnable = True
  //final Color? circleSlidingButtonBackgroundColor;

  ///This will be the background color of the circle sliding button when isEnable = False
  //final Color? circleSlidingButtonDisableBackgroundColor;

  ///This field is configure the time needed for container to change to loader
  ///By default is 700 milliseconds
  //final Duration animationDuration;

  const SlideToActionButton({
    super.key,
    required this.slideButtonShape,
    required this.initialSlidingActionLabel,
    required this.finalSlidingActionLabel,
    required this.onSlideActionCompleted,
    required this.onSlideActionCanceled,
    this.slideToActionController,
    this.height = 56,
    this.width = 240,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.thumbSize = 50,
    this.thumbBorderRadius,
    this.parentBoxRadiusValue,
    this.enabledTrackDecoration =
        const SliderTrackDecoration.color(Colors.orange),
    this.disabledTrackDecoration =
        const SliderTrackDecoration.color(Colors.grey),
    this.thumbEnabledColor = Colors.white,
    this.thumbDisabledColor = Colors.white,
    this.thumbIcon,
    this.leftEdgeSpacing = 3,
    this.rightEdgeSpacing = 3,
    this.isEnable = true,
    this.completionThreshold = 0.85,
    this.enableHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 700),
    this.slideActionButtonType = SlideActionButtonType.basicSlideActionButton,
    this.loaderColor = Colors.white,
  });

  @override
  State<SlideToActionButton> createState() => _SlideToActionButtonState();
}

class _SlideToActionButtonState extends State<SlideToActionButton> {
  late final SlideToActionController _controller;
  bool _ownsController = false;
  double _dragOffset = 0;
  double _maxDragOffset = 0;
  bool _showFinalLabel = false;

  bool get _isLoading => _controller.state == LoaderButtonEnumStates.loading;

  double get _effectiveTrackRadius =>
      widget.parentBoxRadiusValue ?? widget.height / 2;

  double get _effectiveThumbRadius {
    if (widget.thumbBorderRadius != null) return widget.thumbBorderRadius!;
    return widget.slideButtonShape == SlideButtonShape.circle
        ? widget.thumbSize / 2
        : widget.thumbSize / 6;
  }

  @override
  void initState() {
    super.initState();
    if (widget.slideToActionController != null) {
      _controller = widget.slideToActionController!;
    } else {
      _controller = SlideToActionController();
      _ownsController = true;
    }
    _controller.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (!mounted) return;
    setState(() {
      if (_controller.state == LoaderButtonEnumStates.initial) {
        _dragOffset = 0;
        _showFinalLabel = false;
      }
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.isEnable || _controller.state != LoaderButtonEnumStates.initial)
      return;
    setState(() {
      _dragOffset = (_dragOffset + details.delta.dx).clamp(0, _maxDragOffset);
    });
  }

  void _onDragEnd(DragEndDetails d) {
    if (!widget.isEnable || _isLoading) return;
    final progress = _maxDragOffset > 0 ? _dragOffset / _maxDragOffset : 0.0;
    final velocity = d.primaryVelocity ?? 0;
    if (progress >= widget.completionThreshold || velocity > 800) {
      _complete();
    } else {
      _cancel();
    }
  }

  void _complete() {
    if (widget.enableHapticFeedback) HapticFeedback.mediumImpact();
    setState(() {
      _dragOffset = _maxDragOffset;
      _showFinalLabel = true;
    });
    widget.onSlideActionCompleted.call();
  }

  void _cancel() {
    setState(() {
      _dragOffset = 0;
      _showFinalLabel = false;
    });
    widget.onSlideActionCanceled.call();
  }

  @override
  Widget build(BuildContext context) {
    final isLTR = Directionality.of(context) == TextDirection.ltr;

    return Semantics(
      label: widget.initialSlidingActionLabel,
      hint: 'Slide to confirm',
      enabled: widget.isEnable,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = widget.width ?? constraints.maxWidth;

          _maxDragOffset = trackWidth -
              widget.thumbSize -
              widget.leftEdgeSpacing -
              widget.rightEdgeSpacing;

          final decoration = widget.isEnable
              ? widget.enabledTrackDecoration
              : widget.disabledTrackDecoration;

          return SizedBox(
            width: trackWidth,
            height: widget.height,
            child: Stack(
              children: [
                // ── Track ───────────────────────────────────────────────
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    decoration: decoration.toBoxDecoration(
                      borderRadius: _effectiveTrackRadius,
                    ),
                  ),
                ),

                // ── Progress fill ────────────────────────────────────────
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width:
                      widget.leftEdgeSpacing + widget.thumbSize + _dragOffset,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(_effectiveTrackRadius),
                    ),
                  ),
                ),

                // ── Label ───────────────────────────────────────────────
                Center(
                  child: AnimatedSwitcher(
                    duration: widget.animationDuration,
                    child: _isLoading
                        ? SizedBox(
                            key: const ValueKey('loader'),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.loaderColor,
                              ),
                            ),
                          )
                        : Text(
                            key: ValueKey(_showFinalLabel),
                            _showFinalLabel
                                ? widget.finalSlidingActionLabel
                                : widget.initialSlidingActionLabel,
                            style: _showFinalLabel
                                ? widget.finalSlidingActionLabelTextStyle ??
                                    widget.initialSlidingActionLabelTextStyle
                                : const TextStyle(color: Colors.white),
                          ),
                  ),
                ),

                // ── Thumb ───────────────────────────────────────────────
                AnimatedPositioned(
                  duration: _dragOffset == 0
                      ? widget.animationDuration
                      : Duration.zero,
                  left: isLTR ? widget.leftEdgeSpacing + _dragOffset : null,
                  right: isLTR ? null : widget.leftEdgeSpacing + _dragOffset,
                  top: (widget.height - widget.thumbSize) / 2,
                  child: GestureDetector(
                    onHorizontalDragUpdate:
                        widget.isEnable ? _onDragUpdate : null,
                    onHorizontalDragEnd: widget.isEnable ? _onDragEnd : null,
                    child: AnimatedContainer(
                      duration: widget.animationDuration,
                      width: widget.thumbSize,
                      height: widget.thumbSize,
                      decoration: BoxDecoration(
                        color: widget.isEnable
                            ? widget.thumbEnabledColor
                            : widget.thumbDisabledColor,
                        borderRadius:
                            BorderRadius.circular(_effectiveThumbRadius),
                        boxShadow: widget.isEnable
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Center(child: widget.thumbIcon),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
/*  @override
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
          slidingButtonSize: widget.thumbSize,
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
          slidingButtonSize: widget.thumbSize,
          slideButtonWidget: _buildCircleButton(),
        );
    }
  }

  Widget _buildCircleButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.thumbSize,
          width: widget.thumbSize,
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
}*/
