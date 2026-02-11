// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';

class PinDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final FocusNode? previousFocus;
  final bool obscure;
  final VoidCallback? onChanged;
  final double? height;
  final double? width;

  const PinDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    this.previousFocus,
    this.obscure = false,
    this.onChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(), // independent key listener
      onKey: (event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          // 🔥 CASE 1: field has value → clear + move back
          if (controller.text.isNotEmpty) {
            controller.clear();
            previousFocus?.requestFocus();
            onChanged?.call();
            return;
          }

          // 🔥 CASE 2: field empty → just move back
          previousFocus?.requestFocus();
        }
      },
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center, // ✅ IMPORTANT
          maxLength: 1,
          obscureText: obscure,
          obscuringCharacter: "*",
          style: AppTextStyles.h4SemiBold,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.zero, // ✅ centers vertically
            enabledBorder: _border(AppColors.grey300),
            focusedBorder: _border(AppColors.primary500),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              nextFocus?.requestFocus();
            }
            onChanged?.call();
          },
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }
}
