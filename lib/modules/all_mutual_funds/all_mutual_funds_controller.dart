import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

class AllMutualFundsController extends GetxController {
  final searchController = TextEditingController();
  final RxBool isSearching = false.obs;
  final RxList<MutualFund> allFunds = <MutualFund>[].obs;
  final RxList<MutualFund> filteredFunds = <MutualFund>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    allFunds.value = [
      MutualFund(
        name: "Axis Blue-chip Fund",
        category: "Large Cap",
        risk: "Moderate Risk",
        returns: 18.6,
        nav: 42.85,
        date: "25 Sep",
        iconColor: AppColors.red500,
      ),
      MutualFund(
        name: "Parag Parikh Flexi Cap Fund",
        category: "Flexi Cap",
        risk: "Moderate Risk",
        returns: 20.3,
        nav: 64.12,
        date: "25 Sep",
        iconColor: AppColors.green500,
      ),
      MutualFund(
        name: "SBI Small Cap Fund",
        category: "Small Cap",
        risk: "High Risk",
        returns: 25.9,
        nav: 138.40,
        date: "25 Sep",
        iconColor: AppColors.primary500,
      ),
      MutualFund(
        name: "HDFC Mid Cap Opportunities Fund",
        category: "Mid Cap",
        risk: "High Risk",
        returns: 22.4,
        nav: 156.30,
        date: "25 Sep",
        iconColor: AppColors.orange500,
      ),
      MutualFund(
        name: "ICICI Prudential Bluechip Fund",
        category: "Large Cap",
        risk: "Moderate Risk",
        returns: 17.8,
        nav: 89.45,
        date: "25 Sep",
        iconColor: AppColors.orange500,
      ),
      MutualFund(
        name: "Kotak Emerging Equity Fund",
        category: "Mid Cap",
        risk: "High Risk",
        returns: 21.5,
        nav: 72.90,
        date: "25 Sep",
        iconColor: AppColors.red500,
      ),
      MutualFund(
        name: "Mirae Asset Large Cap Fund",
        category: "Large Cap",
        risk: "Moderate Risk",
        returns: 19.2,
        nav: 95.60,
        date: "25 Sep",
        iconColor: AppColors.primary500,
      ),
      MutualFund(
        name: "Nippon India Small Cap Fund",
        category: "Small Cap",
        risk: "Very High Risk",
        returns: 28.7,
        nav: 142.85,
        date: "25 Sep",
        iconColor: AppColors.green500,
      ),
    ];
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      isSearching.value = false;
      filteredFunds.clear();
      return;
    }

    isSearching.value = true;
    final lowerQuery = query.toLowerCase();

    filteredFunds.value = allFunds.where((fund) {
      return fund.name.toLowerCase().contains(lowerQuery) ||
          fund.category.toLowerCase().contains(lowerQuery) ||
          fund.risk.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class MutualFund {
  final String name;
  final String category;
  final String risk;
  final double returns;
  final double nav;
  final String date;
  final Color iconColor;

  MutualFund({
    required this.name,
    required this.category,
    required this.risk,
    required this.returns,
    required this.nav,
    required this.date,
    required this.iconColor,
  });
}
