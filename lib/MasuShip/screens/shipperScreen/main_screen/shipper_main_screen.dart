import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:masuapp/MasuShip/Data/accountData/shipperAccount.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/controller/location_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/controller/shipper_controller.dart';

class shipper_main_screen extends StatefulWidget {
  const shipper_main_screen({Key? key}) : super(key: key);

  @override
  State<shipper_main_screen> createState() => _shipper_main_screenState();
}

class _shipper_main_screenState extends State<shipper_main_screen> {
  int indexPage = 0;
  late final Timer _timer;
  void getData() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(finalData.shipper_account.id).onValue.listen((event) {
      final dynamic account = event.snapshot.value;
      finalData.shipper_account = shipperAccount.fromJson(account);
      finalData.account = shipperAccount.fromJson(account);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    location_controller.getCurrentLocation();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (finalData.shipper_account.orderHaveStatus == 0 && finalData.shipper_account.onlineStatus == 1 && DateTime.now().difference(finalData.lastOrderTime).inMilliseconds >= 40500 && DateTime.now().difference(finalData.lastOrderTime).inSeconds % 10 == 0) {
        print('Gọi hàm lấy đơn tự động ' + finalData.lastOrderTime.millisecond.toString());
        await order_have_dialog_controller.Get_Order_Automatic1(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: shipper_controller.getBodyWidget(indexPage),

        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.yellow,
              gap: 8,
              onTabChange: (index) {
                setState(() {
                  indexPage = index;
                });
              },

              padding: EdgeInsets.all(12),
              tabs: const [
                GButton(
                  icon: Icons.rocket,
                  text: ("Trang chủ"),
                ),

                GButton(
                  icon: Icons.history,
                  text: ("Lịch sử"),
                ),

                GButton(
                  icon: Icons.notifications_active_outlined,
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
