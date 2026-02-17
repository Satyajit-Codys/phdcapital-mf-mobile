import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_radii.dart';
import '../../../widgets/app_button.dart';

class PauseSipSheet extends StatefulWidget {
  const PauseSipSheet({super.key});

  @override
  State<PauseSipSheet> createState() => _PauseSipSheetState();
}

class _PauseSipSheetState extends State<PauseSipSheet> {
  String? selectedReason;
  DateTime? resumeDate;
  final TextEditingController dateController = TextEditingController();

  final List<String> pauseReasons = [
    'Temporary financial constraint',
    'Market volatility concerns',
    'Planning to increase amount later',
    'Other investment priorities',
    'Personal reasons',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadii.large),
          topRight: Radius.circular(AppRadii.large),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pause SIP', style: AppTextStyles.h3SemiBold),
                            const SizedBox(height: 4),
                            Text(
                              'Temporarily stop or restart your monthly investment',
                              style: AppTextStyles.body5Regular.copyWith(
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                      ),
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

                  // Reason for pausing SIP
                  Text(
                    'Reason for pausing SIP',
                    style: AppTextStyles.body5SemiBold.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey100),
                      borderRadius: BorderRadius.circular(AppRadii.medium),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedReason,
                        hint: Text(
                          'Select reason',
                          style: AppTextStyles.inputText.copyWith(
                            color: AppColors.grey300,
                          ),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.grey400,
                        ),
                        items: pauseReasons.map((String reason) {
                          return DropdownMenuItem<String>(
                            value: reason,
                            child: Text(reason, style: AppTextStyles.inputText),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedReason = newValue;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'Helps us improve your investment experience',
                    style: AppTextStyles.caption2.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Select resume date
                  Text(
                    'Select resume date',
                    style: AppTextStyles.body5SemiBold.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey100),
                        borderRadius: BorderRadius.circular(AppRadii.medium),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateController.text.isEmpty
                                ? 'dd-mm-yyyy'
                                : dateController.text,
                            style: AppTextStyles.inputText.copyWith(
                              color: dateController.text.isEmpty
                                  ? AppColors.grey300
                                  : AppColors.black100,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.grey400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'SIP debits will restart from this date',
                    style: AppTextStyles.caption2.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary50.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadii.medium),
                    ),
                    child: Text(
                      'Pausing your SIP will stop upcoming debits until the selected resume date. Your existing invested amount will remain invested and continue to grow.',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Confirm Pause Button
                  AppButton(
                    title: 'Confirm Pause',
                    onPressed: selectedReason != null && resumeDate != null
                        ? () {
                            Get.back();
                            Get.toNamed('/pause-sip-request');
                          }
                        : null,
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        resumeDate = picked;
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
