import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/accountData/shipperAccount.dart';
import 'package:masuapp/MasuShip/Data/firebase_interact/firebase_interact.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import '../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../Data/historyData/historyTransactionData.dart';

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

  static Future<void> cancel_order(CatchOrder order) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    if (order.status == 'B') {
      shipperAccount account = await get_shipper_account(order.shipper.id);
      await cancel_catch_order_discount(order, account);
    }
    order.status = 'E';
    order.S4time = getCurrentTime();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> cancel_catch_order_discount(CatchOrder order, shipperAccount shipper_account) async {
    double money = order.cost * (order.costFee.discount/100);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await order_have_dialog_controller.push_history_data(data);
  }
  
  static Future<shipperAccount> get_shipper_account(String id) async {
    final reference = FirebaseDatabase.instance.reference();
    dynamic orders;
    await reference.child("Account").child(id).once().then((DatabaseEvent event) {
      orders = event.snapshot.value;
    });
    return shipperAccount.fromJson(orders);
  }

  static bool check_if_can_cancel(String status) {
    if (status == 'A' || status == 'B') {
      return true;
    }
    return false;
  }
}