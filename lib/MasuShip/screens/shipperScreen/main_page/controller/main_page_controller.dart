import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import '../../../../Data/otherData/utils.dart';

class main_page_controller {
  static Future<void> switchOperatingStatus(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account/' + finalData.shipper_account.id + '/onlineStatus').set(status);
      if (status == 0) {
        toastMessage('Bạn đang ở trạng thái offline');
      }
      if (status == 1) {
        toastMessage('Bạn đang ở trạng thái online');
      }

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> CheckInAndCheckOut(BuildContext context, VoidCallback setStateEvent) async {
    if (finalData.shipper_account.onlineStatus == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xác nhận'),
            content: Text('Bạn có muốn bật hoạt động không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await main_page_controller.switchOperatingStatus(1);
                  finalData.lastOrderTime = DateTime.now().add(Duration(seconds: Random().nextInt(21) + 30));
                  Navigator.of(context).pop();
                  setStateEvent();
                },
                child: Text('Có', style: TextStyle(color: Colors.blue),),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('Không', style: TextStyle(color: Colors.redAccent),),
              ),
            ],
          );
        },
      );
    } else if (finalData.shipper_account.onlineStatus == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xác nhận'),
            content: Text('Bạn có muốn tắt hoạt động không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await main_page_controller.switchOperatingStatus(0);
                  Navigator.of(context).pop();
                  setStateEvent();
                },
                child: Text('Có', style: TextStyle(color: Colors.blue),),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('Không', style: TextStyle(color: Colors.redAccent),),
              ),
            ],
          );
        },
      );
    }
  }

}