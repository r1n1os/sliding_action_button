## About This Package
Slide action button package developed to provide an easy way to flutter developers implemending button that slides to perform an action. It is customizable by providing the option to change button container color, adding custom icon to draggable buttons, enable or disable button with applying different color per status.<br/> 

### Available Features:
- CircleSlidingActionButton
- SquareSlidingActionButton 
- The above options with the ability to show loading state when the sliding action is completed <br/>

### What are the benefits of using this package:
- Save development time
- With only few lines of code you can have the sliding action functionaly

## Requirements
Minimum Flutter SDK: 3.0.0
##

### Example usage of the current supported features
<p align="left">
  <a title="simulator_image"><img src="https://github.com/r1n1os/sliding_action_button/raw/master/screenshots/sliding_action_button_example.gif" height="530" width="250"></a>
</p>

## Configurations

### General parameters used in all options 
| Parameters                              | Description                                                                                                                                                                                                              |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| height                                  | This is the height of the whole widget.                                                                                                                                                                                  |
| width                                   | This is the width of the whole widget                                                                                                                                                                                    |
| parentBoxRadiusValue                    | This is the double value for the `BorderRadius.circular()` attribute to configure the corners of parent box.                                                                                                              |
| parentBoxBackgroundColor                | This is the background color of the parent box when isEnable is True. NOTE: You cannot set this and also, set the `parentBoxGradientBackgroundColor` or `parentBoxDisableGradientBackgroundColor`.                        |
| parentBoxDisableBackgroundColor         | This is the background color of the parent box when isEnable is False. NOTE: You cannot set this and also, set the `parentBoxGradientBackgroundColor` or `parentBoxDisableGradientBackgroundColor`.                       |
| parentBoxGradientBackgroundColor        | This is the background color of the parent box in case you want to use gradient when isEnable is True. NOTE: You cannot set this and also, set the `parentBoxBackgroundColor` or `parentBoxDisableBackgroundColor`.       |
| parentBoxDisableGradientBackgroundColor | This will be the background color of the parent box in case you want to use gradient when isEnable is False. NOTE: You cannot set this and also, set the `parentBoxBackgroundColor` or `parentBoxDisableBackgroundColor`. |
| initialSlidingActionLabel               | This is the text appear in the parent box before the sliding action.                                                                                                                                                      |
| finalSlidingActionLabel                 | This is the text appear in the parent box after the sliding action.                                                                                                                                                       |
| initialSlidingActionLabelTextStyle      | This is the text styling of the label appear before the sliding action.                                                                                                                                                   |
| finalSlidingActionLabelTextStyle        | This is the text styling of the label appear after the sliding action. In case this field is null the same style as the `initialSlidingActionLabelTextStyle` will be used.                                               |
| isEnable                                | This is used to enable or disable the sliding action. The default value is `True`.                                                                                                                                        |
| loaderColor                             | This is the color of the loader once the sliding action is completed. By default is `White`.                                                                                                                             |
| animationDuration                       | This is the time needed for the visibility change from slide to action button to loader. By Default is `700 milliseconds`.                                                                                               |
| onSlideActionCompleted                  | This is a callback used to indicate the end of the sliding action with success.                                                                                                                                           |
| onSlideActionCanceled                   | This is a callback used to indicate the end of the sliding action without suceed.                                                                                                                                         |
| SlideToActionController                 | This is used to handle the state of the button (i.e initial, loading, reset). By default is initial.  `NOTE: In case you don't pass an instance of SlideToActionController on will be created to handle the slide action but you will not be able to change button state.`|

