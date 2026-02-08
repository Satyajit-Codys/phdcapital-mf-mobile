import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/address_details/address_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/create_pin/create_pin_screen.dart';
import 'package:phdcapital_mf_mobile/modules/language/language_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login/login_screen.dart';
import 'package:phdcapital_mf_mobile/modules/login_otp/otp_screen.dart';
import 'package:phdcapital_mf_mobile/modules/nominee/nominee_screen.dart';
import 'package:phdcapital_mf_mobile/modules/pan_verification/pan_verification_screen.dart';
import 'package:phdcapital_mf_mobile/modules/personal_details/personal_details_screen.dart';
import 'package:phdcapital_mf_mobile/modules/splash/splash_screen.dart';
import 'package:phdcapital_mf_mobile/modules/welcome/welcome_screen.dart';

class Routes {
  static const splash = '/splash';
  static const language = '/language';
  static const welcome = '/welcome';
  static const login = "/login";
  static const otp = "/otp";
  static const createPin = "/create-pin";
  static const personalDetails = "/personal-details";
  static const panVerify = "/pan-verify";
  static const addressDetails = "/address-details";
  static const nominee = "/nominee";
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.language, page: () => LanguageScreen()),
    GetPage(name: Routes.welcome, page: () => WelcomeScreen()),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.otp, page: () => OtpScreen()),
    GetPage(name: Routes.createPin, page: () => CreatePinScreen()),
    GetPage(name: Routes.personalDetails, page: () => PersonalDetailsScreen()),
    GetPage(name: Routes.panVerify, page: () => PanVerificationScreen()),
    GetPage(name: Routes.addressDetails, page: () => AddressDetailsScreen()),
    GetPage(name: Routes.nominee, page: () => NomineeScreen()),
  ];
}
