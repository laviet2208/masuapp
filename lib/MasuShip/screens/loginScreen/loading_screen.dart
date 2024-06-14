import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/costData/Cost.dart';
import 'package:masuapp/MasuShip/Data/costData/restaurantCost.dart';
import 'package:masuapp/MasuShip/Data/costData/weatherCost.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/controller/loginController.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/login_screen.dart';
import 'package:masuapp/MasuShip/screens/userScreen/main_screen/user_main_screen.dart';
import '../../Data/accountData/shipperAccount.dart';
import '../../Data/accountData/userAccount.dart';
import '../../Data/finalData/finalData.dart';
import '../../Data/locationData/Location.dart';
import '../../Data/otherData/Tool.dart';
import '../../Data/otherData/utils.dart';
import '../../screens/loginScreen/preview_screen.dart';
import '../shipperScreen/main_screen/shipper_main_screen.dart';
import 'enter_name_screen.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({Key? key}) : super(key: key);

  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {

  String get_phoneNum(String phone) {
    if (phone[0] == '0') {
      return phone.substring(1);
    }
    return phone;
  }

  Future<void> getData(String phoneNumber) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').orderByChild('phone').equalTo(phoneNumber.substring(3)).onValue.listen((event) async {
      final dynamic account = event.snapshot.value;
      if (account != null) {
        if (account['license'] == null) {
          finalData.account = UserAccount.fromJson(account);
          finalData.user_account = UserAccount.fromJson(account);
          if (finalData.user_account.name == '') {
            await getCost();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
          } else if (finalData.user_account.lockStatus == 1) {
            await getCost();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
          } else {
            toastMessage('Tài khoản bị khóa, vui lòng kiểm tra lại');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
          }
        } else {
          finalData.account = shipperAccount.fromJson(account);
          finalData.shipper_account = shipperAccount.fromJson(account);
          if (finalData.account.lockStatus == 1) {
            await getCost();
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
          } else {
            toastMessage('Tài khoản bị khóa, vui lòng kiểm tra lại');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => login_screen(),),);
          }
        }
      } else {
        print(phoneNumber.substring(3));
        finalData.user_account = UserAccount(
          id: generateID(15),
          createTime: getCurrentTime(),
          lockStatus: 1,
          name: '',
          area: 'ineSi92oGc1ZDlBBlddo',
          phone: phoneNumber.substring(3),
          location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
        );

        await loginController.pushData(finalData.user_account);
        await getCost();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
      }

      // account.forEach((key, value) async {
      //   if ('+84' + get_phoneNum(value['phone'].toString()) == phoneNumber) {
      //     if (value['license'] == null) {
      //       finalData.account = UserAccount.fromJson(value);
      //       finalData.user_account = UserAccount.fromJson(value);
      //       if (finalData.user_account.name == '') {
      //         await getCost();
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
      //       } else if (finalData.user_account.lockStatus == 1) {
      //         await getCost();
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => user_main_screen(),),);
      //       } else {
      //         // tài khoản bị khóa
      //       }
      //     } else {
      //       finalData.account = shipperAccount.fromJson(value);
      //       finalData.shipper_account = shipperAccount.fromJson(value);
      //       if (finalData.account.lockStatus == 1) {
      //         await getCost();
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
      //       } else {
      //         //Tài khoản khách bị khóa
      //       }
      //     }
      //   }
      // });
    });
  }

  Future<void> getCost() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('CostFee').child(finalData.user_account.area).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      finalData.bikeShipCost = Cost.fromJson(data['bikeShipCost']);
      finalData.expressShipCost = Cost.fromJson(data['expressShipCost']);
      finalData.requestBuyShipCost = Cost.fromJson(data['requestBuyShipCost']);
      finalData.foodShipCost = Cost.fromJson(data['foodShipCost']);
      finalData.weathercost = weatherCost.fromJson(data['weatherCost']);
      finalData.restaurantcost = restaurantCost.fromJson(data['restaurantCost']);
    });
  }

  final auth = FirebaseAuth.instance;

  void asyncMethod(String phone) async {
    await getData(phone);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = auth.currentUser;
    if (user != null){
      print(user.phoneNumber.toString());
      asyncMethod(user.phoneNumber.toString());
    } else {
      Timer(const Duration(seconds: 5) , () => Navigator.push(context, MaterialPageRoute(builder:(context) => preview_screen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white
      ),
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: <Widget>[
          // Positioned(
          //   top: screenHeight/3,
          //   left: (screenWidth-screenWidth/2.5)/2,
          //   child: Container(
          //     width: screenWidth/2.5,
          //     height: screenWidth/2.5,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage("assets/image/mainLogo.png"),
          //         )
          //     ),
          //   ),
          // ),
          //
          // Positioned(
          //   top: screenHeight/3 + screenWidth/1.5,
          //   left: (screenWidth - MediaQuery.of(context).size.height * 0.05)/2,
          //   child: Container(
          //     width: MediaQuery.of(context).size.height * 0.03,
          //     height: MediaQuery.of(context).size.height * 0.03,
          //     child: CircularProgressIndicator(
          //       value: null,
          //       color: Color.fromARGB(255, 250, 241, 76),
          //     ),
          //   ),
          // ),

          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/background.png'),
                    fit: BoxFit.fitHeight,
                  )
              ),
            ),
          ),
        ],
      ),
    );

  }
}
