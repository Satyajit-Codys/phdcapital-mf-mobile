import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/aadhaar_ekyc/aadhaar_ekyc_screen.dart';
import 'package:phdcapital_mf_mobile/modules/aadhaar_otp/aadhaar_otp_screen.dart';
import 'package:phdcapital_mf_mobile/modules/address_details/address_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/all_mutual_funds/all_mutual_funds_screen.dart';
import 'package:phdcapital_mf_mobile/modules/bank_account/bank_account_screen.dart';
import 'package:phdcapital_mf_mobile/modules/bank_verification/bank_verification_screen.dart';
import 'package:phdcapital_mf_mobile/modules/compare_funds/compare_funds_screen.dart';
import 'package:phdcapital_mf_mobile/modules/create_pin/create_pin_screen.dart';
import 'package:phdcapital_mf_mobile/modules/fund_details/fund_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/investment_failed/investment_failed_screen.dart';
import 'package:phdcapital_mf_mobile/modules/investment_success/investment_success_screen.dart';
import 'package:phdcapital_mf_mobile/modules/kyc/kyc_screen.dart';
import 'package:phdcapital_mf_mobile/modules/kyc_completed/kyc_completed_screen.dart';
import 'package:phdcapital_mf_mobile/modules/language/language_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login/login_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login_otp/otp_screen.dart';
import 'package:phdcapital_mf_mobile/modules/main_navigation/main_navigation_screen.dart';
import 'package:phdcapital_mf_mobile/modules/nominee/nominee_screen.dart';
import 'package:phdcapital_mf_mobile/modules/pan_verification/pan_verification_screen.dart';
import 'package:phdcapital_mf_mobile/modules/payment/payment_screen.dart';
import 'package:phdcapital_mf_mobile/modules/payment_processing/payment_processing_screen.dart';
import 'package:phdcapital_mf_mobile/modules/personal_details/personal_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/profile/profile_screen.dart';
import 'package:phdcapital_mf_mobile/modules/risk_assessment/risk_assessment_screen.dart';
import 'package:phdcapital_mf_mobile/modules/risk_profile/risk_profile_screen.dart';
import 'package:phdcapital_mf_mobile/modules/financial_goal/financial_goal_screen.dart';
import 'package:phdcapital_mf_mobile/modules/sip_invest/sip_invest_screen.dart';
import 'package:phdcapital_mf_mobile/modules/sip/sip_screen.dart';
import 'package:phdcapital_mf_mobile/modules/sip_details/sip_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/switch_funds/switch_funds_screen.dart';
import 'package:phdcapital_mf_mobile/modules/redeem_sip/redeem_sip_screen.dart';
import 'package:phdcapital_mf_mobile/modules/stepup_sip/stepup_sip_screen.dart';
import 'package:phdcapital_mf_mobile/modules/pause_sip_request/pause_sip_request_screen.dart';
import 'package:phdcapital_mf_mobile/modules/redeem_request/redeem_request_screen.dart';
import 'package:phdcapital_mf_mobile/modules/stepup_sip_request/stepup_sip_request_screen.dart';
import 'package:phdcapital_mf_mobile/modules/splash/splash_screen.dart';
import 'package:phdcapital_mf_mobile/modules/terms_consent/terms_consent_screen.dart';
import 'package:phdcapital_mf_mobile/modules/upload_documents/upload_documents_screen.dart';
import 'package:phdcapital_mf_mobile/modules/video_kyc/video_kyc_screen.dart';
import 'package:phdcapital_mf_mobile/modules/welcome/welcome_screen.dart';

class Routes {
  // SPLASH
  static const splash = '/splash';

  // WELCOME
  static const language = '/language';
  static const welcome = '/welcome';

  // LOGIN
  static const login = "/login";
  static const otp = "/otp";
  static const createPin = "/create-pin";

  // ONBOARDING
  static const personalDetails = "/personal-details";
  static const panVerify = "/pan-verify";
  static const addressDetails = "/address-details";
  static const nominee = "/nominee";
  static const bankAccount = "/bank-account";
  static const bankVerification = "/bank-verification";
  static const termsConsent = "/terms-consent";
  static const riskAssessment = "/risk-assessment";
  static const riskProfile = "/risk-profile";
  static const financialGoal = "/financial-goal";

  // KYC
  static const kyc = "/kyc";
  static const aadhaarKyc = "/aadhaar-kyc";
  static const aadhaarOtp = "/aadhaar-otp";
  static const uploadDocuments = "/upload-documents";
  static const videoKyc = "/video-kyc";
  static const kycCompleted = "/kyc-completed";

  // HOME
  static const home = "/home";

