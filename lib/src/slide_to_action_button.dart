import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_action_button/sliding_action_button.dart';

/// A slide-to-confirm button that requires the user to drag a thumb
/// across a track to trigger an action.
///
/// Prefer this over a regular button for destructive or irreversible
/// actions — the friction of sliding reduces accidental triggers.
///
/// ```dart
/// SlideToActionButton(
///   initialSlidingActionLabel: 'Slide to confirm',
///   onSlideActionCompleted: () => placeOrder(),
/// )
/// ```

class SlideToActionButton extends StatefulWidget {

  /// Configure both thumb and track corner radius defaults.
  /// Overriding either [thumbBorderRadius] or [parentBoxRadiusValue] takes
  /// precedence over the shape-derived defaults. Defaults to [SlideButtonShape.circle].
  final SlideButtonShape slideButtonShape;

  /// Height of the track container in logical pixels.
  /// Defaults to 56.
  final double height;

  /// Width of the track container.
  /// When null, expands to fill available width.
  final double? width;

  /// Width and height of the draggable thumb in logical pixels.
  /// Defaults to 50.
  final double thumbSize;

  /// Corner radius of the draggable thumb.
  /// When null, derived from [slideButtonShape] : circle → [thumbSize] / 2, square → 6dp.
  final double? thumbBorderRadius;

  /// Corner radius of the track container.
  /// When null, derived from [slideButtonShape]: circle → [height] / 2 (pill), square → 8dp.
  final double? parentBoxRadiusValue;

  /// Track decoration when [isEnabled] is true.
  /// Supply either [SlideTrackDecoration.fromColor] or [SlideTrackDecoration.fromGradient].
  final SlideTrackDecoration enabledTrackDecoration;

  /// Track decoration when [isEnabled] is false.
  /// Supply either [SlideTrackDecoration.fromColor] or [SlideTrackDecoration.fromGradient].
  final SlideTrackDecoration disabledTrackDecoration;

  /// Thumb background color when [isEnabled] is true.
  final Color thumbEnabledColor;

  /// Thumb background color when [isEnabled] is false.
  final Color thumbDisabledColor;

  /// Icon displayed inside the draggable thumb, typically an [Icon].
  final Widget? thumbIcon;

  /// Cannot be driven by [Positioned.left] like [rightEdgeSpacing] because
  /// [left] is already used to animate the thumb position during drag.
  /// This is applied as static padding at the thumb's initial offset.
  final double leftEdgeSpacing;

  /// Space between the thumb at its rightmost position and the right
  /// edge of the track, in logical pixels. Defaults to 3.
  final double rightEdgeSpacing;

  /// Label shown before the slide completes.
  final String initialSlidingActionLabel;

  /// Label shown after the slide completes.
  /// When null, [initialSlidingActionLabel] persists after completion.
  final String? finalSlidingActionLabel;

  /// Text style for [initialSlidingActionLabel].
  final TextStyle? initialSlidingActionLabelTextStyle;

  /// Text style for [finalSlidingActionLabel].
  /// Falls back to [initialSlidingActionLabelTextStyle], then white.
  final TextStyle? finalSlidingActionLabelTextStyle;

  /// Whether the button accepts user interaction. Defaults to true.
  final bool isEnabled;

  /// Fraction of track width (0.0–1.0) required to trigger completion.
  /// A fast fling (>800 px/s) bypasses this threshold entirely.
  /// Lower values make accidental triggers more likely — don't go below 0.6.
  final double completionThreshold;

  /// Fires [HapticFeedback.mediumImpact] on completion.
  /// Disable only if your action already triggers its own system haptic.
  final bool enableHapticFeedback;

  /// Controls snap-back and label crossfade speed.
  /// 700ms is tuned for the average thumb travel distance.
  final Duration animationDuration;

  /// Determines whether a loader is shown after completion.
  /// Defaults to [SlideActionButtonType.basicSlideActionButton].
  final SlideActionButtonType slideActionButtonType;

  /// Color of the [CircularProgressIndicator]. Defaults to white.
  final Color loaderColor;

  /// Controls the sliding action states (Loading, resetting etc)
  /// When null, an internal controller is created and owned by the widget.
  /// Pass your own instance when you need to drive [loading] or [reset]
  /// from outside — for example, after an API call resolves.
  /// The widget never disposes an externally provided controller.
  final SlideToActionController? slideToActionController;

