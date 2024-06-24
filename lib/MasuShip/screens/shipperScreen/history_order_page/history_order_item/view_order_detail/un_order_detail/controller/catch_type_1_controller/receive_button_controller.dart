import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Time.dart';
import 'package:masuapp/MasuShip/Data/voucherData/Voucher.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/controller/view_catch_order_controller.dart';

import '../../../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../../../../Data/locationData/Location.dart';
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
    await change_order_status('D', order.id);
    await change_order_time('S4time', order.id);
    finalData.lastOrderTime = DateTime.now().add(Duration(seconds: Random().nextInt(21) + 30));
    if (order.voucher.id != '') {
      finalData.shipper_account.money = finalData.shipper_account.money + getVoucherSale(order.voucher, order.cost);
      await change_shipper_money();
      historyTransactionData his = historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 7, content: order.id, money: getVoucherSale(order.voucher, order.cost), area: order.owner.area);
      await order_have_dialog_controller.push_history_data(his);
    }

    finalData.shipper_account.orderHaveStatus = 0;
    await order_have_dialog_controller.change_Have_Order_Status(0);
    toastMessage('Đã hoàn thành đơn');
  }

  static Future<motherOrder> getMother(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    motherOrder order = motherOrder(id: '', locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: finalData.user_account, shipper: finalData.shipper_account, status: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 1, Otype: '', perCustom: 1, CustomList: [], maxSale: 0, area: ''), createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), orderList: []);
    await reference.child('Order').child(id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      order = motherOrder.fromJson(data);

    });
    return order;
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

  static Future<void> change_shipper_money() async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Account/' + finalData.shipper_account.id + '/money').set(finalData.shipper_account.money);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }
}