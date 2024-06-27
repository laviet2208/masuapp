import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/controller/view_catch_order_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/main_screen/controller/location_controller.dart';
import '../../../../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../../../Data/otherData/utils.dart';

class receive_button_controller {
  static Future<void> B_status_event(CatchOrder order, BuildContext context,) async {
    view_catch_order_controller.show_B_dialog(context, MediaQuery.of(context).size.width - 30);
    await change_order_time('S3time', order.id);
    await change_order_status('C', order.id);
  }

  static Future<void> C_status_event(CatchOrder order, BuildContext context,) async {
    view_catch_order_controller.show_C_dialog(context, MediaQuery.of(context).size.width - 30);
    location_controller.getCurrentLocation();
    await change_end_location(finalData.shipper_account.location, order.id);
    await change_order_status('D', order.id);
    double distance = await getDistance(order.locationSet, finalData.shipper_account.location);
    await change_order_cost(getShipCost(distance, order.costFee), order.id);
    double money = getShipDiscount(getShipCost(distance, order.costFee), order.costFee);
    finalData.shipper_account.money = finalData.shipper_account.money - money;
    await order_have_dialog_controller.change_shipper_money();
    await change_order_time('S4time', order.id);
    finalData.lastOrderTime = DateTime.now().add(Duration(seconds: Random().nextInt(21) + 30));
    finalData.shipper_account.orderHaveStatus = 0;
    await order_have_dialog_controller.push_history_data(historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 5, content: 'Chiết khấu đơn ' + order.id, money: money, area: finalData.shipper_account.area));
    await order_have_dialog_controller.change_Have_Order_Status(0);
    toastMessage('Đã hoàn thành đơn');
  }

  static Future<void> change_order_status(String status, String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('status').set(status);
  }

  static Future<void> change_order_time(String time, String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child(time).set(getCurrentTime().toJson());
  }

  static Future<void> change_order_cost(double cost, String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(id).child('cost').set(cost);
  }

  static Future<void> change_end_location(Location location, String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    finalData.shipper_account.location.mainText = await fetchLocationName(finalData.shipper_account.location);
    await databaseRef.child('Order').child(id).child('locationGet').set(location.toJson());
  }
}