import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:masuapp/SCREEN/INUSER/PAGE_NOTIFICATION/PageNotification.dart';
import '../../../FINAL/finalClass.dart';
import '../../../GENERAL/NormalUser/accountNormal.dart';
import '../../../GENERAL/Order/foodOrder.dart';
import '../../../GENERAL/utils/utils.dart';
import '../PAGE_ACCOUNTINFO/PAGEaccountinfo.dart';
import '../PAGE_ACTIVITY/PAGEactivity.dart';
import '../PAGE_COMMINGSOON/PAGEcommingsoon.dart';
import '../PAGE_HOME/PAGEhome.dart';

class SCREENmain extends StatefulWidget {
  const SCREENmain({Key? key}) : super(key: key);

  @override
  State<SCREENmain> createState() => _SCREENmainState();
}

class _SCREENmainState extends State<SCREENmain> {
  int selectedIndex = 0;
  final List<foodOrder> isShippingList = [];

  Widget getBodyWidget() {
    // Dựa vào selectedIndex, trả về phần body tương ứng
    switch (selectedIndex) {
      case 0 :
        return PAGEhome();
      case 1 :
        return PAGEactivity();
      case 2 :
        return PageNotification();
      case 3 :
        return PAGEaccountinfo();
      default:
        return PAGEcommingsoon();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData(currentAccount.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),

        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: screenWidth,
                child: getBodyWidget(),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Color.fromARGB(255, 244, 90, 36),
            tabBackgroundColor: Color.fromARGB(100, 200, 225, 252),
            gap: 8,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: ("Trang chủ"),
              ),

              GButton(
                icon: Icons.list_alt_outlined,
                text: ("Hoạt động"),
              ),

              GButton(
                icon: Icons.notifications,
                text: ("Thông báo"),
              ),

              GButton(
                icon: Icons.account_circle_sharp,
                text: ("Tài Khoản"),
              ),
            ],
          ),
        ),
      ),

    ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
