import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';

class DashedCircleBorder extends StatelessWidget {
  final Widget child;
  final double size;
  final Color? color;
  final double strokeWidth;

  const DashedCircleBorder({
    super.key,
    required this.child,
    required this.size,
    this.color,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCirclePainter(
        color: color ?? AppColors.grey300,
        strokeWidth: strokeWidth,
      ),
      child: child,
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _DashedCirclePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const dashWidth = 8.0;
    const dashSpace = 4.0;
    const totalDashSpace = dashWidth + dashSpace;

    final circumference = 2 * 3.14159 * radius;
    final dashCount = (circumference / totalDashSpace).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * totalDashSpace / radius);
      final sweepAngle = dashWidth / radius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
