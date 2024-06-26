import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/controller/location_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/history_page/history_page.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_page/ingredient/jump_in_ads/jump_in_ads_dialog.dart';
import 'package:masuapp/MasuShip/screens/userScreen/notice_page/notice_page.dart';
import '../account_screen/account_page.dart';
import '../main_page/main_page.dart';

class user_main_screen extends StatefulWidget {
  const user_main_screen({super.key});

  @override
  State<user_main_screen> createState() => _user_main_screenState();
}

class _user_main_screenState extends State<user_main_screen> {
  int selectedPage = 0;

  Widget get_body_widget() {
    if (selectedPage == 0) {
      return main_page();
    }
    if (selectedPage == 1) {
      return notice_page();
    }
    if (selectedPage == 2) {
      return history_page();
    }
    if (selectedPage == 3) {
      return account_page();
    }
    return Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location_controller.getCurrentLocation();
    if (finalData.jumpAds) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return jump_in_ads_dialog();
          },
        );
      });
      finalData.jumpAds = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: get_body_widget(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.yellow.withOpacity(0.4),
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
            ),
            backgroundColor: Colors.yellowAccent.withOpacity(0.05),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,

          ),
          child: NavigationBar(
            height: 70,
            selectedIndex: selectedPage,
            onDestinationSelected: (selectedPage) => setState(() {this.selectedPage = selectedPage;}),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.rocket_outlined),
                label: 'Trang chủ',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_active_outlined),
                label: 'Thông báo',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                label: 'Lịch sử',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Tài khoản',
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
