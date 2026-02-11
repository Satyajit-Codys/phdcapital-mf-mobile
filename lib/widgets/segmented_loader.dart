// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/widgets.dart';

class SegmentedLoader extends StatefulWidget {
  final double size;
  final Color color;

  const SegmentedLoader({super.key, this.size = 28, required this.color});

  @override
  State<SegmentedLoader> createState() => _SegmentedLoaderState();
}

class _SegmentedLoaderState extends State<SegmentedLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size.square(widget.size),
        painter: _SegmentedLoaderPainter(widget.color),
      ),
    );
  }
}

class _SegmentedLoaderPainter extends CustomPainter {
  final Color color;

  _SegmentedLoaderPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    for (int i = 0; i < 12; i++) {
      paint.color = color.withOpacity((i + 1) / 12);
      final angle = (i * 30) * 3.1416 / 180;

      final start = Offset(
        center.dx + radius * 0.55 * cos(angle),
        center.dy + radius * 0.55 * sin(angle),
      );

      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
