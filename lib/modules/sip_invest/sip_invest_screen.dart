import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import 'sip_invest_controller.dart';

class SipInvestScreen extends StatelessWidget {
  SipInvestScreen({super.key});

  final controller = Get.put(SipInvestController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white100,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ================= HEADER =================
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/axis_icon.svg",
                              height: 32,
                              width: 36,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Axis Blue-chip Fund",
                                style: AppTextStyles.body3SemiBold,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.grey50,
                                ),
                                child: const Icon(Icons.close, size: 24),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// ================= INVESTMENT TYPE TOGGLE =================
                        Obx(
                          () => Center(
                            child: Container(
                              width: 233,
                              decoration: BoxDecoration(
                                color: AppColors.primary50,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .selectInvestmentType('SIP'),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.investmentType.value ==
                                                  'SIP'
                                              ? AppColors.white100
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "SIP",
                                            style: AppTextStyles.body4SemiBold
                                                .copyWith(
                                                  color:
                                                      controller
                                                              .investmentType
                                                              .value ==
                                                          'SIP'
                                                      ? AppColors.grey900
                                                      : AppColors.grey400,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .selectInvestmentType('One-Time'),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.investmentType.value ==
                                                  'One-Time'
                                              ? AppColors.white100
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "One-Time",
                                            style: AppTextStyles.body4SemiBold
                                                .copyWith(
                                                  color:
                                                      controller
                                                              .investmentType
                                                              .value ==
                                                          'One-Time'
                                                      ? AppColors.grey900
                                                      : AppColors.grey400,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= AMOUNT =================
                        Text(
                          "Amount",
                          style: AppTextStyles.body4Regular.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyles.h1SemiBold,
                          cursorColor: AppColors.primary500,
                          decoration: InputDecoration(
                            prefixText: "₹",
                            prefixStyle: AppTextStyles.h1SemiBold,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= QUICK AMOUNT BUTTONS =================
                        Obx(
                          () => Row(
                            children:
                                (controller.investmentType.value == 'SIP'
                                        ? controller.quickAmounts
                                        : controller.onetimeQuickAmounts)
                                    .map((amount) {
                                      final isPopular =
                                          controller.investmentType.value ==
                                              'SIP'
                                          ? amount == 2500
                                          : amount == 15000;
                                      return Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: GestureDetector(
                                            onTap: () => controller
                                                .selectQuickAmount(amount),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.grey50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "₹${amount ~/ 1000},${(amount % 1000).toString().padLeft(3, '0')}",
                                                      style: AppTextStyles
                                                          .body5SemiBold,
                                                    ),
                                                  ),
                                                ),
                                                if (isPopular)
                                                  Positioned(
                                                    top: -8,
                                                    right: 0,
                                                    left: 0,
                                                    child: Center(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 2,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primary500,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "Popular",
                                                          style: AppTextStyles
                                                              .body5Regular
                                                              .copyWith(
                                                                color: AppColors
                                                                    .white100,
                                                                fontSize: 10,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= FREQUENCY & SIP DATE =================
                        Obx(
                          () => controller.investmentType.value == 'SIP'
                              ? Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.grey50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Frequency",
                                                  style: AppTextStyles
                                                      .body5Regular
                                                      .copyWith(
                                                        color:
                                                            AppColors.grey400,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "Monthly",
                                                  style: AppTextStyles
                                                      .body3SemiBold,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: AppColors.grey200,
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "SIP Date",
                                                  style: AppTextStyles
                                                      .body5Regular
                                                      .copyWith(
                                                        color:
                                                            AppColors.grey400,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Obx(
                                                  () => GestureDetector(
                                                    onTap: () => controller
                                                        .selectSipDate(context),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "${controller.sipDate.value}th",
                                                          style: AppTextStyles
                                                              .body3SemiBold,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 20,
                                                          color:
                                                              AppColors.grey700,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    /// ================= SIP PAYMENT INFO =================
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "1st SIP Payment",
                                              style: AppTextStyles.body5Regular
                                                  .copyWith(
                                                    color: AppColors.grey400,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Today",
                                              style:
                                                  AppTextStyles.body3SemiBold,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Next SIP",
                                              style: AppTextStyles.body5Regular
                                                  .copyWith(
                                                    color: AppColors.grey400,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              controller.nextSipDate,
                                              style:
                                                  AppTextStyles.body3SemiBold,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                )
                              : const SizedBox(height: 24),
                        ),

                        /// ================= RETURNS INFO =================
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/returns_icon.svg",
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "₹${controller.estimatedReturns.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                              style: AppTextStyles.body3SemiBold
                                                  .copyWith(
                                                    color: AppColors.green500,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: " in 3 years ",
                                              style: AppTextStyles.body4Regular,
                                            ),
                                            TextSpan(
                                              text: "(+27.7% p.a)",
                                              style: AppTextStyles.body5Regular
                                                  .copyWith(
                                                    color: AppColors.grey400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Returns are based on past 3-years performance.",
                                        style: AppTextStyles.body5Regular
                                            .copyWith(
                                              color: AppColors.grey400,
                                              fontSize: 11,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// ================= WITHDRAW INFO =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/withdraw_icon.svg",
                              height: 16,
                              width: 16,
                            ),
                            const SizedBox(width: 8),
                            Obx(
                              () => Text(
                                controller.investmentType.value == "SIP"
                                    ? "Withdraw or Cancel anytime"
                                    : "Winthdraw anytime",
                                style: AppTextStyles.body5Regular.copyWith(
                                  color: AppColors.grey400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// ================= PAYMENT METHOD =================
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),

              /// ================= BOTTOM CTA =================
              Obx(
                () => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  child: Column(
                    children: [
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
                      SizedBox(height: 12),
                      AppButton(
                        title:
                            "Pay ₹${controller.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                        variant: AppButtonVariant.fill,
                        state: AppButtonState.enabled,
                        onPressed: () {
                          Get.toNamed(
                            Routes.payment,
                            arguments: {
                              'amount': controller.totalAmount,
                              'fundName': 'Axis Blue-chip Fund',
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
