import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      bottomNavigationBar: _bottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              Divider(height: 1, thickness: 4, color: AppColors.grey50),
              _upcomingSip(),
              SizedBox(height: 12),
              Divider(height: 1, thickness: 4, color: AppColors.grey50),
              _marketSnapshot(),
              SizedBox(height: 24),
              Divider(height: 1, thickness: 4, color: AppColors.grey50),
              _holdings(),
              SizedBox(height: 24),
              Divider(height: 1, thickness: 4, color: AppColors.grey50),
              _recentTransactions(),
              const SizedBox(height: 24),
              Divider(height: 1, thickness: 4, color: AppColors.grey50),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------
  Widget _header() {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        children: [
          // 🎨 FULL BACKGROUND IMAGE (gradient + coins + jar)
          Positioned.fill(
            child: Image.asset(
              "assets/images/home_header.png", // 👈 your single image
              fit: BoxFit.cover,
            ),
          ),

          // 🧾 CONTENT OVERLAY
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topBar(),
                const Spacer(),

                Text(
                  "Total Portfolio Value",
                  style: AppTextStyles.body4Regular.copyWith(
                    color: AppColors.black60,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  "₹4,85,230",
                  style: AppTextStyles.h1Bold.copyWith(
                    color: AppColors.black100,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/icons/arrow_up_icon.svg",
                        color: AppColors.green500,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "₹2,340 (0.48%) Today",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.green500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: 120,
                  child: AppButton(title: "Invest now", onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Good Morning, Ritwik", style: AppTextStyles.body2SemiBold),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.primary50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary100, width: 2),
          ),
          child: Center(
            child: SizedBox(
              height: 22,
              width: 19,
              child: SvgPicture.asset("assets/icons/notification_icon.svg"),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // UPCOMING SIP
  // ---------------------------------------------------------------------------
  Widget _upcomingSip() {
    return _section(title: "Upcoming SIP", child: upcomingSipCard());
  }

  // ---------------------------------------------------------------------------
  // MARKET SNAPSHOT
  // ---------------------------------------------------------------------------
  Widget _marketSnapshot() {
    return _section(
      title: "Market Snapshot",
      child: Row(
        children: [
          Expanded(
            child: marketCard(
              title: "NIFTY 50",
              value: "22,450",
              change: "0.42%",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: marketCard(title: "Hybrid", value: "10%", change: "0.38%"),
          ),
        ],
      ),
    );
  }

  Widget marketCard({
    required String title,
    required String value,
    required String change,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey50, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 TOP CONTENT
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body5Regular.copyWith(
                    color: AppColors.grey600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(value, style: AppTextStyles.h3SemiBold),
              ],
            ),
          ),

          // 🟢 BOTTOM STRIP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.green50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: SvgPicture.asset(
                    "assets/icons/arrow_up_icon.svg",
                    height: 9,
                    width: 10,
                    colorFilter: const ColorFilter.mode(
                      AppColors.green500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  change,
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.green500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HOLDINGS
  // ---------------------------------------------------------------------------
  Widget _holdings() {
    return _section(
      title: "Your Holdings",
      trailing: "View All Holdings",
      child: Column(
        children: [
          _holdingTile(
            "Axis Blue-chip Fund",
            "+18.6%",
            "assets/icons/axis_icon.svg",
          ),
          const SizedBox(height: 12),
          _holdingTile(
            "SBI Small Cap Fund",
            "+24.1%",
            "assets/icons/sbi_icon.svg",
          ),
        ],
      ),
    );
  }

  Widget _holdingTile(String name, String returns, String icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 10),
              Text(name, style: AppTextStyles.body3SemiBold),
            ],
          ),
          Text(
            returns,
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.green500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TRANSACTIONS
  // ---------------------------------------------------------------------------
  Widget _recentTransactions() {
    return _section(
      title: "Recent Transaction",
      trailing: "View All",
      child: Column(
        children: [
          _transactionTile(
            "SIP-Axis",
            "Complete",
            AppColors.green500,
            "assets/icons/axis_icon.svg",
          ),
          const SizedBox(height: 12),
          _transactionTile(
            "Lumpsum-HDFC",
            "Pending",
            AppColors.orange500,
            "assets/icons/sbi_icon.svg",
          ),
        ],
      ),
    );
  }

  Widget _transactionTile(
    String title,
    String status,
    Color color,
    String icon,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 15),
            Text(title, style: AppTextStyles.body3SemiBold),
          ],
        ),

        Text(status, style: AppTextStyles.body5Regular.copyWith(color: color)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // COMMON SECTION WRAPPER
  // ---------------------------------------------------------------------------
  Widget _section({
    required String title,
    required Widget child,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.body4SemiBold.copyWith(
                  color: AppColors.grey950,
                ),
              ),
              if (trailing != null)
                Row(
                  children: [
                    Text(
                      trailing,
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SvgPicture.asset(
                        "assets/icons/arrow_right_icon.svg",
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget upcomingSipCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: AppColors.white100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔴 FUND ICON
          SizedBox(
            width: 36,
            height: 36,
            child: SvgPicture.asset(
              "assets/icons/axis_icon.svg",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 12),

          // 🧾 NAME + DATE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Axis Blue-chip Fund", style: AppTextStyles.body3SemiBold),
                const SizedBox(height: 4),
                Text(
                  "Debit on 28 Sep",
                  style: AppTextStyles.body5Regular.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),

          // 💰 AMOUNT
          Text(
            "₹5000",
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.green500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM NAV
  // ---------------------------------------------------------------------------
  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed, // 🔑 IMPORTANT
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primary500,
      unselectedItemColor: AppColors.grey400,

      selectedLabelStyle: AppTextStyles.body5Regular,
      unselectedLabelStyle: AppTextStyles.body5Regular,

      items: [
        BottomNavigationBarItem(
          icon: _navIcon("assets/icons/home_icon.svg"),
          activeIcon: _navIcon(
            "assets/icons/home_icon.svg",
            color: AppColors.primary500,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: _navIcon("assets/icons/search_icon.svg"),
          activeIcon: _navIcon(
            "assets/icons/search_icon.svg",
            color: AppColors.primary500,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: _navIcon("assets/icons/portfolio_icon.svg"),
          activeIcon: _navIcon(
            "assets/icons/portfolio_icon.svg",
            color: AppColors.primary500,
          ),
          label: "Portfolio",
        ),
        BottomNavigationBarItem(
          icon: _navIcon("assets/icons/sip_icon.svg"),
          activeIcon: _navIcon(
            "assets/icons/sip_icon.svg",
            color: AppColors.primary500,
          ),
          label: "SIP",
        ),
        BottomNavigationBarItem(
          icon: _navIcon("assets/icons/profile_icon.svg"),
          activeIcon: _navIcon(
            "assets/icons/profile_icon.svg",
            color: AppColors.primary500,
          ),
          label: "Profile",
        ),
      ],
    );
  }

  Widget _navIcon(String asset, {Color? color}) {
    return SizedBox(
      height: 16, // 👈 controls vertical alignment
      width: 16,
      child: Center(
        child: SvgPicture.asset(
          asset,
          height: 22,
          width: 22,
          colorFilter: color != null
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
