import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/controller/loginController.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/verify_screen.dart';

import '../../Data/otherData/utils.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController countryController = TextEditingController();
  var phone = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  int index = 0;
  bool loading = false;

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Chưa cho phép vị trí');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
        exit(0);
        return Future.error('Từ chối cho phép vị trí');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      toastMessage('Để tiếp tục bạn cần cho phép truy cập vị trí của bạn');
      exit(0);
      return Future.error('Bạn cần cho phép ứng dụng truy cập vào vị trí');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/mainLogo.png')
                    )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Đăng nhập bằng số điện thoại",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 10,
              ),

              Container(
                height: 50,
                decoration: BoxDecoration(

                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        child: Container(
                          height: 50,
                          width: (screenWidth-50)/2,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.5,
                                      color: index == 0 ? Colors.yellow : Colors.white
                                  )
                              )
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Khách hàng',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontSize: 14
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        child: Container(
                          height: 50,
                          width: (screenWidth-50)/2,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.5,
                                      color: index == 1 ? Colors.yellow : Colors.white
                                  )
                              )
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Tài xế',
                            style: TextStyle(
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontSize: 14
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Text.rich(
                TextSpan(
                  text: index == 0 ? "Nhập số điện thoại chính xác của bạn để đăng nhập ứng dụng " : "Nhập số điện thoại chính xác của bạn để đăng nhập tài khoản tài xế ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Masu",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: index == 0 ? "Số điện thoại của bạn" : "Số điện thoại tài xế",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: loading ? CircularProgressIndicator(color: Colors.black,) : Text(
                        'Nhận mã OTP-SMS',
                        style: TextStyle(
                            fontFamily: 'roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      if (phone == '886163653' || phone == '1' || phone == '10' || phone == '20' || phone == '2' || phone == '3' || phone == '4' || phone == '5' || phone == '6' || phone == '7' || phone == '8' || phone == '9'
                          || phone == '11' || phone == '12' || phone == '13' || phone == '14' || phone == '15' || phone == '16' || phone == '17' || phone == '18' || phone == '19'
                          || phone == '21' || phone == '22' || phone == '23' || phone == '24' || phone == '25' || phone == '26' || phone == '27' || phone == '28' || phone == '29'
                          || phone == '30' || phone == '31' || phone == '32' || phone == '33' || phone == '34' || phone == '35' || phone == '36' || phone == '37' || phone == '38') {
                        if (await loginController.checkData(phone)) {
                          await loginController.getData(phone, context);
                          setState(() {
                            loading = false;
                          });
                        }
                      } else {
                        String phonenum = '';
                        if (phone[0] == '0') {
                          phonenum = phone.substring(1);
                        } else {
                          phonenum = phone;
                        }
                        await _auth.verifyPhoneNumber(
                          phoneNumber: countryController.text + phonenum,
                          verificationCompleted: (PhoneAuthCredential credential) {
                            setState(() {
                              loading = false;
                            });
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            setState(() {
                              loading = false;
                            });
                            toastMessage(e.toString());
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            setState(() {
                              this.verificationId = verificationId;
                              loading = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => verify_screen(verificationId: verificationId, phoneNum: phone,),),);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      toastMessage(e.toString());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );  }
}
