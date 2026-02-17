import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

class SipController extends GetxController {
  final RxList<SipInvestment> activeSips = <SipInvestment>[].obs;
  final RxList<SipTransaction> recentTransactions = <SipTransaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void _loadMockData() {
    activeSips.value = [
      SipInvestment(
        id: '1',
        fundName: 'Axis Blue-chip Fund',
        amount: 5000,
        nextDebitDate: '10 Feb',
        status: SipStatus.active,
        iconColor: AppColors.red500,
      ),
      SipInvestment(
        id: '2',
        fundName: 'HDFC Flexi Cap Fund',
        amount: 3000,
        nextDebitDate: '15 Feb',
        status: SipStatus.paused,
        iconColor: AppColors.orange500,
      ),
    ];

    recentTransactions.value = [
      SipTransaction(
        fundName: 'Axis Bluechip Fund',
        amount: 5000,
        sipAmount: 3000,
        type: 'SIP Instalment',
        status: TransactionStatus.complete,
        iconColor: AppColors.red500,
      ),
      SipTransaction(
        fundName: 'HDFC Flexi Cap Fund',
        amount: 3000,
        sipAmount: 3000,
        type: 'SIP Instalment',
        status: TransactionStatus.pending,
        iconColor: AppColors.orange500,
      ),
      SipTransaction(
        fundName: 'Axis Bluechip Fund',
        amount: 5000,
        sipAmount: 3000,
        type: 'SIP Instalment',
        status: TransactionStatus.failed,
        iconColor: AppColors.red500,
      ),
      SipTransaction(
        fundName: 'HDFC Flexi Cap Fund',
        amount: 3000,
        sipAmount: 3000,
        type: 'SIP Instalment',
        status: TransactionStatus.pending,
        iconColor: AppColors.orange500,
      ),
    ];
  }
}

enum SipStatus { active, paused }

enum TransactionStatus { complete, pending, failed }

class SipInvestment {
  final String id;
  final String fundName;
  final double amount;
  final String nextDebitDate;
  final SipStatus status;
  final Color iconColor;

  SipInvestment({
    required this.id,
    required this.fundName,
    required this.amount,
    required this.nextDebitDate,
    required this.status,
    required this.iconColor,
  });
}

class SipTransaction {
  final String fundName;
  final double amount;
  final double sipAmount;
  final String type;
  final TransactionStatus status;
  final Color iconColor;

  SipTransaction({
    required this.fundName,
    required this.amount,
    required this.sipAmount,
    required this.type,
    required this.status,
    required this.iconColor,
  });
}
