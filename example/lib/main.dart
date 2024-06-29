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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleSlideToActionButton(
              width: 250,
              parentBoxRadiusValue: 27,
              circleSlidingButtonSize: 50,
              leftEdgeSpacing: 2,
              rightEdgeSpacing: 4,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added',
              circleSlidingButtonIcon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.orange,
              ),
              //slidingBoxBackgroundColor: Colors.orange,
              parentBoxGradientBackgroundColor:
                  LinearGradient(colors: [Colors.red, Colors.white]),
              parentBoxDisableGradientBackgroundColor:
                  LinearGradient(colors: [Colors.red, Colors.white]),
              circleSlidingButtonBackgroundColor: Colors.white,
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
            SquareSlideToActionButton(
              width: 250,
              parentBoxRadiusValue: 15,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added',
              squareSlidingButtonSize: 40,
              squareSlidingButtonIcon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.orange,
              ),
              squareSlidingButtonBackgroundColor: Colors.white,
              parentBoxBackgroundColor: Colors.orange,
              parentBoxDisableBackgroundColor: Colors.grey,
              leftEdgeSpacing: 2,
              rightEdgeSpacing: 4,
              topEdgeSpacing: 7,
              bottomEdgeSpacing: 5,
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
    );
  }
}
