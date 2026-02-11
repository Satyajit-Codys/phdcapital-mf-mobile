import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';

class DashedRoundedBorder extends StatelessWidget {
  final Widget child;
  final double radius;

  const DashedRoundedBorder({super.key, required this.child, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashedRRectPainter(radius), child: child);
  }
}

class _DashedRRectPainter extends CustomPainter {
  final double radius;

  _DashedRRectPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.grey100
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 4;
    const dashSpace = 4;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
