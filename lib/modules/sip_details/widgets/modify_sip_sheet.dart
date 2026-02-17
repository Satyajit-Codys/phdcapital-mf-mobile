import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_radii.dart';
import '../../../widgets/app_button.dart';
import '../../sip/sip_controller.dart';

class ModifySipSheet extends StatefulWidget {
  final SipInvestment sip;

  const ModifySipSheet({super.key, required this.sip});

  @override
  State<ModifySipSheet> createState() => _ModifySipSheetState();
}

class _ModifySipSheetState extends State<ModifySipSheet> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  late double originalAmount;
  late DateTime originalDate;

  @override
  void initState() {
    super.initState();
    originalAmount = widget.sip.amount;
    originalDate = DateTime.now();

    amountController.text = widget.sip.amount.toStringAsFixed(0);
    amountController.addListener(_checkForChanges);
  }

  bool _hasChanges() {
    final currentAmount =
        double.tryParse(amountController.text) ?? originalAmount;
    final amountChanged = currentAmount != originalAmount;
    final dateChanged = selectedDate != null;
    return amountChanged || dateChanged;
  }

  void _checkForChanges() {
    setState(() {});
  }

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
                            Text('Modify SIP', style: AppTextStyles.h3SemiBold),
                            const SizedBox(height: 4),
                            Text(
                              'Update your monthly investment details.',
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

                  // New SIP Amount
                  Text(
                    'New SIP Amount (₹)',
                    style: AppTextStyles.body5SemiBold.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.inputText,
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      hintStyle: AppTextStyles.inputText.copyWith(
                        color: AppColors.grey300,
                      ),
                      prefixText: '₹',
                      prefixStyle: AppTextStyles.inputText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.medium),
                        borderSide: const BorderSide(color: AppColors.grey100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.medium),
                        borderSide: const BorderSide(color: AppColors.grey100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.medium),
                        borderSide: const BorderSide(
                          color: AppColors.primary500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'New amount will apply from the next debit cycle',
                    style: AppTextStyles.caption2.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Change Debit Date
                  Text(
                    'Change Debit Date',
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
                    'You can choose any available debit date in the month',
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
                      'Changes will not affect your past investments and will begin from the next scheduled SIP',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Save Changes Button
                  AppButton(
                    title: 'Save Changes',
                    onPressed: _hasChanges()
                        ? () {
                            Get.back();
                            Get.snackbar(
                              'Success',
                              'SIP modified successfully',
                              backgroundColor: AppColors.green50,
                              colorText: AppColors.green600,
                            );
                          }
                        : null,
                  ),
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
