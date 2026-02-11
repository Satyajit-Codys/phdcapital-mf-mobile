import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_search_box.dart';
import 'all_mutual_funds_controller.dart';

class AllMutualFundsScreen extends StatelessWidget {
  AllMutualFundsScreen({super.key});

  final controller = Get.put(AllMutualFundsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and filter
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered Title
                  Center(
                    child: Text(
                      "All Mutual Funds",
                      style: AppTextStyles.h3SemiBold,
                    ),
                  ),

                  // Right Side Filter
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: AppIcons.filterIcon(
                            size: 18,
                            color: AppColors.grey950,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Box
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: AppSearchBox(
                hint: "Search mutual funds",
                controller: controller.searchController,
                onChanged: controller.onSearchChanged,
              ),
            ),

            Divider(height: 1, thickness: 4, color: AppColors.grey50),

            SizedBox(height: 12),

            // Content
            Expanded(
              child: Obx(() {
                if (controller.isSearching.value) {
                  return _buildSearchResults();
                }
                return _buildDefaultView();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fund Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Fund Categories", style: AppTextStyles.h5SemiBold),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _categoryCard(
                    "Large Cap",
                    "Stable large companies",
                    "120 Funds",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    "Mid Cap",
                    "Growing businesses",
                    "120 Funds",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _categoryCard(
                    "Small Cap",
                    "High growth potential",
                    "60 Funds",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _categoryCard(
                    "Debt Funds",
                    "Low risk income",
                    "40 Funds",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Divider(height: 1, thickness: 4, color: AppColors.grey50),
          const SizedBox(height: 12),

          // Explore Mutual Funds
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Explore Mutual Funds",
              style: AppTextStyles.h5SemiBold,
            ),
          ),
          const SizedBox(height: 16),

          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.allFunds.length,
              // separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final fund = controller.allFunds[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _fundCard(fund),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.filteredFunds.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: AppColors.grey300),
              const SizedBox(height: 16),
              Text(
                "No funds found",
                style: AppTextStyles.body3SemiBold.copyWith(
                  color: AppColors.grey400,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Try searching with different keywords",
                style: AppTextStyles.body5Regular.copyWith(
                  color: AppColors.grey400,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        itemCount: controller.filteredFunds.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final fund = controller.filteredFunds[index];
          return _fundCard(fund);
        },
      );
    });
  }

  Widget _categoryCard(String title, String subtitle, String fundCount) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.body5Regular.copyWith(
              color: AppColors.grey400,
            ),
          ),
          const SizedBox(height: 8),
          Text(fundCount, style: AppTextStyles.body5SemiBold),
        ],
      ),
    );
  }

  Widget _fundCard(MutualFund fund) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white100,
        border: const Border(
          bottom: BorderSide(color: AppColors.grey50, width: 1),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fund Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: fund.iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    fund.name[0],
                    style: AppTextStyles.h5SemiBold.copyWith(
                      color: AppColors.white100,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Fund Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fund.name, style: AppTextStyles.body3SemiBold),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          fund.category,
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey300,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          fund.risk,
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Returns
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${fund.returns}%",
                    style: AppTextStyles.body3SemiBold.copyWith(
                      color: AppColors.green500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "3Y Returns",
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // NAV and View Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NAV",
                style: AppTextStyles.body5Regular.copyWith(
                  color: AppColors.grey400,
                ),
              ),
              const SizedBox(height: 2),
              Text("₹${fund.nav}", style: AppTextStyles.body4SemiBold),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "As of ${fund.date}",
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "View Details",
                            style: AppTextStyles.body5SemiBold.copyWith(
                              color: AppColors.primary500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppColors.primary500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
