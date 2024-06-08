import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';

import '../../../../../Data/accountData/shipperAccount.dart';
import '../../../../../Data/costData/Cost.dart';
import '../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../Data/locationData/Location.dart';
import '../../../../../Data/otherData/Tool.dart';

class general_controller {
  static Future<double> get_total(List<Location> customerLocations, List<Location> bikeLocations, Location startLocation, Cost fee) async {
    double cost = 0;
    for (Location location in customerLocations) {
      cost = cost + await getShipCostByAPI(startLocation, location, 0, fee);
    }
    for (Location location in bikeLocations) {
      cost = cost + await getShipCostByAPI(startLocation, location, 0, fee);
    }
    return cost;
  }

  static Future<void> cancel_order(catchOrderType3 order) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    if (order.status == 'B') {
      shipperAccount account = await type_one_wait_controller.get_shipper_account(order.shipper.id);
      await cancel_catch_order_discount(order, account);
    }
    order.status = 'E';
    order.S4time = getCurrentTime();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> cancel_catch_order_discount(catchOrderType3 order, shipperAccount shipper_account) async {
    double money = getShipDiscount(order.cost, order.costFee);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await order_have_dialog_controller.push_history_data(data);
  }

  static Future<bool> check_if_complete_all_order(motherOrder order) async {
    bool check = true;
    final reference = FirebaseDatabase.instance.reference();
    for (int i = 0; i < order.orderList.length; i++) {
      await reference.child("Order").child(order.orderList[i]).once().then((DatabaseEvent event) {
        dynamic orders = event.snapshot.value;
        catchOrderType3 orderType3 = catchOrderType3.fromJson(orders);
        if (orderType3.status == 'A' || orderType3.status == 'B' || orderType3.status == 'C') {
          check = false;
        }
      });
    }
    return check;
  }
}