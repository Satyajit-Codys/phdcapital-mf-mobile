import 'package:get/get.dart';

class CompareFundsController extends GetxController {
  final Rx<String?> selectedFund1 = Rx<String?>(null);
  final Rx<String?> selectedFund2 = Rx<String?>(null);

  final List<String> allFunds = [
    "Axis Blue-chip Fund",
    "SBI Small Cap Fund",
    "HDFC Mid Cap Opportunities Fund",
    "ICICI Prudential Bluechip Fund",
    "Parag Parikh Flexi Cap Fund",
    "Kotak Emerging Equity Fund",
    "Mirae Asset Large Cap Fund",
    "Nippon India Small Cap Fund",
  ];

  // Mock data for comparison
  final Map<String, Map<String, String>> fundData = {
    "Axis Blue-chip Fund": {
      "nav": "₹42.85",
      "1y": "18.6%",
      "3y": "21.4%",
      "5y": "14.8%",
      "expense": "0.62%",
      "risk": "Moderate",
      "size": "₹35,200 Cr",
      "exit": "1% (1Y)",
      "min": "₹500",
    },
    "SBI Small Cap Fund": {
      "nav": "₹61.20",
      "1y": "16.2%",
      "3y": "19.1%",
      "5y": "13.5%",
      "expense": "0.58%",
      "risk": "Moderate",
      "size": "₹28,400 Cr",
      "exit": "1% (1Y)",
      "min": "₹1000",
    },
    "HDFC Mid Cap Opportunities Fund": {
      "nav": "₹156.30",
      "1y": "22.4%",
      "3y": "24.8%",
      "5y": "16.2%",
      "expense": "0.75%",
      "risk": "High",
      "size": "₹42,100 Cr",
      "exit": "1% (1Y)",
      "min": "₹500",
    },
    "ICICI Prudential Bluechip Fund": {
      "nav": "₹89.45",
      "1y": "17.8%",
      "3y": "20.5%",
      "5y": "14.2%",
      "expense": "0.68%",
      "risk": "Moderate",
      "size": "₹38,900 Cr",
      "exit": "1% (1Y)",
      "min": "₹500",
    },
    "Parag Parikh Flexi Cap Fund": {
      "nav": "₹64.12",
      "1y": "20.3%",
      "3y": "23.1%",
      "5y": "15.7%",
      "expense": "0.72%",
      "risk": "Moderate",
      "size": "₹31,500 Cr",
      "exit": "1% (1Y)",
      "min": "₹1000",
    },
    "Kotak Emerging Equity Fund": {
      "nav": "₹72.90",
      "1y": "21.5%",
      "3y": "22.8%",
      "5y": "15.3%",
      "expense": "0.70%",
      "risk": "High",
      "size": "₹29,800 Cr",
      "exit": "1% (1Y)",
      "min": "₹500",
    },
    "Mirae Asset Large Cap Fund": {
      "nav": "₹95.60",
      "1y": "19.2%",
      "3y": "21.9%",
      "5y": "15.1%",
      "expense": "0.65%",
      "risk": "Moderate",
      "size": "₹33,700 Cr",
      "exit": "1% (1Y)",
      "min": "₹500",
    },
    "Nippon India Small Cap Fund": {
      "nav": "₹142.85",
      "1y": "28.7%",
      "3y": "31.2%",
      "5y": "18.9%",
      "expense": "0.82%",
      "risk": "Very High",
      "size": "₹25,600 Cr",
      "exit": "1% (1Y)",
      "min": "₹1000",
    },
  };

  // Get available funds for dropdown 1 (exclude fund 2 if selected)
  List<String> get availableFundsForDropdown1 {
    if (selectedFund2.value == null) {
      return allFunds;
    }
    return allFunds.where((fund) => fund != selectedFund2.value).toList();
  }

  // Get available funds for dropdown 2 (exclude fund 1 if selected)
  List<String> get availableFundsForDropdown2 {
    if (selectedFund1.value == null) {
      return allFunds;
    }
    return allFunds.where((fund) => fund != selectedFund1.value).toList();
  }

  void selectFund1(String fund) {
    selectedFund1.value = fund;
  }

  void selectFund2(String fund) {
    selectedFund2.value = fund;
  }

  Map<String, String> getFundData(String fundName) {
    return fundData[fundName] ?? {};
  }
}
