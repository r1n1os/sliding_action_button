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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleSlideToActionButton(
              width: 270,
              parentBoxRadiusValue: 27,
              circleSlidingButtonSize: 50,
              leftEdgeSpacing: 2,
              rightEdgeSpacing: 4,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added',
              circleSlidingButtonIcon: const Icon(Icons.add_shopping_cart),
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
              width: 270,
              parentBoxRadiusValue: 15,
              initialSlidingActionLabel: 'Add To Basket',
              finalSlidingActionLabel: 'Added',
              squareSlidingButtonSize: 40,
              squareSlidingButtonIcon: const Icon(Icons.add_shopping_cart),
              squareSlidingButtonBackgroundColor: Colors.blue,
              leftEdgeSpacing: 2,
              rightEdgeSpacing: 4,
              topEdgeSpacing:7,
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
