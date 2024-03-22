import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../FINAL/finalClass.dart';
import '../../GENERAL/NormalUser/accountNormal.dart';
import '../INUSER/SCREEN_MAIN/SCREENmain.dart';
import '../SHIPPERSCREEN/INUSER/SCREEN_MAIN/SCREENmain.dart';
import 'SCREEN_entername.dart';
import 'SCREEN_loginbyphonenum.dart';
import 'SCREEN_selectLocation.dart';
import 'SCREEN_wait.dart';

class SCREENfirstloading extends StatefulWidget {
  const SCREENfirstloading({Key? key}) : super(key: key);

  @override
  State<SCREENfirstloading> createState() => _SCREENfirstloadingState();
}

class _SCREENfirstloadingState extends State<SCREENfirstloading> {

  Future<void> getData(String phoneNumber) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('normalUser').onValue.listen((event) {
      final dynamic account = event.snapshot.value;
      account.forEach((key, value) {
        if ('+84' + value['phoneNum'].toString() == phoneNumber) {
          currentAccount.changeData(value);
          if (currentAccount.status == 0) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENentername()));
          } else if (currentAccount.status == 1 && currentAccount.type == 1) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENselectLocation()));
          } else if (currentAccount.status == 1 && currentAccount.type == 2) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
          } else if (currentAccount.status == 1 && currentAccount.type == 3) {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SCREENmainshipping()));
          }
        }
      }
      );
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
      Timer(const Duration(seconds: 5) , () => Navigator.push(context, MaterialPageRoute(builder:(context) => ScreenWait())));
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
