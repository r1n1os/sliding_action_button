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

  final SlideToActionController _slideToActionController = SlideToActionController();

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
              //_SectionLabel('Circle · solid colour'),
              const SizedBox(height: 12),
              SlideToActionButton(
                slideButtonShape: SlideButtonShape.circle,
                initialSlidingActionLabel: 'Slide to add to basket',
                finalSlidingActionLabel: '✓ Added to basket',
                enabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.orange),
                disabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.grey),
                thumbIcon:
                const Icon(Icons.add_shopping_cart, color: Colors.orange),
                onSlideActionCompleted: () => debugPrint('Circle basic: done'),
                onSlideActionCanceled: () => debugPrint('Circle basic: cancelled'),
              ),

              const SizedBox(height: 40),

              // ── Circle, with loader ──────────────────────────────────────
              //_SectionLabel('Circle · with loader (resets after 3 s)'),
              const SizedBox(height: 12),
              SlideToActionButton(
                slideButtonShape: SlideButtonShape.circle,
                slideToActionController: _slideToActionController,
                slideActionButtonType:
                SlideActionButtonType.slideActionWithLoaderButton,
                initialSlidingActionLabel: 'Slide to confirm order',
                finalSlidingActionLabel: '✓ Order placed',
                enabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.deepOrange),
                disabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.grey),
                thumbIcon: const Icon(Icons.check, color: Colors.deepOrange),
                onSlideActionCompleted: () async {
                  _slideToActionController.loading();
                  await Future.delayed(const Duration(seconds: 3));
                  _slideToActionController.reset();
                },
                onSlideActionCanceled: () {},
              ),

              const SizedBox(height: 40),

              // ── Circle, disabled ─────────────────────────────────────────
              //_SectionLabel('Circle · disabled'),
              const SizedBox(height: 12),
              SlideToActionButton(
                slideButtonShape: SlideButtonShape.circle,
                isEnable: false,
                initialSlidingActionLabel: 'Unavailable',
                finalSlidingActionLabel: "",
                enabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.orange),
                disabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.grey),
                thumbIcon: const Icon(Icons.block, color: Colors.grey),
                onSlideActionCanceled: () {},
                onSlideActionCompleted: () {},
              ),

              const SizedBox(height: 40),

              // ── Square, gradient ─────────────────────────────────────────
              //_SectionLabel('Square · gradient track'),
              const SizedBox(height: 12),
              SlideToActionButton(
                slideButtonShape: SlideButtonShape.square,
                thumbBorderRadius: 8,
                parentBoxRadiusValue: 14,
                initialSlidingActionLabel: 'Slide to pay',
                finalSlidingActionLabel: '✓ Payment sent',
                enabledTrackDecoration: const SliderTrackDecoration.gradient(
                  LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
                ),
                disabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.grey),
                thumbEnabledColor: Colors.white,
                thumbIcon: const Icon(Icons.payment, color: Colors.purple),
                onSlideActionCompleted: () => debugPrint('Square gradient: done'),
                onSlideActionCanceled: () =>
                    debugPrint('Square gradient: cancelled'),
              ),

              const SizedBox(height: 40),

              // ── Square, low threshold (easy swipe) ───────────────────────
              //_SectionLabel('Square · low threshold (60%)'),
              const SizedBox(height: 12),
              SlideToActionButton(
                slideButtonShape: SlideButtonShape.square,
                thumbBorderRadius: 10,
                parentBoxRadiusValue: 16,
                completionThreshold: 0.60,
                initialSlidingActionLabel: 'Easy swipe (60%)',
                finalSlidingActionLabel: '✓ Done!',
                enabledTrackDecoration: const SliderTrackDecoration.gradient(
                  LinearGradient(
                      colors: [Colors.teal, Color.fromARGB(255, 0, 150, 100)]),
                ),
                disabledTrackDecoration:
                const SliderTrackDecoration.color(Colors.grey),
                thumbIcon: const Icon(Icons.swipe, color: Colors.teal),
                onSlideActionCompleted: () => debugPrint('Low threshold: done'),
                onSlideActionCanceled: () => debugPrint('Cancelled'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
