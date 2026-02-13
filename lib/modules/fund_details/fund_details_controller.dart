import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class FundDetailsController extends GetxController {
  final RxBool isTaxInfoExpanded = true.obs;
  final RxString selectedPeriod = '3Y'.obs;

  // Return Calculator
  final RxBool isCalculatorExpanded = true.obs;
  final RxString investmentType = 'Monthly SIP'.obs;
  final RxDouble investmentAmount = 5000.0.obs;
  final RxString investmentDuration = '1 year'.obs;

  final RxBool isTopHoldingsExpanded = false.obs;

  final double expectedAnnualReturn = 18.6;

  double get minAmount =>
      investmentType.value == 'Monthly SIP' ? 500.0 : 1000.0;
  double get maxAmount =>
      investmentType.value == 'Monthly SIP' ? 50000.0 : 500000.0;

  int get durationInYears {
    switch (investmentDuration.value) {
      case '1 year':
        return 1;
      case '3 years':
        return 3;
      case '5 years':
        return 5;
      default:
        return 1;
    }
  }

  double get totalInvestment {
    if (investmentType.value == 'Monthly SIP') {
      return investmentAmount.value * 12 * durationInYears;
    } else {
      return investmentAmount.value;
    }
  }

  double get estimatedReturns {
    final r = expectedAnnualReturn / 100;
    final n = durationInYears;

    if (investmentType.value == 'Monthly SIP') {
      final monthlyRate = r / 12;
      final months = n * 12;
      final p = investmentAmount.value;

      final futureValue =
          p *
          ((pow(1 + monthlyRate, months) - 1) / monthlyRate) *
          (1 + monthlyRate);
      return futureValue;
    } else {
      final futureValue = investmentAmount.value * pow(1 + r, n);
      return futureValue;
    }
  }

  double get absoluteGain => estimatedReturns - totalInvestment;
  double get returnPercentage => (absoluteGain / totalInvestment) * 100;

  final Map<String, ChartData> chartDataMap = {
    '1M': ChartData(
      returns: '2.45%',
      change: '+0.12%',
      isPositive: true,
      points: [
        42.10,
        42.25,
        42.15,
        42.40,
        42.35,
        42.50,
        42.45,
        42.60,
        42.55,
        42.70,
        42.65,
        42.80,
        42.75,
        42.85,
      ],
    ),
    '6M': ChartData(
      returns: '8.92%',
      change: '+0.15%',
      isPositive: true,
      points: [
        39.50,
        39.80,
        40.10,
        40.50,
        40.30,
        40.80,
        41.00,
        41.30,
        41.50,
        41.80,
        42.00,
        42.30,
        42.50,
        42.85,
      ],
    ),
    '1Y': ChartData(
      returns: '18.6%',
      change: '-0.05%',
      isPositive: false,
      points: [
        36.20,
        36.80,
        37.50,
        38.20,
        38.80,
        39.40,
        39.80,
        40.20,
        40.80,
        41.20,
        41.60,
        42.00,
        42.40,
        42.85,
      ],
    ),
    '3Y': ChartData(
      returns: '21.33%',
      change: '-0.01%',
      isPositive: false,
      points: [
        28.50,
        29.80,
        31.20,
        32.80,
        34.20,
        35.60,
        36.80,
        37.90,
        38.80,
        39.70,
        40.50,
        41.20,
        41.80,
        42.85,
      ],
    ),
    '5Y': ChartData(
      returns: '14.8%',
      change: '+0.08%',
      isPositive: true,
      points: [
        22.40,
        24.80,
        27.20,
        29.80,
        31.50,
        33.20,
        34.80,
        36.20,
        37.50,
        38.80,
        40.00,
        41.00,
        41.90,
        42.85,
      ],
    ),
    'ALL': ChartData(
      returns: '156.8%',
      change: '+0.10%',
      isPositive: true,
      points: [
        16.70,
        19.20,
        22.50,
        25.80,
        28.40,
        31.20,
        33.80,
        36.20,
        38.40,
        39.80,
        40.90,
        41.70,
        42.30,
        42.85,
      ],
    ),
  };

  void toggleTaxInfo() {
    isTaxInfoExpanded.value = !isTaxInfoExpanded.value;
  }

  void toggleTopHoldings() {
    isTopHoldingsExpanded.value = !isTopHoldingsExpanded.value;
  }

  void toggleCalculator() {
    isCalculatorExpanded.value = !isCalculatorExpanded.value;
  }

  void selectPeriod(String period) {
    selectedPeriod.value = period;
  }

  void selectInvestmentType(String type) {
    investmentType.value = type;
    investmentAmount.value = minAmount;
  }

  void updateInvestmentAmount(double amount) {
    investmentAmount.value = amount;
  }

  void selectDuration(String duration) {
    investmentDuration.value = duration;
  }

  ChartData get currentChartData => chartDataMap[selectedPeriod.value]!;

  List<FlSpot> get chartSpots {
    final points = currentChartData.points;
    return List.generate(
      points.length,
      (index) => FlSpot(index.toDouble(), points[index]),
    );
  }
}

class ChartData {
  final String returns;
  final String change;
  final bool isPositive;
  final List<double> points;

  ChartData({
    required this.returns,
    required this.change,
    required this.isPositive,
    required this.points,
  });
}
