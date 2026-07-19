## 1.0.0
* Breaking changes:
  * Replaced `CircleSlideToActionButton` and `SquareSlideToActionButton` with
    a single unified `SlideToActionButton` widget controlled by `slideButtonShape`
  * Renamed `isEnable` to `isEnabled`
  * `onSlideActionCanceled` is now optional
  * `finalSlidingActionLabel` is now optional, falls back to `initialSlidingActionLabel`
  * Replaced 4 separate color/gradient parameters with `SlideTrackDecoration`
* New features:
  * Added `completionThreshold` — configurable drag fraction required to trigger completion
  * Added velocity-based completion — fast fling triggers completion regardless of position
  * Added `enableHapticFeedback` parameter
  * Added RTL layout support via `Directionality`
  * Added progress fill overlay that grows as user drags
  * Added automatic default corner radius per shape:
    * Circle — track uses full pill radius, thumb uses full circle radius
    * Square — track defaults to 8dp, thumb defaults to 6dp (modern rounded square look)
    * Both can be overridden via `parentBoxRadiusValue` and `thumbBorderRadius`
## 0.0.8
* Update Example project
    * Update Fluter SDK 3.35.4
* Update Example project Android
    * Project dependencies
    * Gradle version: 8.13.0
    * Kotlin version: 2.2.20
    * Update targetSDK to 36
    * Update NDK to 28.2.13676358
## 0.0.7
* Updates:
  * Introduce SlideToActionController to manage button state. (initial, loading, reset). 
  This ensures all buttons can revert to their default state seamlessly
* Bug Fixes:
  * Resolved an issue where listener failed when the user fully slide the button to the end.
* General:
  * Update ReadMe file (Documentation).
  
## 0.0.6
* Update Example Project and ReadMe files (Update)
* Update Example project Android (Update)
    * Project dependencies
    * Gradle version: 8.8.0
    * Kotlin version: 2.1.0  

## 0.0.5
* Add SlideToActionWithLoader on completion (New Feature)
* Update Example Project and ReadMe files (Update)
* Update Example project Android dependencies and gradle configurations (Update)

## 0.0.4
* Minor bug fixes

## 0.0.3
* Minor bug fixes
* Breaking changes
   * Remove the option of setting top and bottom edge specing as now the sliding button is always align horizontaly to be in the center.

## 0.0.2
* Minor Updates to Documentation
    
## 0.0.1

* Initial Release.
