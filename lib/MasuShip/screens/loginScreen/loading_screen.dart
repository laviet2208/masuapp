import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/costData/Cost.dart';
import 'package:masuapp/MasuShip/Data/costData/restaurantCost.dart';
import 'package:masuapp/MasuShip/Data/costData/weatherCost.dart';
import '../../Data/accountData/shipperAccount.dart';
import '../../Data/accountData/userAccount.dart';
import '../../Data/finalData/finalData.dart';
import '../../Data/otherData/Tool.dart';
import '../../screens/loginScreen/preview_screen.dart';

import '../shipperScreen/main_screen/shipper_main_screen.dart';
import 'enter_name_screen.dart';

class loading_screen extends StatefulWidget {
  const loading_screen({Key? key}) : super(key: key);

  @override
  State<loading_screen> createState() => _loading_screenState();
}

class _loading_screenState extends State<loading_screen> {

  Future<void> getData(String phoneNumber) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').onValue.listen((event) {
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if ('+84' + value['phone'].toString() == phoneNumber) {
          if (value['license'] == null) {
            finalData.account = UserAccount.fromJson(value);
            if (finalData.account.name == '') {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => enter_name_screen(),),);
            } else if (finalData.account.lockStatus == 1) {

            } else {
              // tài khoản bị khóa
            }

          } else {
            finalData.account = shipperAccount.fromJson(value);
            finalData.shipper_account = shipperAccount.fromJson(value);
            if (finalData.account.lockStatus == 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => shipper_main_screen()));
            } else {
              //Tài khoản khách bị khóa
            }
          }
        }
      }
      );
    });
  }

  Future<void> getCost() async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('CostFee').child(finalData.user_account.area).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      finalData.bikeCost = Cost.fromJson(data['Bike']);
      finalData.weathercost = weatherCost.fromJson(data['weatherCost']);
      finalData.restaurantcost = restaurantCost.fromJson(data['restaurantCost']);
    });
  }

  final auth = FirebaseAuth.instance;

  void asyncMethod(String phone) async {
    await getData(phone);
    await getCost();
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
          Positioned(
            top: screenHeight/3,
            left: (screenWidth-screenWidth/2.5)/2,
            child: Container(
              width: screenWidth/2.5,
              height: screenWidth/2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/mainLogo.png"),
                  )
              ),
            ),
          ),

          Positioned(
            top: screenHeight/3 + screenWidth/1.5,
            left: (screenWidth - MediaQuery.of(context).size.height * 0.05)/2,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.03,
              height: MediaQuery.of(context).size.height * 0.03,
              child: CircularProgressIndicator(
                value: null,
                color: Color.fromARGB(255, 250, 241, 76),
              ),
            ),
          )
        ],
      ),
    );

  }
}
