import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/aadhaar_ekyc/aadhaar_ekyc_screen.dart';
import 'package:phdcapital_mf_mobile/modules/aadhaar_otp/aadhaar_otp_screen.dart';
import 'package:phdcapital_mf_mobile/modules/address_details/address_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/all_mutual_funds/all_mutual_funds_screen.dart';
import 'package:phdcapital_mf_mobile/modules/bank_account/bank_account_screen.dart';
import 'package:phdcapital_mf_mobile/modules/bank_verification/bank_verification_screen.dart';
import 'package:phdcapital_mf_mobile/modules/create_pin/create_pin_screen.dart';
import 'package:phdcapital_mf_mobile/modules/fund_details/fund_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/kyc/kyc_screen.dart';
import 'package:phdcapital_mf_mobile/modules/kyc_completed/kyc_completed_screen.dart';
import 'package:phdcapital_mf_mobile/modules/language/language_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login/login_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login_otp/otp_screen.dart';
import 'package:phdcapital_mf_mobile/modules/main_navigation/main_navigation_screen.dart';
import 'package:phdcapital_mf_mobile/modules/nominee/nominee_screen.dart';
import 'package:phdcapital_mf_mobile/modules/pan_verification/pan_verification_screen.dart';
import 'package:phdcapital_mf_mobile/modules/personal_details/personal_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/splash/splash_screen.dart';
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

  // KYC
  static const kyc = "/kyc";
  static const aadhaarKyc = "/aadhaar-kyc";
  static const aadhaarOtp = "/aadhaar-otp";
  static const uploadDocuments = "/upload-documents";
  static const videoKyc = "/video-kyc";
  static const kycCompleted = "/kyc-completed";

  // HOME
  static const home = "/home";
  static const allMutualFunds = "/all-mutual-funds";
  static const fundDetails = "/fund-details";
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

    // KYC
    GetPage(name: Routes.kyc, page: () => KycVerificationScreen()),
    GetPage(name: Routes.aadhaarKyc, page: () => AadhaarEkycScreen()),
    GetPage(name: Routes.aadhaarOtp, page: () => AadhaarOtpScreen()),
    GetPage(name: Routes.uploadDocuments, page: () => UploadDocumentsScreen()),
    GetPage(name: Routes.videoKyc, page: () => VideoKycScreen()),
    GetPage(name: Routes.kycCompleted, page: () => const KycCompletedScreen()),

    // HOME
    GetPage(name: Routes.home, page: () => MainNavigationScreen()),
    GetPage(name: Routes.allMutualFunds, page: () => AllMutualFundsScreen()),
    GetPage(name: Routes.fundDetails, page: () => FundDetailsScreen()),
  ];
}
