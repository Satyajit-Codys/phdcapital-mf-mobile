import 'package:flutter/widgets.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';

class RotatingLoader extends StatefulWidget {
  const RotatingLoader({super.key});

  @override
  State<RotatingLoader> createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary50,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            "assets/images/custom_loader.png",
            width: 70,
            height: 70,
          ),
        ),
      ),
    );
  }
}
