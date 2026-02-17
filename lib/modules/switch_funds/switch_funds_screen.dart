import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_radii.dart';

class SwitchFundsScreen extends StatefulWidget {
  const SwitchFundsScreen({super.key});

  @override
  State<SwitchFundsScreen> createState() => _SwitchFundsScreenState();
}

class _SwitchFundsScreenState extends State<SwitchFundsScreen> {
  final TextEditingController searchController = TextEditingController();
  String currentFundName = 'Parag Parikh Flexi Cap Fund Direct Growth';
  String selectedFund = '';
  List<FundOption> allFunds = [];
  List<FundOption> filteredFunds = [];

  @override
  void initState() {
    super.initState();
    // Get current fund from arguments if available
    if (Get.arguments != null && Get.arguments is String) {
      currentFundName = Get.arguments as String;
    }

    _loadFunds();
    searchController.addListener(_onSearchChanged);
  }

  void _loadFunds() {
    // Mock data - same fund house funds
    allFunds = [
      FundOption(
        name: 'Parag Parikh Flexi Cap Fund Direct Growth',
        subtitle: '',
        returns: '16.7%',
        iconColor: AppColors.red500,
      ),
      FundOption(
        name: 'Parag Parikh Flexi Cap Fund Direct Growth',
        subtitle: '',
        returns: '11.86%',
        iconColor: AppColors.red500,
      ),
      FundOption(
        name: 'Parag Parikh Flexi Cap Fund Direct Growth',
        subtitle: '',
        returns: '6.69%',
        iconColor: AppColors.red500,
      ),
      FundOption(
        name: 'Parag Parikh Flexi Cap Fund Direct Growth',
        subtitle: '',
        returns: 'NA',
        iconColor: AppColors.red500,
      ),
      FundOption(
        name: 'Parag Parikh Flexi Cap Fund Direct Growth',
        subtitle: '',
        returns: 'NA',
        iconColor: AppColors.red500,
      ),
    ];
    filteredFunds = List.from(allFunds);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredFunds = List.from(allFunds);
      } else {
        filteredFunds = allFunds.where((fund) {
          return fund.name.toLowerCase().contains(query) ||
              fund.subtitle.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Switch-out from section
                  Text(
                    'Switch-out from',
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Current Fund Card
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/axis_icon.svg"),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          currentFundName,
                          style: AppTextStyles.h6SemiBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Search Input
                  TextField(
                    controller: searchController,
                    style: AppTextStyles.inputText,
                    decoration: InputDecoration(
                      hintText: 'Switch-in to',
                      hintStyle: AppTextStyles.inputText.copyWith(
                        color: AppColors.grey300,
                      ),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: AppColors.grey400,
                      ),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // All funds by fund house header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All funds by fund house',
                        style: AppTextStyles.h6SemiBold,
                      ),
                      Text(
                        '3Y Returns',
                        style: AppTextStyles.caption2.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.grey100),

            // Fund List
            Expanded(
              child: filteredFunds.isEmpty
                  ? Center(
                      child: Text(
                        'No funds found',
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredFunds.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: AppColors.grey100),
                      itemBuilder: (context, index) {
                        final fund = filteredFunds[index];
                        return _buildFundCard(fund);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔹 CENTER TITLE
          Center(child: Text("Switch Funds", style: AppTextStyles.h4SemiBold)),

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

  Widget _buildFundCard(FundOption fund) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedFund = fund.name;
        });

        // Show confirmation dialog
        _showSwitchConfirmation(fund);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fund Icon
            SvgPicture.asset("assets/icons/axis_icon.svg"),
            const SizedBox(width: 12),

            // Fund Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      fund.name,
                      style: AppTextStyles.h6SemiBold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),

            // Returns
            Text(
              fund.returns,
              style: AppTextStyles.h5SemiBold.copyWith(
                color: fund.returns == 'NA'
                    ? AppColors.grey400
                    : AppColors.black100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSwitchConfirmation(FundOption fund) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Switch Fund?', style: AppTextStyles.h4SemiBold),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From:',
              style: AppTextStyles.caption2.copyWith(color: AppColors.grey400),
            ),
            Text(currentFundName, style: AppTextStyles.body5SemiBold),
            const SizedBox(height: 12),
            Text(
              'To:',
              style: AppTextStyles.caption2.copyWith(color: AppColors.grey400),
            ),
            Text(
              '${fund.name} ${fund.subtitle}',
              style: AppTextStyles.body5SemiBold,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.orange50,
                borderRadius: BorderRadius.circular(AppRadii.small),
              ),
              child: Text(
                'Exit load and tax implications may apply.',
                style: AppTextStyles.caption2.copyWith(
                  color: AppColors.orange600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTextStyles.body5Regular),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.back();
              Get.snackbar(
                'Success',
                'Fund switch request submitted',
                backgroundColor: AppColors.green50,
                colorText: AppColors.green600,
              );
            },
            child: Text(
              'Confirm',
              style: AppTextStyles.body5SemiBold.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class FundOption {
  final String name;
  final String subtitle;
  final String returns;
  final Color iconColor;

  FundOption({
    required this.name,
    required this.subtitle,
    required this.returns,
    required this.iconColor,
  });
}
