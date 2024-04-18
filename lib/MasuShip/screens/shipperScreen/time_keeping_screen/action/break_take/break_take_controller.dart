import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/accountData/timeKeeping.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../../Data/otherData/Time.dart';

class break_take_controller {
  static Future<void> push_keeping_request(timeKeeping keeping) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("timeKeeping/" + keeping.id).set(keeping.toJson());
  }

  static Future<bool> check_if_can_keeping_request(Time time) async {
    bool check = true;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("timeKeeping").orderByChild('owner/id').equalTo(finalData.shipper_account.id).once().then((DatabaseEvent event) async {
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        timeKeeping keeping= timeKeeping.fromJson(value);
        if (keeping.dayOff.day == time.day && keeping.dayOff.month == time.month && keeping.dayOff.year == time.year) {
          if (keeping.status == 0 || keeping.status == 2) {
            check = false;
          }
        }
      });
    });
    return check;
  }
}