### CircleSlidingActionButton
| Parameters                          | Description                                                                                                           |
|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| circleSlidingButtonSize             | This is the width and height of the circle(draggable) button.                                                         |
| circleSlidingButtonRadiusValue      | This is the double value for the `BorderRadius.circular()` attribute on the circle button.                            |
| leftEdgeSpacing                     | This is used to align the left side of circle button.                                                                 |
| rightEdgeSpacing                    | This is used to determined the space between the circle sliding button widget and the parent widget on the right end. |
| circleSlidingButtonIcon             | This is the icon appear on the sliding button.                                                                        |
| circleSlidingButtonBackgroundColor  | This is the background color of the circle sliding button when `isEnable = True`.                                     |
| circleSlidingButtonDisableBackgroundColor | This is the background color of the circle sliding button when `isEnable = False`.                              |
| slideActionButtonType |This field indicating the basic behavior of the slide action (Type). By default is `SlideActionButtonType.basicSlideActionButton`.   |
 
<!---| topEdgeSpacing                                                                                                        | This is used to determined the space between the circle sliding button and the parent widget on the top.|
| bottomEdgeSpacing                   | This is used to determined the space between the circle sliding button and the parent widget on the bottom.--->       


```dart
            CircleSlideToActionButton(
              width: 250,
              parentBoxRadiusValue: 27,
              circleSlidingButtonSize: 47,
              leftEdgeSpacing: 3,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added To Basket',
              circleSlidingButtonIcon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.orange,
              ),
              parentBoxBackgroundColor: Colors.orange,
              parentBoxDisableBackgroundColor: Colors.grey,
              /*  parentBoxGradientBackgroundColor:
                  LinearGradient(colors: [Colors.red, Colors.white]),
              parentBoxDisableGradientBackgroundColor:
                  LinearGradient(colors: [Colors.red, Colors.white]),*/
              circleSlidingButtonBackgroundColor: Colors.white,
              isEnable: true,
              onSlideActionCompleted: () {
                print("Sliding action completed");
              },
              onSlideActionCanceled: () {
                print("Sliding action cancelled");
              },
            ),
```

### SquareSlidingActionButton
| Parameters                          | Description                                                                                                          |
|-------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| squareSlidingButtonSize             | This is the width and height of the square(draggable) button.                                                        |
| squareSlidingButtonRadiusValue      | This is the double value for the `BorderRadius.circular()` attribute on the square button.                           |
| leftEdgeSpacing                     | This is used to align the left side of square button.                                                                |
| rightEdgeSpacing                    | This is used to determined the space between the square sliding button widget and the parent widget on the right end.|
| squareSlidingButtonIcon             | This is the icon appear on the sliding button.                                                                       |
| squareSlidingButtonBackgroundColor  | This is the background color of the square sliding button when `isEnable = True`.                                    |
| squareSlidingButtonDisableBackgroundColor | Thisis the background color of the square sliding button `when isEnable = False`.                              |
| slideActionButtonType |This field indicating the basic behavior of the slide action (Type). By default is `SlideActionButtonType.basicSlideActionButton`.  |
<!---| topEdgeSpacing                      | This is used to determined the space between the square sliding button and the parent widget on the top.             |
| bottomEdgeSpacing                   | This is used to determined the space between the square sliding button and the parent widget on the bottom.--->

```dart
            SquareSlideToActionButton(
              width: 250,
              parentBoxRadiusValue: 15,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added To Basket',
              squareSlidingButtonSize: 50,
              squareSlidingButtonIcon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.orange,
              ),
              squareSlidingButtonBackgroundColor: Colors.white,
              parentBoxGradientBackgroundColor: LinearGradient(
                  colors: [Colors.orange, Colors.grey.withOpacity(0.5)]),
              parentBoxDisableGradientBackgroundColor: LinearGradient(colors: [
                Colors.grey,
              ]),
              leftEdgeSpacing: 2,
              rightEdgeSpacing: 4,
              onSlideActionCompleted: () {
                print("Sliding action completed");
              },
              onSlideActionCanceled: () {
                print("Sliding action cancelled");
              },
            );
```

## Additional information

New features are coming! 

Thank you for your interest in my package. If you have any feedback, found a bug or need something that is missing feel free to create an issue in the following link. 
https://github.com/r1n1os/sliding_action_button/issues
