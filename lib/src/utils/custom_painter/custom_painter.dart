import 'package:flutter/cupertino.dart';

class CirclePainter extends  CustomPainter {
  final double currentState;
  final Color color;
  final bool isCompleted;
  final double sizeOfButton;

  CirclePainter({
    required this.currentState,
    required this.color,
    required this.isCompleted,
    required this.sizeOfButton,
  });

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, isCompleted ? currentState + sizeOfButton : currentState, size.height),
    topLeft:  Radius.circular(27),
    topRight:  Radius.circular(27),
    bottomLeft:  Radius.circular(27),
    bottomRight:  Radius.circular(27));

    canvas.drawRRect(rect ,paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}