  /// Called when the slide completes successfully.
  final VoidCallback onSlideActionCompleted;

  /// Called when the user releases before [completionThreshold].
  /// When null, cancellation is silently ignored.
  final VoidCallback? onSlideActionCanceled;

  const SlideToActionButton({
    super.key,
    required this.initialSlidingActionLabel,
    required this.onSlideActionCompleted,
    this.slideButtonShape = SlideButtonShape.circle,
    this.finalSlidingActionLabel,
    this.slideToActionController,
    this.height = 56,
    this.width,
    this.initialSlidingActionLabelTextStyle,
    this.finalSlidingActionLabelTextStyle,
    this.thumbSize = 50,
    this.thumbBorderRadius,
    this.parentBoxRadiusValue,
    this.enabledTrackDecoration =
        const SlideTrackDecoration.fromColor(Colors.orange),
    this.disabledTrackDecoration =
        const SlideTrackDecoration.fromColor(Colors.grey),
    this.thumbEnabledColor = Colors.white,
    this.thumbDisabledColor = Colors.white,
    this.thumbIcon,
    this.leftEdgeSpacing = 3,
    this.rightEdgeSpacing = 3,
    this.isEnabled = true,
    this.completionThreshold = 0.85,
    this.enableHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 700),
    this.slideActionButtonType = SlideActionButtonType.basicSlideActionButton,
    this.loaderColor = Colors.white,
    this.onSlideActionCanceled,
  });

  @override
  State<SlideToActionButton> createState() => _SlideToActionButtonState();
}

class _SlideToActionButtonState extends State<SlideToActionButton> {
  late final SlideToActionController _controller;

  // This variable indicating if the widget is own the controller.
  // Never dispose controller if we don't own the controller. The caller who holds the reference need's to do it.
  bool _ownsController = false;

  // Raw pixel offset of the thumb from its resting position.
  // Clamped to [0, maxDragOffset] on every drag update.
  double _dragOffset = 0;

  // Separate from controller state so the label can update independently
  // of the loading lifecycle.
  bool _showFinalLabel = false;

