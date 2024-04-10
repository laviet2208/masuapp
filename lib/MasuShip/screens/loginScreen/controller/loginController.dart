import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/costData/restaurantCost.dart';
import 'package:masuapp/MasuShip/Data/costData/weatherCost.dart';
import '../../../Data/accountData/Account.dart';
import '../../../Data/accountData/shipperAccount.dart';
import '../../../Data/accountData/userAccount.dart';
import '../../../Data/costData/Cost.dart';
import '../../../Data/finalData/finalData.dart';
import '../../../screens/loginScreen/enter_name_screen.dart';
import '../../../screens/shipperScreen/main_screen/shipper_main_screen.dart';

import '../../userScreen/main_screen/user_main_screen.dart';

class loginController {

  //Kiểm tra xem số điện thoại đã tồn tại chưa
  static Future<bool> checkData(String phoneNumber) async {
    String phone = '';
    if (phoneNumber[0] == '0') {
      phone = phoneNumber.substring(1);
    } else {
      phone = phoneNumber;
    }

    final reference = FirebaseDatabase.instance.reference().child('Account');
    final snapshot = await reference.orderByChild('phone').equalTo(phone).once();

    return snapshot.snapshot.value != null;
  }

  //Đẩy data account
  static Future<void> pushData(Account account) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account/" + account.id).set(account.toJson());
  }

  //Lấy data tài khoản
  static Future<void> getData(String phoneNumber, BuildContext context) async {
    String phonenum = '';
    if (phoneNumber[0] == '0') {
      phonenum = phoneNumber.substring(1);
    } else {
      phonenum = phoneNumber;
    }

    final reference = FirebaseDatabase.instance.reference();
    reference.child('Account').orderByChild('phone').equalTo(phonenum).onValue.listen((event) {
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if (value['phone'].toString() == phonenum) {
          if (value['license'] == null) {
            finalData.account = UserAccount.fromJson(value);
            finalData.user_account = UserAccount.fromJson(value);
            if (finalData.user_account.name == '') {
              getCost();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
            } else if (finalData.user_account.lockStatus == 1) {
              getCost();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
            }
          } else {
            finalData.account = shipperAccount.fromJson(value);
            finalData.shipper_account = shipperAccount.fromJson(value);
            getCost();
            print(finalData.bikeCost.toJson().toString());
            if (finalData.account.lockStatus == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
            }
          }
        }
      }
      );
    }).onDone(() {

    });
  }

  static void getCost() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child('CostFee').child(finalData.account.area).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      finalData.bikeCost = Cost.fromJson(data['Bike']);
      finalData.weathercost = weatherCost.fromJson(data['weatherCost']);
      finalData.restaurantcost = restaurantCost.fromJson(data['restaurantCost']);
    });
  }
}