# Migration Guide

## 0.0.8 → 1.0.0

Version 1.0.0 introduces a unified `SlideToActionButton` that replaces the
separate `CircleSlideToActionButton` and `SquareSlideToActionButton` widgets.

### Widget replacement

```dart
// Before
CircleSlideToActionButton(
  circleSlidingButtonSize: 47,
  circleSlidingButtonIcon: const Icon(Icons.check, color: Colors.orange),
  circleSlidingButtonBackgroundColor: Colors.white,
  circleSlidingButtonDisableBackgroundColor: Colors.grey,
  parentBoxBackgroundColor: Colors.orange,
  parentBoxDisableBackgroundColor: Colors.grey,
  isEnable: true,
  onSlideActionCompleted: () {},
  onSlideActionCanceled: () {},
)

// After
SlideToActionButton(
  slideButtonShape: SlideButtonShape.circle,
  thumbSize: 47,
  thumbIcon: const Icon(Icons.check, color: Colors.orange),
  thumbEnabledColor: Colors.white,
  thumbDisabledColor: Colors.grey,
  enabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.orange),
  disabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.grey),
  isEnabled: true,
  onSlideActionCompleted: () {},
)
```

```dart
// Before
SquareSlideToActionButton(
  squareSlidingButtonSize: 50,
  squareSlidingButtonIcon: const Icon(Icons.check, color: Colors.orange),
  squareSlidingButtonBackgroundColor: Colors.white,
  parentBoxGradientBackgroundColor: LinearGradient(
    colors: [Colors.orange, Colors.deepOrange],
  ),
  parentBoxDisableGradientBackgroundColor: LinearGradient(
    colors: [Colors.grey, Colors.grey],
  ),
  onSlideActionCompleted: () {},
  onSlideActionCanceled: () {},
)

// After
SlideToActionButton(
  slideButtonShape: SlideButtonShape.square,
  thumbSize: 50,
  thumbIcon: const Icon(Icons.check, color: Colors.orange),
  thumbEnabledColor: Colors.white,
  enabledTrackDecoration: SlideTrackDecoration.fromGradient(
    LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
  ),
  disabledTrackDecoration: SlideTrackDecoration.fromGradient(
    LinearGradient(colors: [Colors.grey, Colors.grey]),
  ),
  onSlideActionCompleted: () {},
)
```

### Parameter renames

| 0.0.8 | 1.0.0 |
|---|---|
| `circleSlidingButtonSize` / `squareSlidingButtonSize` | `thumbSize` |
| `circleSlidingButtonIcon` / `squareSlidingButtonIcon` | `thumbIcon` |
| `circleSlidingButtonBackgroundColor` / `squareSlidingButtonBackgroundColor` | `thumbEnabledColor` |
| `circleSlidingButtonDisableBackgroundColor` / `squareSlidingButtonDisableBackgroundColor` | `thumbDisabledColor` |
| `parentBoxBackgroundColor` | `SlideTrackDecoration.fromColor()` on `enabledTrackDecoration` |
| `parentBoxDisableBackgroundColor` | `SlideTrackDecoration.fromColor()` on `disabledTrackDecoration` |
| `parentBoxGradientBackgroundColor` | `SlideTrackDecoration.fromGradient()` on `enabledTrackDecoration` |
| `parentBoxDisableGradientBackgroundColor` | `SlideTrackDecoration.fromGradient()` on `disabledTrackDecoration` |
| `isEnable` | `isEnabled` |
| `circleSlidingButtonRadiusValue` / `squareSlidingButtonRadiusValue` | `thumbBorderRadius` |

### Removed parameters

| Parameter | Reason |
|---|---|
| `topEdgeSpacing` | Thumb is now always vertically centred |
| `bottomEdgeSpacing` | Thumb is now always vertically centred |

### Now optional

| Parameter | Previously |
|---|---|
| `finalSlidingActionLabel` | Required |
| `onSlideActionCanceled` | Required |