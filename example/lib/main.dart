import 'package:flutter/material.dart';
import 'package:sliding_action_button/sliding_action_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sliding Action Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///This is the controller used to control the circle sliding action state (Loading, resetting etc)
  final SlideToActionController _circleSlideToActionController =
      SlideToActionController();

  ///This is the controller used to control the square sliding action state (Loading, resetting etc)
  final SlideToActionController _squareSlidToActionController =
      SlideToActionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Circle Basic Slide To Action Button Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              CircleSlideToActionButton(
                //slideToActionController: controller2,
                width: 250,
                parentBoxRadiusValue: 27,
                circleSlidingButtonSize: 47,
                leftEdgeSpacing: 3,
                rightEdgeSpacing: 3,
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
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Circle Slide To Action With Loader Button Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              CircleSlideToActionButton(
                slideToActionController: _circleSlideToActionController,
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
                circleSlidingButtonBackgroundColor: Colors.white,
                isEnable: true,
                slideActionButtonType:
                    SlideActionButtonType.slideActionWithLoaderButton,
                onSlideActionCompleted: () async {
                  _circleSlideToActionController.loading();
                  await Future.delayed(const Duration(seconds: 3), () {
                    _circleSlideToActionController.reset(3);
                  });
                  print("Sliding action completed");
                },
                onSlideActionCanceled: () {
                  print("Sliding action cancelled");
                },
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Circle Slide To Action Disable Button Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              CircleSlideToActionButton(
                slideToActionController: SlideToActionController(),
                width: 250,
                parentBoxRadiusValue: 27,
                circleSlidingButtonSize: 50,
                leftEdgeSpacing: 2,
                rightEdgeSpacing: 4,
                initialSlidingActionLabel: 'Add To Basket',
                finalSlidingActionLabel: 'Added To Basket',
                circleSlidingButtonIcon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.orange,
                ),
                parentBoxBackgroundColor: Colors.orange,
                parentBoxDisableBackgroundColor: Colors.grey.withOpacity(0.5),
                circleSlidingButtonBackgroundColor: Colors.white,
                circleSlidingButtonDisableBackgroundColor: Colors.white,
                isEnable: false,
                onSlideActionCompleted: () {
                  print("Sliding action completed");
                },
                onSlideActionCanceled: () {
                  print("Sliding action cancelled");
                },
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Square Slide To Action Button Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
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
                parentBoxBackgroundColor: Colors.orange,
                parentBoxDisableBackgroundColor: Colors.grey,
                leftEdgeSpacing: 2,
                rightEdgeSpacing: 4,
                onSlideActionCompleted: () {
                  print("Sliding action completed");
                },
                onSlideActionCanceled: () {
                  print("Sliding action cancelled");
                },
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Square Slide To Action With Loader Button Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SquareSlideToActionButton(
                slideToActionController: _squareSlidToActionController,
                width: 250,
                parentBoxRadiusValue: 15,
                squareSlidingButtonSize: 50,
                leftEdgeSpacing: 3,
                initialSlidingActionLabel: 'Add To Basket',
                finalSlidingActionLabel: 'Added To Basket',
                squareSlidingButtonIcon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.orange,
                ),
                parentBoxBackgroundColor: Colors.orange,
                parentBoxDisableBackgroundColor: Colors.grey,
                squareSlidingButtonBackgroundColor: Colors.white,
                isEnable: true,
                slideActionButtonType:
                    SlideActionButtonType.slideActionWithLoaderButton,
                onSlideActionCompleted: () async {
                  _squareSlidToActionController.loading();
                  await Future.delayed(const Duration(seconds: 3), () {
                    _squareSlidToActionController.reset(3);
                  });
                  print("Sliding action completed");
                },
                onSlideActionCanceled: () {
                  print("Sliding action cancelled");
                },
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Square Slide To Action Button with Gradient Example',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SquareSlideToActionButton(
                //slideToActionController: SlideToActionController(),
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
                parentBoxDisableGradientBackgroundColor:
                    LinearGradient(colors: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
