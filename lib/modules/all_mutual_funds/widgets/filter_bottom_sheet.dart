import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/enums/app_button_enum.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_checkbox.dart';
import '../all_mutual_funds_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllMutualFundsController>();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.isAdvancedFilter.value
                        ? "Advanced Filter"
                        : "Filter Funds",
                    style: AppTextStyles.h4SemiBold,
                  ),
                  if (controller.isAdvancedFilter.value)
                    InkWell(
                      onTap: controller.toggleAdvancedFilter,
                      child: Text(
                        "Back to Filter",
                        style: AppTextStyles.body4SemiBold.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.grey700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Content with left panel
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Panel
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                    // color: AppColors.grey50,
                    border: Border(
                      right: BorderSide(color: AppColors.grey100, width: 1),
                    ),
                  ),
                  child: Obx(
                    () => ListView(
                      children: controller.isAdvancedFilter.value
                          ? [
                              _buildLeftMenuItem(
                                controller,
                                'Fund House',
                                Icons.business,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'Fund Manager',
                                Icons.person,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'AUM',
                                Icons.account_balance_wallet,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'Expense Ratio',
                                Icons.percent,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'Ratings',
                                Icons.star,
                              ),
                            ]
                          : [
                              _buildLeftMenuItem(
                                controller,
                                'Category',
                                Icons.grid_view_rounded,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'AMC',
                                Icons.account_balance,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'Risk Level',
                                Icons.trending_up,
                              ),
                              _buildLeftMenuItem(
                                controller,
                                'Return Range',
                                Icons.refresh,
                              ),
                              // Advanced Filter button
                              InkWell(
                                onTap: controller.toggleAdvancedFilter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.tune,
                                        size: 24,
                                        color: AppColors.grey400,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Advanced Filter',
                                        style: AppTextStyles.body5Regular
                                            .copyWith(color: AppColors.grey600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),

                // Right Content
                Expanded(child: Obx(() => _buildRightContent(controller))),
              ],
            ),
          ),

          // Bottom buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white100,
              // border: Border(
              //   top: BorderSide(color: AppColors.grey100, width: 1),
              // ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: "Clear Filter",
                    variant: AppButtonVariant.text,
                    state: AppButtonState.enabled,
                    onPressed: controller.clearFilters,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    title: "Apply",
                    variant: AppButtonVariant.fill,
                    state: AppButtonState.enabled,
                    onPressed: controller.applyFilters,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftMenuItem(
    AllMutualFundsController controller,
    String title,
    IconData icon,
  ) {
    final isSelected = controller.selectedFilterSection.value == title;

    return InkWell(
      onTap: () => controller.selectFilterSection(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        // decoration: BoxDecoration(
        //   color: isSelected ? AppColors.primary50 : Colors.transparent,
        //   border: Border(
        //     left: BorderSide(
        //       color: isSelected ? AppColors.primary500 : Colors.transparent,
        //       width: 3,
        //     ),
        //   ),
        // ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary500 : AppColors.grey400,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyles.body5Regular.copyWith(
                color: isSelected ? AppColors.primary500 : AppColors.grey600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightContent(AllMutualFundsController controller) {
    switch (controller.selectedFilterSection.value) {
      case 'Category':
        return _buildCategoryContent(controller);
      case 'AMC':
        return _buildAMCContent(controller);
      case 'Risk Level':
        return _buildRiskLevelContent(controller);
      case 'Return Range':
        return _buildReturnRangeContent(controller);
      case 'Fund House':
        return _buildFundHouseContent(controller);
      case 'Fund Manager':
        return _buildFundManagerContent(controller);
      case 'AUM':
        return _buildAUMContent(controller);
      case 'Expense Ratio':
        return _buildExpenseRatioContent(controller);
      case 'Ratings':
        return _buildRatingsContent(controller);
      default:
        return _buildCategoryContent(controller);
    }
  }

  Widget _buildCategoryContent(AllMutualFundsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          children: controller.categorySubItems.keys.map((category) {
            return _buildCategorySection(controller, category);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAMCContent(AllMutualFundsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          children: controller.amcList.map((amc) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => controller.toggleAMC(amc),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  // decoration: BoxDecoration(
                  //   color: controller.isAMCSelected(amc)
                  //       ? AppColors.primary50
                  //       : AppColors.white100,
                  //   borderRadius: BorderRadius.circular(12),
                  //   border: Border.all(
                  //     color: controller.isAMCSelected(amc)
                  //         ? AppColors.primary500
                  //         : AppColors.grey100,
                  //   ),
                  // ),
                  child: Row(
                    children: [
                      AppCheckbox(
                        value: controller.isAMCSelected(amc),
                        onChanged: (value) => controller.toggleAMC(amc),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          amc,
                          style: AppTextStyles.body3SemiBold.copyWith(
                            color: controller.isAMCSelected(amc)
                                ? AppColors.primary500
                                : AppColors.grey900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRiskLevelContent(AllMutualFundsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          children: controller.riskLevels.map((risk) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => controller.toggleRiskLevel(risk),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  // decoration: BoxDecoration(
                  //   color: controller.isRiskLevelSelected(risk)
                  //       ? AppColors.primary50
                  //       : AppColors.white100,
                  //   borderRadius: BorderRadius.circular(12),
                  //   border: Border.all(
                  //     color: controller.isRiskLevelSelected(risk)
                  //         ? AppColors.primary500
                  //         : AppColors.grey100,
                  //   ),
                  // ),
                  child: Row(
                    children: [
                      AppCheckbox(
                        value: controller.isRiskLevelSelected(risk),
                        onChanged: (value) => controller.toggleRiskLevel(risk),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          risk,
                          style: AppTextStyles.body3Regular.copyWith(
                            color: controller.isRiskLevelSelected(risk)
                                ? AppColors.primary500
                                : AppColors.grey900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReturnRangeContent(AllMutualFundsController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Return Range", style: AppTextStyles.body3SemiBold),
            const SizedBox(height: 16),

            // Range Slider
            RangeSlider(
              values: RangeValues(
                controller.returnRangeStart.value,
                controller.returnRangeEnd.value,
              ),
              min: 0,
              max: 50,
              divisions: 50,
              activeColor: AppColors.primary500,
              inactiveColor: AppColors.grey200,
              labels: RangeLabels(
                '${controller.returnRangeStart.value.toStringAsFixed(1)}%',
                '${controller.returnRangeEnd.value.toStringAsFixed(1)}%',
              ),
              onChanged: (RangeValues values) {
                controller.updateReturnRange(values.start, values.end);
              },
            ),

            // Display range values
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.returnRangeStart.value.toStringAsFixed(1)}%',
                    style: AppTextStyles.body4SemiBold.copyWith(
                      color: AppColors.primary500,
                    ),
                  ),
                  Text(
                    '${controller.returnRangeEnd.value.toStringAsFixed(1)}%',
                    style: AppTextStyles.body4SemiBold.copyWith(
                      color: AppColors.primary500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text("Custom Range", style: AppTextStyles.body3SemiBold),
            const SizedBox(height: 12),

            // Custom input fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.returnRangeStartController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}'),
                      ),
                    ],
                    style: AppTextStyles.body3Regular,
                    decoration: InputDecoration(
                      hintText: "Min %",
                      hintStyle: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                      filled: true,
                      fillColor: AppColors.grey50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary500),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    onChanged: (value) {
                      controller.updateReturnRangeFromInput();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "to",
                  style: AppTextStyles.body4Regular.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller.returnRangeEndController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}'),
                      ),
                    ],
                    style: AppTextStyles.body3Regular,
                    decoration: InputDecoration(
                      hintText: "Max %",
                      hintStyle: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                      filled: true,
                      fillColor: AppColors.grey50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.grey100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary500),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    onChanged: (value) {
                      controller.updateReturnRangeFromInput();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    AllMutualFundsController controller,
    String category,
  ) {
    return Obx(() {
      final isExpanded = controller.isCategoryExpanded(category);

      return Column(
        children: [
          // Parent category
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            // decoration: BoxDecoration(
            //   color: controller.isParentSelected(category)
            //       ? AppColors.primary50
            //       : AppColors.white100,
            //   borderRadius: BorderRadius.circular(12),
            //   border: Border.all(
            //     color: controller.isParentSelected(category)
            //         ? AppColors.primary500
            //         : AppColors.grey100,
            //   ),
            // ),
            child: Row(
              children: [
                // Checkbox
                AppCheckbox(
                  value: controller.isParentSelected(category),
                  onChanged: (value) =>
                      controller.toggleParentCategory(category),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category,
                    style: AppTextStyles.body3Regular.copyWith(
                      color: controller.isRiskLevelSelected(category)
                          ? AppColors.primary500
                          : AppColors.grey900,
                    ),
                  ),
                ),
                // Expand/Collapse arrow
                InkWell(
                  onTap: () => controller.toggleCategoryExpansion(category),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.grey400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Subcategories
          if (isExpanded) ...[
            const SizedBox(height: 8),
            ...controller.categorySubItems[category]!.map((subItem) {
              return Padding(
                padding: const EdgeInsets.only(left: 32, bottom: 8),
                child: InkWell(
                  onTap: () => controller.toggleSubCategory(category, subItem),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    // decoration: BoxDecoration(
                    //   color: controller.isSubCategorySelected(category, subItem)
                    //       ? AppColors.primary50
                    //       : AppColors.grey50,
                    //   borderRadius: BorderRadius.circular(8),
                    //   border: Border.all(
                    //     color:
                    //         controller.isSubCategorySelected(category, subItem)
                    //         ? AppColors.primary500
                    //         : AppColors.grey100,
                    //   ),
                    // ),
                    child: Row(
                      children: [
                        // Checkbox
                        AppCheckbox(
                          value: controller.isSubCategorySelected(
                            category,
                            subItem,
                          ),
                          onChanged: (value) =>
                              controller.toggleSubCategory(category, subItem),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            subItem,
                            style: AppTextStyles.body4Regular.copyWith(
                              color:
                                  controller.isSubCategorySelected(
                                    category,
                                    subItem,
                                  )
                                  ? AppColors.primary500
                                  : AppColors.grey700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],

          const SizedBox(height: 12),
        ],
      );
    });
  }
}

// Advanced Filter Content Methods
Widget _buildFundHouseContent(AllMutualFundsController controller) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Obx(
      () => Column(
        children: controller.fundHouseList.map((fundHouse) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => controller.toggleFundHouse(fundHouse),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                // decoration: BoxDecoration(
                //   color: controller.isFundHouseSelected(fundHouse)
                //       ? AppColors.primary50
                //       : AppColors.white100,
                //   borderRadius: BorderRadius.circular(12),
                //   border: Border.all(
                //     color: controller.isFundHouseSelected(fundHouse)
                //         ? AppColors.primary500
                //         : AppColors.grey100,
                //   ),
                // ),
                child: Row(
                  children: [
                    AppCheckbox(
                      value: controller.isFundHouseSelected(fundHouse),
                      onChanged: (value) =>
                          controller.toggleFundHouse(fundHouse),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        fundHouse,
                        style: AppTextStyles.body4Regular.copyWith(
                          color: controller.isFundHouseSelected(fundHouse)
                              ? AppColors.primary500
                              : AppColors.grey900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildFundManagerContent(AllMutualFundsController controller) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Obx(
      () => Column(
        children: controller.fundManagerList.map((manager) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => controller.toggleFundManager(manager),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                // decoration: BoxDecoration(
                //   color: controller.isFundManagerSelected(manager)
                //       ? AppColors.primary50
                //       : AppColors.white100,
                //   borderRadius: BorderRadius.circular(12),
                //   border: Border.all(
                //     color: controller.isFundManagerSelected(manager)
                //         ? AppColors.primary500
                //         : AppColors.grey100,
                //   ),
                // ),
                child: Row(
                  children: [
                    AppCheckbox(
                      value: controller.isFundManagerSelected(manager),
                      onChanged: (value) =>
                          controller.toggleFundManager(manager),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        manager,
                        style: AppTextStyles.body4Regular.copyWith(
                          color: controller.isFundManagerSelected(manager)
                              ? AppColors.primary500
                              : AppColors.grey900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildAUMContent(AllMutualFundsController controller) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AUM Range (in Crores)", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 16),

          // Range Slider
          RangeSlider(
            values: RangeValues(
              controller.aumRangeStart.value,
              controller.aumRangeEnd.value,
            ),
            min: 0,
            max: 50000,
            divisions: 500,
            activeColor: AppColors.primary500,
            inactiveColor: AppColors.grey200,
            labels: RangeLabels(
              '₹${controller.aumRangeStart.value.toStringAsFixed(0)}',
              '₹${controller.aumRangeEnd.value.toStringAsFixed(0)}',
            ),
            onChanged: (RangeValues values) {
              controller.updateAUMRange(values.start, values.end);
            },
          ),

          // Display range values
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${controller.aumRangeStart.value.toStringAsFixed(0)} Cr',
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
                Text(
                  '₹${controller.aumRangeEnd.value.toStringAsFixed(0)} Cr',
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text("Custom Range", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 12),

          // Custom input fields
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.aumRangeStartController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: AppTextStyles.body3Regular,
                  decoration: InputDecoration(
                    hintText: "Min (Cr)",
                    hintStyle: AppTextStyles.body4Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                    filled: true,
                    fillColor: AppColors.grey50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primary500),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    controller.updateAUMRangeFromInput();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "to",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller.aumRangeEndController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: AppTextStyles.body3Regular,
                  decoration: InputDecoration(
                    hintText: "Max (Cr)",
                    hintStyle: AppTextStyles.body4Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                    filled: true,
                    fillColor: AppColors.grey50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primary500),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    controller.updateAUMRangeFromInput();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildExpenseRatioContent(AllMutualFundsController controller) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Expense Ratio Range (%)", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 16),

          // Range Slider
          RangeSlider(
            values: RangeValues(
              controller.expenseRatioStart.value,
              controller.expenseRatioEnd.value,
            ),
            min: 0,
            max: 3,
            divisions: 30,
            activeColor: AppColors.primary500,
            inactiveColor: AppColors.grey200,
            labels: RangeLabels(
              '${controller.expenseRatioStart.value.toStringAsFixed(2)}%',
              '${controller.expenseRatioEnd.value.toStringAsFixed(2)}%',
            ),
            onChanged: (RangeValues values) {
              controller.updateExpenseRatioRange(values.start, values.end);
            },
          ),

          // Display range values
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.expenseRatioStart.value.toStringAsFixed(2)}%',
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
                Text(
                  '${controller.expenseRatioEnd.value.toStringAsFixed(2)}%',
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text("Custom Range", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 12),

          // Custom input fields
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.expenseRatioStartController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  style: AppTextStyles.body3Regular,
                  decoration: InputDecoration(
                    hintText: "Min %",
                    hintStyle: AppTextStyles.body4Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                    filled: true,
                    fillColor: AppColors.grey50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primary500),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    controller.updateExpenseRatioFromInput();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "to",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller.expenseRatioEndController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  style: AppTextStyles.body3Regular,
                  decoration: InputDecoration(
                    hintText: "Max %",
                    hintStyle: AppTextStyles.body4Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                    filled: true,
                    fillColor: AppColors.grey50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.grey100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primary500),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    controller.updateExpenseRatioFromInput();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildRatingsContent(AllMutualFundsController controller) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Obx(
      () => Column(
        children: controller.ratingsList.map((rating) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => controller.toggleRating(rating),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                // decoration: BoxDecoration(
                //   color: controller.isRatingSelected(rating)
                //       ? AppColors.primary50
                //       : AppColors.white100,
                //   borderRadius: BorderRadius.circular(12),
                //   border: Border.all(
                //     color: controller.isRatingSelected(rating)
                //         ? AppColors.primary500
                //         : AppColors.grey100,
                //   ),
                // ),
                child: Row(
                  children: [
                    AppCheckbox(
                      value: controller.isRatingSelected(rating),
                      onChanged: (value) => controller.toggleRating(rating),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          ...List.generate(
                            rating,
                            (index) => Icon(
                              Icons.star,
                              size: 20,
                              color: controller.isRatingSelected(rating)
                                  ? AppColors.primary500
                                  : AppColors.orange500,
                            ),
                          ),
                          ...List.generate(
                            5 - rating,
                            (index) => Icon(
                              Icons.star_border,
                              size: 20,
                              color: AppColors.grey300,
                            ),
                          ),
                          // const SizedBox(width: 8),
                          // Text(
                          //   '$rating Star${rating > 1 ? 's' : ''}',
                          //   style: AppTextStyles.body4Regular.copyWith(
                          //     color: controller.isRatingSelected(rating)
                          //         ? AppColors.primary500
                          //         : AppColors.grey900,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
