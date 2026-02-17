import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

class AllMutualFundsController extends GetxController {
  final searchController = TextEditingController();
  final RxBool isSearching = false.obs;
  final RxList<MutualFund> allFunds = <MutualFund>[].obs;
  final RxList<MutualFund> filteredFunds = <MutualFund>[].obs;

  // Filter state
  final RxMap<String, bool> selectedCategories = <String, bool>{}.obs;
  final RxMap<String, bool> expandedCategories = <String, bool>{}.obs;
  final RxString selectedFilterSection = 'Category'.obs;

  // AMC filter
  final RxMap<String, bool> selectedAMCs = <String, bool>{}.obs;
  final List<String> amcList = [
    'SBI',
    'Axis',
    'HDFC',
    'ICICI',
    'Kotak',
    'Nippon India',
    'Aditya Birla',
    'UTI',
    'DSP',
    'Franklin Templeton',
  ];

  // Risk Level filter
  final RxMap<String, bool> selectedRiskLevels = <String, bool>{}.obs;
  final List<String> riskLevels = [
    'Low',
    'Moderately Low',
    'Moderate',
    'Moderately High',
    'High',
    'Very High',
  ];

  // Return Range filter
  final RxDouble returnRangeStart = 0.0.obs;
  final RxDouble returnRangeEnd = 50.0.obs;
  final returnRangeStartController = TextEditingController();
  final returnRangeEndController = TextEditingController();

  final RxBool isAdvancedFilter = false.obs;

  // Advanced Filter - Fund House
  final RxMap<String, bool> selectedFundHouses = <String, bool>{}.obs;
  final List<String> fundHouseList = [
    'SBI Mutual Fund',
    'HDFC Mutual Fund',
    'ICICI Prudential Mutual Fund',
    'Axis Mutual Fund',
    'Kotak Mahindra Mutual Fund',
    'Nippon India Mutual Fund',
    'Aditya Birla Sun Life Mutual Fund',
    'UTI Mutual Fund',
    'DSP Mutual Fund',
    'Franklin Templeton Mutual Fund',
  ];

  // Advanced Filter - Fund Manager
  final RxMap<String, bool> selectedFundManagers = <String, bool>{}.obs;
  final List<String> fundManagerList = [
    'Rajeev Thakkar',
    'Prashant Jain',
    'S Naren',
    'Chandraprakash Padiyar',
    'Neelesh Surana',
    'Sailesh Raj Bhan',
    'Jinesh Gopani',
    'Anoop Bhaskar',
    'Mahesh Patil',
    'George Thomas',
  ];

  // Advanced Filter - AUM Range
  final RxDouble aumRangeStart = 0.0.obs;
  final RxDouble aumRangeEnd = 50000.0.obs;
  final aumRangeStartController = TextEditingController();
  final aumRangeEndController = TextEditingController();

  // Advanced Filter - Expense Ratio Range
  final RxDouble expenseRatioStart = 0.0.obs;
  final RxDouble expenseRatioEnd = 3.0.obs;
  final expenseRatioStartController = TextEditingController();
  final expenseRatioEndController = TextEditingController();

  // Advanced Filter - Ratings
  final RxMap<int, bool> selectedRatings = <int, bool>{}.obs;
  final List<int> ratingsList = [1, 2, 3, 4, 5];

  final RxMap<String, List<String>> categorySubItems = <String, List<String>>{
    'Equity': [
      'Large Cap',
      'Mid Cap',
      'Small Cap',
      'Multi Cap',
      'Flexi Cap',
      'Large & Mid Cap',
      'ELSS',
      'Sectoral',
      'International',
    ],
    'Debt': [
      'Liquid Fund',
      'Ultra Short Duration',
      'Low Duration',
      'Money Market',
      'Short Duration',
      'Medium Duration',
      'Long Duration',
      'Dynamic Bond',
      'Corporate Bond',
      'Credit Risk',
      'Banking & PSU',
      'Gilt',
    ],
    'Hybrid': [
      'Conservative Hybrid',
      'Balanced Hybrid',
      'Aggressive Hybrid',
      'Dynamic Asset Allocation',
      'Multi Asset Allocation',
      'Arbitrage',
    ],
    'Commodities': ['Gold', 'Silver', 'Other Commodities'],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    _initializeFilters();
  }

