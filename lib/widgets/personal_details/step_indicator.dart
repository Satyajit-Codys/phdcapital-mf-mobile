import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class StepIndicator extends StatelessWidget {
  final int current;
  final int total;

  const StepIndicator({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary500 : AppColors.grey200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