  // MUTUAL FUNDS
  static const allMutualFunds = "/all-mutual-funds";
  static const fundDetails = "/fund-details";
  static const compareFunds = "/compare-funds";
  static const sipInvest = "/sip-invest";
  static const payment = "/payment";
  static const paymentProcessing = "/payment-processing";
  static const investmentSuccess = "/investment-success";
  static const investmentFailed = "/investment-failed";

  // PROFILE
  static const profile = "/profile";

  // SIP MANAGEMENT
  static const sip = "/sip";
  static const sipDetails = "/sip-details";
  static const switchFunds = "/switch-funds";
  static const redeemSip = "/redeem-sip";
  static const stepupSip = "/stepup-sip";
  static const pauseSipRequest = "/pause-sip-request";
  static const redeemRequest = "/redeem-request";
  static const stepupSipRequest = "/stepup-sip-request";
}

class AppPages {
  static final pages = [
    // SPLASH
    GetPage(name: Routes.splash, page: () => SplashScreen()),

    // WELCOME
    GetPage(name: Routes.language, page: () => LanguageScreen()),
    GetPage(name: Routes.welcome, page: () => WelcomeScreen()),

    // LOGIN
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.otp, page: () => OtpScreen()),
    GetPage(name: Routes.createPin, page: () => CreatePinScreen()),

    // ONBOARDING
    GetPage(name: Routes.personalDetails, page: () => PersonalDetailsScreen()),
    GetPage(name: Routes.panVerify, page: () => PanVerificationScreen()),
    GetPage(name: Routes.addressDetails, page: () => AddressDetailsScreen()),
    GetPage(name: Routes.nominee, page: () => NomineeScreen()),
    GetPage(name: Routes.bankAccount, page: () => BankAccountDetailsScreen()),
    GetPage(
      name: Routes.bankVerification,
      page: () => BankVerificationScreen(),
    ),
    GetPage(name: Routes.termsConsent, page: () => TermsConsentScreen()),
    GetPage(name: Routes.riskAssessment, page: () => RiskAssessmentScreen()),
    GetPage(name: Routes.riskProfile, page: () => RiskProfileScreen()),
    GetPage(name: Routes.financialGoal, page: () => FinancialGoalScreen()),

    // KYC
    GetPage(name: Routes.kyc, page: () => KycVerificationScreen()),
    GetPage(name: Routes.aadhaarKyc, page: () => AadhaarEkycScreen()),
    GetPage(name: Routes.aadhaarOtp, page: () => AadhaarOtpScreen()),
    GetPage(name: Routes.uploadDocuments, page: () => UploadDocumentsScreen()),
    GetPage(name: Routes.videoKyc, page: () => VideoKycScreen()),
    GetPage(name: Routes.kycCompleted, page: () => const KycCompletedScreen()),

    // HOME
    GetPage(name: Routes.home, page: () => MainNavigationScreen()),

    // MUTUAL FUNDS
    GetPage(name: Routes.allMutualFunds, page: () => AllMutualFundsScreen()),
    GetPage(name: Routes.fundDetails, page: () => FundDetailsScreen()),
    GetPage(name: Routes.compareFunds, page: () => CompareFundsScreen()),
    GetPage(name: Routes.sipInvest, page: () => SipInvestScreen()),
    GetPage(name: Routes.payment, page: () => PaymentScreen()),
    GetPage(
      name: Routes.paymentProcessing,
      page: () => const PaymentProcessingScreen(),
    ),
    GetPage(
      name: Routes.investmentSuccess,
      page: () => const InvestmentSuccessScreen(),
    ),
    GetPage(
      name: Routes.investmentFailed,
      page: () => const InvestmentFailedScreen(),
    ),

    // PROFILE
    GetPage(name: Routes.profile, page: () => const ProfileScreen()),

    // SIP MANAGEMENT
    GetPage(name: Routes.sip, page: () => SipScreen()),
    GetPage(name: Routes.sipDetails, page: () => SipDetailsScreen()),
    GetPage(name: Routes.switchFunds, page: () => const SwitchFundsScreen()),
    GetPage(name: Routes.redeemSip, page: () => const RedeemSipScreen()),
    GetPage(name: Routes.stepupSip, page: () => const StepupSipScreen()),
    GetPage(
      name: Routes.pauseSipRequest,
      page: () => const PauseSipRequestScreen(),
    ),
    GetPage(
      name: Routes.redeemRequest,
      page: () => const RedeemRequestScreen(),
    ),
    GetPage(
      name: Routes.stepupSipRequest,
      page: () => const StepupSipRequestScreen(),
    ),
  ];
}
