[![pub version](https://img.shields.io/pub/v/sliding_action_button.svg)](https://pub.dev/packages/sliding_action_button)
[![pub points](https://img.shields.io/pub/points/sliding_action_button)](https://pub.dev/packages/sliding_action_button/score)
[![likes](https://img.shields.io/pub/likes/sliding_action_button)](https://pub.dev/packages/sliding_action_button/score)

# sliding_action_button

A customizable Flutter slide-to-confirm button. Reduces accidental triggers on destructive or irreversible actions by requiring the user to drag a thumb across a track.

Supports circle and square shapes, solid colors and gradients, async loader state, and haptic feedback.

<p align="left">
  <a title="simulator_image"><img src="https://github.com/r1n1os/sliding_action_button/raw/master/screenshots/sliding_action_button_example.gif" height="530" width="250"></a>
</p>

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  sliding_action_button: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Usage

### Circle (default)

```dart
SlideToActionButton(
initialSlidingActionLabel: 'Slide to confirm',
finalSlidingActionLabel: '✓ Confirmed',
enabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.orange),
disabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.grey),
thumbIcon: const Icon(Icons.check, color: Colors.orange),
onSlideActionCompleted: () {
debugPrint('Action confirmed');
},
)
```

### Square

```dart
SlideToActionButton(
slideButtonShape: SlideButtonShape.square,
initialSlidingActionLabel: 'Slide to pay',
finalSlidingActionLabel: '✓ Payment sent',
enabledTrackDecoration: SlideTrackDecoration.fromGradient(
LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
),
disabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.grey),
thumbIcon: const Icon(Icons.payment, color: Colors.orange),
onSlideActionCompleted: () {
debugPrint('Payment confirmed');
},
)
```

### With loader (async flow)

Use this when your action involves an async operation such as an API call.
The button shows a spinner after the slide completes and resets once the
operation finishes.

```dart
final controller = SlideToActionController();

SlideToActionButton(
slideToActionController: controller,
slideActionButtonType: SlideActionButtonType.slideActionWithLoaderButton,
initialSlidingActionLabel: 'Slide to confirm order',
finalSlidingActionLabel: 'Processing...',
enabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.orange),
disabledTrackDecoration: SlideTrackDecoration.fromColor(Colors.grey),
thumbIcon: const Icon(Icons.check, color: Colors.orange),
onSlideActionCompleted: () async {
controller.loading();
await placeOrder();
controller.reset();
},
)
```

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `initialSlidingActionLabel` | `String` | required | Label shown before the slide completes |
| `finalSlidingActionLabel` | `String?` | null | Label shown after the slide completes. Falls back to `initialSlidingActionLabel` |
| `onSlideActionCompleted` | `VoidCallback` | required | Called when the slide completes |
| `onSlideActionCanceled` | `VoidCallback?` | null | Called when the user releases before the threshold |
| `slideButtonShape` | `SlideButtonShape` | `circle` | Shape of the thumb and track |
| `slideActionButtonType` | `SlideActionButtonType` | `basicSlideActionButton` | Whether to show a loader after completion |
| `slideToActionController` | `SlideToActionController?` | null | Controls loading and reset states externally |
| `enabledTrackDecoration` | `SlideTrackDecoration` | orange | Track decoration when enabled |
| `disabledTrackDecoration` | `SlideTrackDecoration` | grey | Track decoration when disabled |
| `thumbIcon` | `Widget?` | null | Icon inside the thumb |
| `thumbEnabledColor` | `Color` | white | Thumb color when enabled |
| `thumbDisabledColor` | `Color` | white | Thumb color when disabled |
| `height` | `double` | `56` | Height of the track |
| `width` | `double?` | null | Width of the track. Fills available width when null |
| `thumbSize` | `double` | `50` | Width and height of the thumb |
| `thumbBorderRadius` | `double?` | null | Thumb corner radius. Derived from shape when null |
| `parentBoxRadiusValue` | `double?` | null | Track corner radius. Derived from shape when null |
| `leftEdgeSpacing` | `double` | `3` | Space between left edge and thumb at rest |
| `rightEdgeSpacing` | `double` | `3` | Space between right edge and thumb at full travel |
| `completionThreshold` | `double` | `0.85` | Fraction of track width required to trigger completion |
| `enableHapticFeedback` | `bool` | `true` | Fire haptic on completion |
| `animationDuration` | `Duration` | `700ms` | Snap-back and label crossfade speed |
| `loaderColor` | `Color` | white | Color of the loading spinner |
| `isEnabled` | `bool` | `true` | Whether the button accepts interaction |
| `initialSlidingActionLabelTextStyle` | `TextStyle?` | null | Text style for the initial label |
| `finalSlidingActionLabelTextStyle` | `TextStyle?` | null | Text style for the final label |

---

## Migrating from 0.0.8

If you are upgrading from version 0.0.8, see the [Migration Guide](MIGRATION.md)
for the full list of breaking changes and before/after code examples.

---

## Issues and feedback

Found a bug or need a feature?
[Open an issue on GitHub](https://github.com/r1n1os/sliding_action_button/issues)