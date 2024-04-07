import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../../../Data/OrderData/catchOrder.dart';

class type_one_wait_controller {
  static Future<CatchOrder> get_un_complete_order_data(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    Completer<CatchOrder> completer = Completer<CatchOrder>();
    reference.child('Order/' + id).onValue.listen((event) {
      final dynamic order = event.snapshot.value;
      CatchOrder order_parse = CatchOrder.fromJson(order);
      completer.complete(order_parse);
    });
    return completer.future;
  }

  static Stream<CatchOrder> get_stream_order_data(String id) {
    final reference = FirebaseDatabase.instance.reference();
    return reference.child('Order').child(id).onValue.map((event) {
      final dynamic order = event.snapshot.value;
      return CatchOrder.fromJson(order);
    });
  }

  static Future<void> cancel_order(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order/' + id).child('status').set('E');
  }

  static bool check_if_can_cancal(String status) {
    if (status == 'A' || status == 'B') {
      return true;
    }
    return false;
  }
}