import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/profile/profile_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../home/home_screen.dart';
import '../all_mutual_funds/all_mutual_funds_screen.dart';
import 'main_navigation_controller.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({super.key});

  final controller = Get.put(MainNavigationController());

  // Create screens once
  final List<Widget> _screens = [
    const HomeScreen(),
    AllMutualFundsScreen(),
    const _PlaceholderScreen(title: "Portfolio"),
    const _PlaceholderScreen(title: "SIP"),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primary500,
          unselectedItemColor: AppColors.grey400,
          selectedLabelStyle: AppTextStyles.body5Regular,
          unselectedLabelStyle: AppTextStyles.body5Regular,
          items: [
            BottomNavigationBarItem(
              icon: _navIcon("assets/icons/home_icon.svg", isSelected: false),
              activeIcon: _navIcon(
                "assets/icons/home_icon.svg",
                isSelected: true,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _navIcon("assets/icons/search_icon.svg", isSelected: false),
              activeIcon: _navIcon(
                "assets/icons/search_icon.svg",
                isSelected: true,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: _navIcon(
                "assets/icons/portfolio_icon.svg",
                isSelected: false,
              ),
              activeIcon: _navIcon(
                "assets/icons/portfolio_icon.svg",
                isSelected: true,
              ),
              label: "Portfolio",
            ),
            BottomNavigationBarItem(
              icon: _navIcon("assets/icons/sip_icon.svg", isSelected: false),
              activeIcon: _navIcon(
                "assets/icons/sip_icon.svg",
                isSelected: true,
              ),
              label: "SIP",
            ),
            BottomNavigationBarItem(
              icon: _navIcon(
                "assets/icons/profile_icon.svg",
                isSelected: false,
              ),
              activeIcon: _navIcon(
                "assets/icons/profile_icon.svg",
                isSelected: true,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(String asset, {required bool isSelected}) {
    return SizedBox(
      height: 16,
      width: 16,
      child: Center(
        child: SvgPicture.asset(
          asset,
          height: 22,
          width: 22,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.primary500 : AppColors.grey400,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Center(
        child: Text("$title Screen", style: AppTextStyles.h3SemiBold),
      ),
    );
  }
}
