import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masuapp/MasuShip/screens/loginScreen/login_screen.dart';

import '../../../GENERAL/utils/utils.dart';

class preview_screen extends StatefulWidget {
  const preview_screen({Key? key}) : super(key: key);

  @override
  State<preview_screen> createState() => _preview_screenState();
}

class _preview_screenState extends State<preview_screen> {
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
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 10,
                left: 15,
                right: 15,
                child: GestureDetector(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        border: Border.all(
                            width: 0.5,
                            color: Colors.black
                        )
                    ),
                    child: Center(
                      child: Text(
                        'Đăng nhập vào Masu Ship',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    getCurrentLocation().then((value) {
                      // currentLocatio.Longitude = value.longitude;
                      // currentLocatio.Latitude = value.latitude;
                      // print(currentLocatio.toJson().toString());

                    });
                    Navigator.push(context, MaterialPageRoute(builder:(context) => login_screen()));
                  },
                ),
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
