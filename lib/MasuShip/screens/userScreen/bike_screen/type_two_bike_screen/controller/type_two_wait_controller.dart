import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../Data/locationData/Location.dart';
import '../../../../../Data/otherData/Time.dart';
import '../../../../../Data/otherData/Tool.dart';
import '../../../../../Data/voucherData/Voucher.dart';

class type_two_wait_controller {
  static Stream<CatchOrder> getUnCompleteOrderDataStream(String id) {
    final reference = FirebaseDatabase.instance.reference();
    return reference.child('Order/' + id).onValue.map((event) {
      final dynamic order = event.snapshot.value;
      return CatchOrder.fromJson(order);
    });
  }

  static Future<void> push_new_order(CatchOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order/' + order.id).set(order.toJson());
  }
}

