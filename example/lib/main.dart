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
      title: 'Sliding Action Button',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final SlideToActionController _controller = SlideToActionController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        title: const Text(
          'Sliding Action Button',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Circle · solid ───────────────────────────────────────────
            const _SectionLabel(
              icon: Icons.circle_outlined,
              title: 'Circle · Solid color',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              initialSlidingActionLabel: 'Slide to add to basket',
              finalSlidingActionLabel: '✓  Added to basket',
              enabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFF6C63FF),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.add_shopping_cart_rounded,
                color: Color(0xFF6C63FF),
              ),
              onSlideActionCompleted: () => debugPrint('Circle solid: done'),
            ),

            const SizedBox(height: 36),

            // ── Circle · gradient ────────────────────────────────────────
            const _SectionLabel(
              icon: Icons.circle_outlined,
              title: 'Circle · Gradient',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              initialSlidingActionLabel: 'Slide to confirm',
              finalSlidingActionLabel: '✓  Confirmed',
              enabledTrackDecoration: const SlideTrackDecoration.fromGradient(
                LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                ),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.check_rounded,
                color: Color(0xFF6C63FF),
              ),
              onSlideActionCompleted: () => debugPrint('Circle gradient: done'),
            ),

            const SizedBox(height: 36),

            // ── Circle · with loader ─────────────────────────────────────
            const _SectionLabel(
              icon: Icons.circle_outlined,
              title: 'Circle · With loader',
              subtitle: 'Resets after 3 seconds',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              slideToActionController: _controller,
              slideActionButtonType:
                  SlideActionButtonType.slideActionWithLoaderButton,
              initialSlidingActionLabel: 'Slide to place order',
              finalSlidingActionLabel: '✓  Order placed',
              enabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFF2EC4B6),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.shopping_bag_rounded,
                color: Color(0xFF2EC4B6),
              ),
              onSlideActionCompleted: () async {
                _controller.loading();
                await Future.delayed(const Duration(seconds: 3));
                _controller.reset();
              },
            ),

            const SizedBox(height: 36),

            // ── Circle · disabled ────────────────────────────────────────
            const _SectionLabel(
              icon: Icons.circle_outlined,
              title: 'Circle · Disabled',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              isEnabled: false,
              initialSlidingActionLabel: 'Currently unavailable',
              enabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFF6C63FF),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFFAAAAAA),
              ),
              onSlideActionCompleted: () {},
            ),

            const SizedBox(height: 36),

            // ── Square · solid ───────────────────────────────────────────
            const _SectionLabel(
              icon: Icons.crop_square_rounded,
              title: 'Square · Solid color',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              slideButtonShape: SlideButtonShape.square,
              initialSlidingActionLabel: 'Slide to pay',
              finalSlidingActionLabel: '✓  Payment sent',
              enabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFFF6B6B),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.payment_rounded,
                color: Color(0xFFFF6B6B),
              ),
              onSlideActionCompleted: () => debugPrint('Square solid: done'),
            ),

            const SizedBox(height: 36),

            // ── Square · gradient ────────────────────────────────────────
            const _SectionLabel(
              icon: Icons.crop_square_rounded,
              title: 'Square · Gradient',
            ),
            const SizedBox(height: 12),
            SlideToActionButton(
              slideButtonShape: SlideButtonShape.square,
              initialSlidingActionLabel: 'Slide to delete',
              finalSlidingActionLabel: '✓  Deleted',
              enabledTrackDecoration: const SlideTrackDecoration.fromGradient(
                LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                ),
              ),
              disabledTrackDecoration: const SlideTrackDecoration.fromColor(
                Color(0xFFCBCBCB),
              ),
              thumbIcon: const Icon(
                Icons.delete_rounded,
                color: Color(0xFFFF6B6B),
              ),
              onSlideActionCompleted: () => debugPrint('Square gradient: done'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section label helper ──────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6C63FF)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF2D2D2D),
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
