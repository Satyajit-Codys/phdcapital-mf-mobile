import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_button_enum.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_radii.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_checkbox.dart';

class CancelSipSheet extends StatefulWidget {
  const CancelSipSheet({super.key});

  @override
  State<CancelSipSheet> createState() => _CancelSipSheetState();
}

class _CancelSipSheetState extends State<CancelSipSheet> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadii.large),
          topRight: Radius.circular(AppRadii.large),
        ),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cancel SIP', style: AppTextStyles.h3SemiBold),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.grey600,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Warning Message
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.red50,
              borderRadius: BorderRadius.circular(AppRadii.medium),
            ),
            child: Text(
              'Future SIP payments will stop, but your invested amount will remain in the fund.',
              style: AppTextStyles.body4Regular.copyWith(
                color: AppColors.grey700,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Confirmation Checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCheckbox(
                value: isConfirmed,
                onChanged: (value) {
                  setState(() {
                    isConfirmed = value;
                  });
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'I understand and want to cancel.',
                  style: AppTextStyles.body4Regular.copyWith(
                    color: AppColors.grey700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Confirm Cancellation Button
          AppButton(
            variant: AppButtonVariant.cancel,
            title: 'Confirm Cancellation',
            onPressed: isConfirmed
                ? () {
                    Get.back();
                    Get.snackbar(
                      'SIP Cancelled',
                      'Your SIP has been cancelled successfully',
                      backgroundColor: AppColors.red50,
                      colorText: AppColors.red600,
                    );
                  }
                : null,
          ),

          const SizedBox(height: 16),

          // Keep SIP Active Button
          Center(
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Keep SIP Active',
                style: AppTextStyles.h5SemiBold.copyWith(
                  color: AppColors.grey700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
