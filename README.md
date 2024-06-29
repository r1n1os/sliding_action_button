<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package provide an easy implementation of sliding(swipe) action button.

## Features

With this package you can easily implement sliding action button. Currently, it is offering two pre-defined methods. 
- CircleSlidingActionButton
- SquareSlidingActionButton <br/><br/>
With many customizations like changing button container color, adding custom icon to draggable buttons, enable or disable button with applying different color per status. 

## Getting started

Minimum Flutter SDK: 3.0.0

## Usage
<p align="left">
  <a title="simulator_image"><img src="https://github.com/r1n1os/sliding_action_button/blob/master/screenshots/sliding_action_button_example.gif" height="530" width="250"></a>
</p>

### General parameters used in all options 
| Parameters                          | Description
|-------------------------------------|------------------------------------------------------------
| height                               | This is the height of the whole widget
| width                                | This is the width of the whole widget
| parentBoxRadiusValue                 | This is the double value for the `BorderRadius.circular()` attribute to configure the corners of parent box
| parentBoxBackgroundColor             | This is the background color of the parent box when isEnable is True. NOTE: You cannot set this and also, set the `parentBoxGradientBackgroundColor` or `parentBoxDisableGradientBackgroundColor`
| parentBoxDisableBackgroundColor      | This is the background color of the parent box when isEnable is False. NOTE: You cannot set this and also, set the `parentBoxGradientBackgroundColor` or `parentBoxDisableGradientBackgroundColor`
| parentBoxGradientBackgroundColor     | This is the background color of the parent box in case you want to use gradient when isEnable is True. NOTE: You cannot set this and also, set the `parentBoxBackgroundColor` or `parentBoxDisableBackgroundColor`
| parentBoxDisableGradientBackgroundColor |This will be the background color of the parent box in case you want to use gradient when isEnable is False. NOTE: You cannot set this and also, set the `parentBoxBackgroundColor` or `parentBoxDisableBackgroundColor`
| initialSlidingActionLabel            | This is the text appear in the parent box before the sliding action
| finalSlidingActionLabel              | This is the text appear in the parent box after the sliding action
| initialSlidingActionLabelTextStyle   | This is the text styling of the label appear before the sliding action
| finalSlidingActionLabelTextStyle     | This is the text styling of the label appear after the sliding action. In case this field is null the same style as the `initialSlidingActionLabelTextStyle` will be used.
| isEnable                             | This is used to enable or disable the sliding action. The default value is `True`
| onSlideActionCompleted               | This is a callback used to indicate the end of the sliding action with success
| onSlideActionCanceled                | This is a callback used to indicate the end of the sliding action without suceed

### CircleSlidingActionButton
| Parameters                          | Description
|-------------------------------------|------------------------------------------------------------
| circleSlidingButtonSize             | This is the width and height of the circle(draggable) button
| circleSlidingButtonRadiusValue      | This is the double value for the `BorderRadius.circular()` attribute on the circle button
| leftEdgeSpacing                     | This is used to align the left side of circle button.
| rightEdgeSpacing                    | This is used to determined the space between the circle sliding button widget and the parent widget on the right end. 
| topEdgeSpacing                      | This is used to determined the space between the circle sliding button and the parent widget on the top.
| bottomEdgeSpacing                   | This is used to determined the space between the circle sliding button and the parent widget on the bottom.
| circleSlidingButtonIcon             | This is the icon appear on the sliding button
| circleSlidingButtonBackgroundColor  | This is the background color of the circle sliding button when isEnable = True
| circleSlidingButtonDisableBackgroundColor | Thisis the background color of the circle sliding button when isEnable = False

### SquareSlidingActionButton
| Parameters                          | Description
|-------------------------------------|------------------------------------------------------------
| squareSlidingButtonSize             | This is the width and height of the square(draggable) button
| squareSlidingButtonRadiusValue      | This is the double value for the `BorderRadius.circular()` attribute on the square button
| leftEdgeSpacing                     | This is used to align the left side of square button.
| rightEdgeSpacing                    | This is used to determined the space between the square sliding button widget and the parent widget on the right end. 
| topEdgeSpacing                      | This is used to determined the space between the square sliding button and the parent widget on the top.
| bottomEdgeSpacing                   | This is used to determined the space between the square sliding button and the parent widget on the bottom.
| squareSlidingButtonIcon             | This is the icon appear on the sliding button
| squareSlidingButtonBackgroundColor  | This is the background color of the square sliding button when isEnable = True
| squareSlidingButtonDisableBackgroundColor | Thisis the background color of the square sliding button when isEnable = False


## Additional information

New features are comming! 

Thank you for your interest in my package. If you have any feedback, found a bug or need something that is missing feel free to create an issue in the following link. 
https://github.com/r1n1os/sliding_action_button/issues