  bool get _isLoading => _controller.state == LoaderButtonEnumStates.loading;

// Square uses non-zero default intentionally — 0 radius looks harsh
// on modern UI. 8dp matches Material 3 card and input field conventions.
  double get _effectiveTrackRadius {
    if (widget.parentBoxRadiusValue != null) return widget.parentBoxRadiusValue!;
    switch (widget.slideButtonShape) {
      case SlideButtonShape.circle:
        return widget.height / 2;
      case SlideButtonShape.square:
        return 8;
    }
  }

// Square uses non-zero default intentionally — 0 radius looks harsh
// on modern UI. 6dp matches Material 3 thumb and button conventions.
  double get _effectiveThumbRadius {
    if (widget.thumbBorderRadius != null) return widget.thumbBorderRadius!;
    switch (widget.slideButtonShape) {
      case SlideButtonShape.circle:
        return widget.thumbSize / 2;
      case SlideButtonShape.square:
        return 6;
    }
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

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  // Guards against setState after dispose — controller resets can arrive
  // asynchronously after an API call resolves.
  void _onControllerUpdate() {
    if (!mounted) return;
    setState(() {
      if (_controller.state == LoaderButtonEnumStates.initial) {
        _dragOffset = 0;
        _showFinalLabel = false;
      }
    });
  }

  // Blocks drag during loading — thumb must not move while spinner is visible.
  void _onDragUpdate(DragUpdateDetails details, double maxDragOffset) {
    if (!widget.isEnabled || _controller.state != LoaderButtonEnumStates.initial)
      return;
    setState(() {
      _dragOffset = (_dragOffset + details.delta.dx).clamp(0, maxDragOffset);
    });
  }

  // Completes on either threshold reached or fast fling.
  // Fast fling path exists so the user doesn't have to drag the full distance.
  void _onDragEnd(DragEndDetails d, double maxDragOffset) {
    if (!widget.isEnabled || _isLoading) return;
    final progress = maxDragOffset > 0 ? _dragOffset / maxDragOffset : 0.0;
    final velocity = d.primaryVelocity ?? 0;
    if (progress >= widget.completionThreshold || velocity > 800) {
      _complete(maxDragOffset);
    } else {
      _cancel();
    }
  }

  // Snaps thumb to end before firing callback so the UI reflects
  // completion state synchronously — even if the callback is async.
  void _complete(double maxDragOffset) {
    if (widget.enableHapticFeedback) HapticFeedback.mediumImpact();
    setState(() {
      _dragOffset = maxDragOffset;
      _showFinalLabel = true;
    });
    widget.onSlideActionCompleted.call();
  }

  // Resetting the UI and calling the [widget.onSlideActionCanceled] in case that is not null.
  void _cancel() {
    setState(() {
      _dragOffset = 0;
      _showFinalLabel = false;
    });
    widget.onSlideActionCanceled?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isLTR = Directionality.of(context) == TextDirection.ltr;
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = widget.width ?? constraints.maxWidth;

        // Computed here, not stored as a field, to stay in sync with
        // every layout pass. Storing it as state risks stale values
        // after orientation changes or parent resizes.
        final double maxDragOffset = trackWidth -
            widget.thumbSize -
            widget.leftEdgeSpacing -
            widget.rightEdgeSpacing;

        final SlideTrackDecoration decoration = widget.isEnabled
            ? widget.enabledTrackDecoration
            : widget.disabledTrackDecoration;

        return SizedBox(
          width: trackWidth,
          height: widget.height,
          child: Stack(
            children: [
              _trackWidget(decoration),
              _followingTrackWidget(),
              Center(
                child: AnimatedSwitcher(
                  duration: widget.animationDuration,
                  child: _isLoading
                      ? _loadingWidget()
                      : _labelWidget()
                ),
              ),
              _thumbWidget(isLTR, maxDragOffset)
            ],
          ),
        );
      },
    );
  }

  // Animates color/gradient transition smoothly when isEnabled changes.
  Widget _trackWidget(SlideTrackDecoration decoration) {
    return  Positioned.fill(
      child: AnimatedContainer(
        duration: widget.animationDuration,
        decoration: decoration.toBoxDecoration(
          borderRadius: _effectiveTrackRadius,
        ),
      ),
    );
  }

  // Progress fill — subtle white overlay that widens with the thumb.
  // Alpha 0.15 is intentionally low to avoid obscuring the label.
  Widget _followingTrackWidget() {
    return Positioned(
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
    );
  }

 Widget _loadingWidget() {
    return SizedBox(
      key: const ValueKey('loader'),
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.loaderColor,
        ),
      ),
    );
  }

  // AnimatedSwitcher crossfades between initial label, final label, and spinner.
  // ValueKey on _showFinalLabel forces a rebuild when label content changes,
  // triggering the crossfade animation.
  Widget _labelWidget() {
    return Text(
      key: ValueKey(_showFinalLabel),
      _showFinalLabel
          ? widget.finalSlidingActionLabel ?? widget.initialSlidingActionLabel
          : widget.initialSlidingActionLabel,
      style:_showFinalLabel
          ? widget.finalSlidingActionLabelTextStyle ??
          widget.initialSlidingActionLabelTextStyle ??
          const TextStyle(color: Colors.white)
          : widget.initialSlidingActionLabelTextStyle ??
          const TextStyle(color: Colors.white),
    );
  }

  // AnimatedPositioned only animates when snapping back to zero.
  // During active drag, duration is zero to keep thumb in sync with finger.
  Widget _thumbWidget(bool isLTR, double maxDragOffset) {
    return AnimatedPositioned(
      duration: _dragOffset == 0
          ? widget.animationDuration
          : Duration.zero,
      left: isLTR ? widget.leftEdgeSpacing + _dragOffset : null,
      right: isLTR ? null : widget.leftEdgeSpacing + _dragOffset,
      top: (widget.height - widget.thumbSize) / 2,
      child: GestureDetector(
        onHorizontalDragUpdate:
        widget.isEnabled ? (DragUpdateDetails details) {
          _onDragUpdate(details, maxDragOffset);
        }: null,
        onHorizontalDragEnd: widget.isEnabled ? (DragEndDetails details) {
          _onDragEnd(details, maxDragOffset);
        }  : null,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          width: widget.thumbSize,
          height: widget.thumbSize,
          decoration: BoxDecoration(
            color: widget.isEnabled
                ? widget.thumbEnabledColor
                : widget.thumbDisabledColor,
            borderRadius:
            BorderRadius.circular(_effectiveThumbRadius),
            boxShadow: widget.isEnabled
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
    );
  }
}