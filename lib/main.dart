import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/app/routes.dart';
import 'package:phdcapital_mf_mobile/core/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      theme: AppTheme.lightTheme,
    );
  }
}
