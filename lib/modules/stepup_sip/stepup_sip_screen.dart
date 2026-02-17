import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_radii.dart';
import '../../widgets/app_button.dart';

class StepupSipScreen extends StatefulWidget {
  const StepupSipScreen({super.key});

  @override
  State<StepupSipScreen> createState() => _StepupSipScreenState();
}

class _StepupSipScreenState extends State<StepupSipScreen> {
  final TextEditingController increaseController = TextEditingController(
    text: '100',
  );
  String increaseType = 'Amount'; // Amount or Percentage
  String frequency = '1Y'; // 1Y or 6M
  double currentSipAmount =
      5000.0; // Default, will be overridden from arguments

  @override
  void initState() {
    super.initState();
    // Get current SIP amount from arguments if available
    if (Get.arguments != null && Get.arguments is double) {
      currentSipAmount = Get.arguments as double;
    }
    increaseController.addListener(_onIncreaseChanged);
  }

  void _onIncreaseChanged() {
    setState(() {});
  }

  double _calculateIncreasedAmount() {
    final increaseValue = double.tryParse(increaseController.text) ?? 0;

    if (increaseType == 'Amount') {
      return currentSipAmount + increaseValue;
    } else {
      // Percentage
      return currentSipAmount + (currentSipAmount * increaseValue / 100);
    }
  }

  String _getNextIncreaseDate() {
    final now = DateTime.now();
    DateTime nextDate;

    if (frequency == '1Y') {
      nextDate = DateTime(now.year + 1, now.month, now.day);
    } else {
      // Add 6 months properly
      int newMonth = now.month + 6;
      int newYear = now.year;
      if (newMonth > 12) {
        newMonth = newMonth - 12;
        newYear = newYear + 1;
      }
      nextDate = DateTime(newYear, newMonth, now.day);
    }

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[nextDate.month - 1]} \'${nextDate.year.toString().substring(2)}';
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 BACK BUTTON
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AppIcons.arrowLeftIcon(
                  size: 18,
                  color: AppColors.black100,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12), // 👈 spacing between button & text
          /// 🔹 TITLE COLUMN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Step-up SIP', style: AppTextStyles.h5SemiBold),
                Text(
                  'Axis Midcap Direct Plan Growth',
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.grey400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final increasedAmount = _calculateIncreasedAmount();
    final nextDate = _getNextIncreaseDate();

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current SIP Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current SIP Amount',
                          style: AppTextStyles.body4Regular.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                        Text(
                          '₹${currentSipAmount.toStringAsFixed(0)}',
                          style: AppTextStyles.h4SemiBold,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Increase by section
                    Row(
                      children: [
                        Text(
                          'Increase by',
                          style: AppTextStyles.body4Regular.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Dropdown for Amount/Percentage
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey100),
                            borderRadius: BorderRadius.circular(
                              AppRadii.medium,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: increaseType,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.grey400,
                              ),
                              items: ['Amount', 'Percentage'].map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyles.body5SemiBold,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  increaseType = newValue!;
                                });
                              },
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Amount Input
                        SizedBox(
                          width: 120,
                          child: TextField(
                            controller: increaseController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.end,
                            style: AppTextStyles.h4SemiBold,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.medium,
                                ),
                                borderSide: const BorderSide(
                                  color: AppColors.grey200,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.medium,
                                ),
                                borderSide: const BorderSide(
                                  color: AppColors.grey200,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.medium,
                                ),
                                borderSide: const BorderSide(
                                  color: AppColors.primary500,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // After every section
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'After every',
                    //       style: AppTextStyles.body4Regular.copyWith(
                    //         color: AppColors.grey600,
                    //       ),
                    //     ),
                    //     Text(
                    //       '₹${increasedAmount.toStringAsFixed(0)}',
                    //       style: AppTextStyles.h4SemiBold,
                    //     ),
                    //   ],
                    // ),

                    // const SizedBox(height: 16),

                    // Frequency Toggle Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary50,
                        borderRadius: BorderRadius.circular(AppRadii.medium),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('After Every', style: AppTextStyles.h6SemiBold),
                          Row(
                            children: [
                              _buildFrequencyButton('6M'),
                              const SizedBox(width: 8),
                              _buildFrequencyButton('1Y'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white100,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black100.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary50.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppRadii.medium),
                    ),
                    child: Text(
                      'SIP amount will increase to ₹${increasedAmount.toStringAsFixed(0)} from $nextDate onwards',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Proceed Button
                  AppButton(
                    title: 'Proceed',
                    onPressed: () {
                      final newAmount = _calculateIncreasedAmount();
                      final effectiveDate = _getNextIncreaseDate();

                      Get.toNamed(
                        '/stepup-sip-request',
                        arguments: {
                          'currentAmount': currentSipAmount,
                          'newAmount': newAmount,
                          'effectiveDate': effectiveDate,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyButton(String freq) {
    final isSelected = frequency == freq;
    return GestureDetector(
      onTap: () {
        setState(() {
          frequency = freq;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary500 : AppColors.white100,
          borderRadius: BorderRadius.circular(AppRadii.large),
          border: Border.all(
            color: isSelected ? AppColors.primary500 : AppColors.grey200,
          ),
        ),
        child: Text(
          freq,
          style: AppTextStyles.body5SemiBold.copyWith(
            color: isSelected ? AppColors.white100 : AppColors.grey600,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    increaseController.dispose();
    super.dispose();
  }
}