  void _initializeFilters() {
    // Initialize all categories and subcategories as unselected
    for (var category in categorySubItems.keys) {
      selectedCategories['parent_$category'] = false;
      expandedCategories[category] = false;
      for (var subItem in categorySubItems[category]!) {
        selectedCategories['${category}_$subItem'] = false;
      }
    }

    // Initialize AMCs
    for (var amc in amcList) {
      selectedAMCs[amc] = false;
    }

    // Initialize Risk Levels
    for (var risk in riskLevels) {
      selectedRiskLevels[risk] = false;
    }

    // Initialize return range
    returnRangeStart.value = 0.0;
    returnRangeEnd.value = 50.0;
    returnRangeStartController.text = '0';
    returnRangeEndController.text = '50';

    // Initialize Advanced Filters
    for (var fundHouse in fundHouseList) {
      selectedFundHouses[fundHouse] = false;
    }

    for (var manager in fundManagerList) {
      selectedFundManagers[manager] = false;
    }

    aumRangeStart.value = 0.0;
    aumRangeEnd.value = 50000.0;
    aumRangeStartController.text = '0';
    aumRangeEndController.text = '50000';

    expenseRatioStart.value = 0.0;
    expenseRatioEnd.value = 3.0;
    expenseRatioStartController.text = '0';
    expenseRatioEndController.text = '3';

    for (var rating in ratingsList) {
      selectedRatings[rating] = false;
    }
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

  void toggleCategoryExpansion(String category) {
    expandedCategories[category] = !(expandedCategories[category] ?? false);
  }

  void toggleParentCategory(String category) {
    final parentKey = 'parent_$category';
    final newValue = !(selectedCategories[parentKey] ?? false);
    selectedCategories[parentKey] = newValue;

    // Toggle all subcategories
    for (var subItem in categorySubItems[category]!) {
      selectedCategories['${category}_$subItem'] = newValue;
    }
  }

  void toggleSubCategory(String category, String subItem) {
    final key = '${category}_$subItem';
    selectedCategories[key] = !(selectedCategories[key] ?? false);

    // Check if all subcategories are selected
    final allSelected = categorySubItems[category]!.every(
      (item) => selectedCategories['${category}_$item'] == true,
    );

    // Update parent checkbox
    selectedCategories['parent_$category'] = allSelected;
  }

  bool isParentSelected(String category) {
    return selectedCategories['parent_$category'] ?? false;
  }

  bool isCategoryExpanded(String category) {
    return expandedCategories[category] ?? false;
  }

  bool isSubCategorySelected(String category, String subItem) {
    return selectedCategories['${category}_$subItem'] ?? false;
  }

  void clearFilters() {
    _initializeFilters();
    _filterFunds(); // Re-apply filters to update the view
  }

  void selectFilterSection(String section) {
    selectedFilterSection.value = section;
  }

  void toggleAdvancedFilter() {
    isAdvancedFilter.value = !isAdvancedFilter.value;
    if (isAdvancedFilter.value) {
      selectedFilterSection.value = 'Fund House';
    } else {
      selectedFilterSection.value = 'Category';
    }
  }

  void toggleAMC(String amc) {
    selectedAMCs[amc] = !(selectedAMCs[amc] ?? false);
  }

  bool isAMCSelected(String amc) {
    return selectedAMCs[amc] ?? false;
  }

  void toggleRiskLevel(String risk) {
    selectedRiskLevels[risk] = !(selectedRiskLevels[risk] ?? false);
  }

  bool isRiskLevelSelected(String risk) {
    return selectedRiskLevels[risk] ?? false;
  }

  void updateReturnRange(double start, double end) {
    returnRangeStart.value = start;
    returnRangeEnd.value = end;
    returnRangeStartController.text = start.toStringAsFixed(1);
    returnRangeEndController.text = end.toStringAsFixed(1);
  }

  void updateReturnRangeFromInput() {
    final start = double.tryParse(returnRangeStartController.text) ?? 0.0;
    final end = double.tryParse(returnRangeEndController.text) ?? 50.0;

    if (start >= 0 && end <= 50 && start < end) {
      returnRangeStart.value = start;
      returnRangeEnd.value = end;
    }
  }

  // Advanced Filter methods
  void toggleFundHouse(String fundHouse) {
    selectedFundHouses[fundHouse] = !(selectedFundHouses[fundHouse] ?? false);
  }

  bool isFundHouseSelected(String fundHouse) {
    return selectedFundHouses[fundHouse] ?? false;
  }

  void toggleFundManager(String manager) {
    selectedFundManagers[manager] = !(selectedFundManagers[manager] ?? false);
  }

  bool isFundManagerSelected(String manager) {
    return selectedFundManagers[manager] ?? false;
  }

  void updateAUMRange(double start, double end) {
    aumRangeStart.value = start;
    aumRangeEnd.value = end;
    aumRangeStartController.text = start.toStringAsFixed(0);
    aumRangeEndController.text = end.toStringAsFixed(0);
  }

  void updateAUMRangeFromInput() {
    final start = double.tryParse(aumRangeStartController.text) ?? 0.0;
    final end = double.tryParse(aumRangeEndController.text) ?? 50000.0;

    if (start >= 0 && end <= 50000 && start < end) {
      aumRangeStart.value = start;
      aumRangeEnd.value = end;
    }
  }

  void updateExpenseRatioRange(double start, double end) {
    expenseRatioStart.value = start;
    expenseRatioEnd.value = end;
    expenseRatioStartController.text = start.toStringAsFixed(2);
    expenseRatioEndController.text = end.toStringAsFixed(2);
  }

  void updateExpenseRatioFromInput() {
    final start = double.tryParse(expenseRatioStartController.text) ?? 0.0;
    final end = double.tryParse(expenseRatioEndController.text) ?? 3.0;

    if (start >= 0 && end <= 3 && start < end) {
      expenseRatioStart.value = start;
      expenseRatioEnd.value = end;
    }
  }

  void toggleRating(int rating) {
    selectedRatings[rating] = !(selectedRatings[rating] ?? false);
  }

  bool isRatingSelected(int rating) {
    return selectedRatings[rating] ?? false;
  }

  void applyFilters() {
    // Apply filter logic here
    _filterFunds();
    Get.back();
  }

  void _filterFunds() {
    List<MutualFund> filtered = List.from(allFunds);

    // Filter by categories
    List<String> selectedCategoryList = [];
    for (var category in categorySubItems.keys) {
      for (var subItem in categorySubItems[category]!) {
        if (selectedCategories['${category}_$subItem'] == true) {
          selectedCategoryList.add(subItem);
        }
      }
    }
    if (selectedCategoryList.isNotEmpty) {
      filtered = filtered.where((fund) {
        return selectedCategoryList.contains(fund.category);
      }).toList();
    }

    // Filter by AMC
    List<String> selectedAMCList = selectedAMCs.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    if (selectedAMCList.isNotEmpty) {
      filtered = filtered.where((fund) {
        return selectedAMCList.any((amc) => fund.name.contains(amc));
      }).toList();
    }

    // Filter by Risk Level
    List<String> selectedRiskList = selectedRiskLevels.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();
    if (selectedRiskList.isNotEmpty) {
      filtered = filtered.where((fund) {
        return selectedRiskList.any((risk) => fund.risk.contains(risk));
      }).toList();
    }

    // Filter by Return Range
    if (returnRangeStart.value > 0 || returnRangeEnd.value < 50) {
      filtered = filtered.where((fund) {
        return fund.returns >= returnRangeStart.value &&
            fund.returns <= returnRangeEnd.value;
      }).toList();
    }

    // Advanced Filters
    List<String> selectedFundHouseList = selectedFundHouses.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    List<String> selectedFundManagerList = selectedFundManagers.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    List<int> selectedRatingsList = selectedRatings.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    // Check if any filters are active
    bool hasActiveFilters =
        selectedCategoryList.isNotEmpty ||
        selectedAMCList.isNotEmpty ||
        selectedRiskList.isNotEmpty ||
        returnRangeStart.value > 0 ||
        returnRangeEnd.value < 50 ||
        selectedFundHouseList.isNotEmpty ||
        selectedFundManagerList.isNotEmpty ||
        (aumRangeStart.value > 0 || aumRangeEnd.value < 50000) ||
        (expenseRatioStart.value > 0 || expenseRatioEnd.value < 3) ||
        selectedRatingsList.isNotEmpty;

    // Update the displayed funds
    if (hasActiveFilters) {
      filteredFunds.value = filtered;
      isSearching.value = true; // Use the filtered view
    } else {
      // No filters applied, show all
      filteredFunds.clear();
      isSearching.value = false;
    }
  }

  List<String> getActiveFilters() {
    List<String> activeFilters = [];

    // Add selected categories
    for (var category in categorySubItems.keys) {
      for (var subItem in categorySubItems[category]!) {
        if (selectedCategories['${category}_$subItem'] == true) {
          activeFilters.add(subItem);
        }
      }
    }

    // Add selected AMCs
    selectedAMCs.entries.where((entry) => entry.value == true).forEach((entry) {
      activeFilters.add(entry.key);
    });

    // Add selected risk levels
    selectedRiskLevels.entries.where((entry) => entry.value == true).forEach((
      entry,
    ) {
      activeFilters.add(entry.key);
    });

    // Add return range if customized
    if (returnRangeStart.value > 0 || returnRangeEnd.value < 50) {
      activeFilters.add(
        'Returns: ${returnRangeStart.value.toStringAsFixed(1)}%-${returnRangeEnd.value.toStringAsFixed(1)}%',
      );
    }

    // Add selected fund houses
    selectedFundHouses.entries.where((entry) => entry.value == true).forEach((
      entry,
    ) {
      activeFilters.add(entry.key);
    });

    // Add selected fund managers
    selectedFundManagers.entries.where((entry) => entry.value == true).forEach((
      entry,
    ) {
      activeFilters.add(entry.key);
    });

    // Add AUM range if customized
    if (aumRangeStart.value > 0 || aumRangeEnd.value < 50000) {
      activeFilters.add(
        'AUM: ₹${aumRangeStart.value.toStringAsFixed(0)}-₹${aumRangeEnd.value.toStringAsFixed(0)} Cr',
      );
    }

    // Add expense ratio if customized
    if (expenseRatioStart.value > 0 || expenseRatioEnd.value < 3) {
      activeFilters.add(
        'Expense: ${expenseRatioStart.value.toStringAsFixed(2)}%-${expenseRatioEnd.value.toStringAsFixed(2)}%',
      );
    }

    // Add selected ratings
    selectedRatings.entries.where((entry) => entry.value == true).forEach((
      entry,
    ) {
      activeFilters.add('${entry.key} Star${entry.key > 1 ? 's' : ''}');
    });

    return activeFilters;
  }

  void removeFilter(String filter) {
    // Remove from categories
    for (var category in categorySubItems.keys) {
      for (var subItem in categorySubItems[category]!) {
        if (subItem == filter) {
          selectedCategories['${category}_$subItem'] = false;
          selectedCategories['parent_$category'] = false;
        }
      }
    }

    // Remove from AMCs
    if (selectedAMCs.containsKey(filter)) {
      selectedAMCs[filter] = false;
    }

    // Remove from risk levels
    if (selectedRiskLevels.containsKey(filter)) {
      selectedRiskLevels[filter] = false;
    }

    // Remove from fund houses
    if (selectedFundHouses.containsKey(filter)) {
      selectedFundHouses[filter] = false;
    }

    // Remove from fund managers
    if (selectedFundManagers.containsKey(filter)) {
      selectedFundManagers[filter] = false;
    }

    // Remove from ratings
    for (var rating in ratingsList) {
      if ('$rating Star${rating > 1 ? 's' : ''}' == filter) {
        selectedRatings[rating] = false;
      }
    }

    // Handle range filters
    if (filter.startsWith('Returns:')) {
      returnRangeStart.value = 0.0;
      returnRangeEnd.value = 50.0;
      returnRangeStartController.text = '0';
      returnRangeEndController.text = '50';
    }

    if (filter.startsWith('AUM:')) {
      aumRangeStart.value = 0.0;
      aumRangeEnd.value = 50000.0;
      aumRangeStartController.text = '0';
      aumRangeEndController.text = '50000';
    }

    if (filter.startsWith('Expense:')) {
      expenseRatioStart.value = 0.0;
      expenseRatioEnd.value = 3.0;
      expenseRatioStartController.text = '0';
      expenseRatioEndController.text = '3';
    }

    // Re-apply filters
    _filterFunds();
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
    returnRangeStartController.dispose();
    returnRangeEndController.dispose();
    aumRangeStartController.dispose();
    aumRangeEndController.dispose();
    expenseRatioStartController.dispose();
    expenseRatioEndController.dispose();
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
