import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_checkbox.dart';

class RedeemSipScreen extends StatefulWidget {
  const RedeemSipScreen({super.key});

  @override
  State<RedeemSipScreen> createState() => _RedeemSipScreenState();
}

class _RedeemSipScreenState extends State<RedeemSipScreen> {
  final TextEditingController amountController = TextEditingController();
  bool redeemAll = false;

  final double totalBalance = 9500.0;
  final double exitLoadAmount = 2100.0;
  final double amountWithoutExitLoad = 7400.0;

  @override
  void initState() {
    super.initState();
    amountController.addListener(_onAmountChanged);
  }

  void _onAmountChanged() {
    setState(() {});
  }

  void _toggleRedeemAll(bool value) {
    setState(() {
      redeemAll = value;
      if (value) {
        amountController.text = totalBalance.toStringAsFixed(0);
      } else {
        amountController.clear();
      }
    });
  }

  void _avoidExitLoad() {
    setState(() {
      redeemAll = false;
      amountController.text = amountWithoutExitLoad.toStringAsFixed(0);
    });
  }

  double _getExitLoad() {
    final amount = double.tryParse(amountController.text) ?? 0;
    if (amount > amountWithoutExitLoad) {
      return exitLoadAmount;
    }
    return 0;
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔹 CENTER TITLE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Redeem Parag Parikh Flexi Cap Funds',
                style: AppTextStyles.h6SemiBold,
              ),
              Text(
                '₹${totalBalance.toStringAsFixed(0)} Balance available',
                style: AppTextStyles.caption2.copyWith(
                  color: AppColors.grey400,
                ),
              ),
            ],
          ),

          /// 🔹 LEFT BACK BUTTON
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasAmount = amountController.text.isNotEmpty;
    final exitLoad = _getExitLoad();

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
                    // Amount Label
                    Text(
                      'Amount',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Amount Input
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.h1Bold.copyWith(fontSize: 40),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _MaxValueInputFormatter(totalBalance.toInt()),
                      ],
                      decoration: InputDecoration(
                        hintText: '₹0',
                        hintStyle: AppTextStyles.h1Bold.copyWith(
                          fontSize: 40,
                          color: AppColors.grey300,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        prefixText: hasAmount ? '₹' : '',
                        prefixStyle: AppTextStyles.h1Bold.copyWith(
                          fontSize: 40,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            final amount = double.tryParse(value) ?? 0;
                            redeemAll = amount == totalBalance;
                          } else {
                            redeemAll = false;
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // Redeem All Checkbox
                    GestureDetector(
                      onTap: () => _toggleRedeemAll(!redeemAll),
                      child: Row(
                        children: [
                          AppCheckbox(
                            value: redeemAll,
                            onChanged: _toggleRedeemAll,
                          ),
                          const SizedBox(width: 12),
                          Text('Redeem All', style: AppTextStyles.h5SemiBold),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Exit Load Info
                    if (exitLoad > 0)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              size: 16,
                              color: AppColors.grey600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₹${exitLoad.toStringAsFixed(0)} exit load applies',
                            style: AppTextStyles.body5Regular.copyWith(
                              color: AppColors.grey600,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _avoidExitLoad,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Avoid exit load',
                              style: AppTextStyles.body5SemiBold.copyWith(
                                color: AppColors.primary500,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Payment Method
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "P",
                            style: AppTextStyles.body4SemiBold.copyWith(
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("Paytm", style: AppTextStyles.body4Regular),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.grey400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Y",
                            style: AppTextStyles.body4SemiBold.copyWith(
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Yes bank....9028",
                        style: AppTextStyles.body4Regular,
                      ),
                      const Spacer(),
                      Text(
                        "Change",
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary500,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Proceed Button
                  AppButton(
                    title: 'Proceed',
                    onPressed: hasAmount
                        ? () {
                            final amount =
                                double.tryParse(amountController.text) ?? 0;
                            Get.toNamed('/redeem-request', arguments: amount);
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}

// Custom input formatter to limit max value
class _MaxValueInputFormatter extends TextInputFormatter {
  final int maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    if (value > maxValue) {
      return oldValue;
    }

    return newValue;
  }
}
