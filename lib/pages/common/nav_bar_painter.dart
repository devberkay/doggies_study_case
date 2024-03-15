import 'package:flutter/material.dart';

class NavbarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint();
    Paint strokePaint = Paint()
      ..color = Color(0xFFE5E5EA) // Set the stroke color
      ..style = PaintingStyle.stroke // Change the paint style to stroke
      ..strokeWidth = 3.0; // Set the stroke width

    Path path = Path();

    // Set the fill color
    fillPaint.color = Color(0xffF2F2F7);

    // Move to the starting point to avoid drawing unnecessary line
    path.moveTo(size.width * 0.04, size.height * 0.14);

    // Smooth the transition to avoid the bulge
    path.cubicTo(size.width * 0.04, size.height * 0.06, size.width * 0.06, 0, size.width * 0.08, 0);
    path.lineTo(size.width * 0.92, 0); // Straight line across the top
    path.cubicTo(size.width * 0.94, 0, size.width * 0.96, size.height * 0.06, size.width * 0.96, size.height * 0.14);

    // Continue with your original path
    path.lineTo(size.width, size.height); // To the bottom right corner
    path.lineTo(0, size.height); // To the bottom left corner, closing the path

    // No need to close the path with path.lineTo() to the starting point, path.close() does that
    path.close();

    // Draw the path with fill paint
    canvas.drawPath(path, fillPaint);

    // Draw the same path with stroke paint for the border
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}




// Define your custom clipper by extending CustomClipper<Path>
class NavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Use the same path definitions as in your NavbarPainter
    path.moveTo(size.width * 0.04, size.height * 0.14);
    path.cubicTo(size.width * 0.04, size.height * 0.06, size.width * 0.06, 0, size.width * 0.08, 0);
    path.lineTo(size.width * 0.92, 0);
    path.cubicTo(size.width * 0.94, 0, size.width * 0.96, size.height * 0.06, size.width * 0.96, size.height * 0.14);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
