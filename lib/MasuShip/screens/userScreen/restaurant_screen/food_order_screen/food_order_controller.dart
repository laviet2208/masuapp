import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/accountData/shipperAccount.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/controller/history_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';

class food_order_controller {
  static Future<double> getMaxCost(foodOrder order) async {
    double maxcost = 0;
    for (ShopAccount shop in order.shopList) {
      double l = 0;
      double cost = await getCost(order.locationGet, shop.location, l);
      if (cost > maxcost) {
        maxcost = cost;
      }
    }
    order.cost = maxcost;
    return maxcost;
  }

  static Future<double> getMaxDistance(foodOrder order) async {
    double maxdistance = 0;
    for (ShopAccount shop in order.shopList) {
      double cost = await getDistance(order.locationGet, shop.location);
      if (cost > maxdistance) {
        maxdistance = cost;
        order.locationSet = shop.location;
      }
    }
    return maxdistance;
  }

  static Future<void> cancel_order(foodOrder order) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    if (order.status == 'B') {
      shipperAccount account = await type_one_wait_controller.get_shipper_account(order.shipper.id);
      await cancel_food_order_discount(order, account);
    }
    await reference.child('Order').child(order.id).child('status').set('G2');
    reference = FirebaseDatabase.instance.reference();
    order.timeList[5] = getCurrentTime();
    await reference.child('Order').child(order.id).child('timeList').set(order.timeList.map((e) => e.toJson()).toList());
  }

  static Future<void> cancel_food_order_discount(foodOrder order, shipperAccount shipper_account) async {
    double money = order.cost * (order.costFee.discount/100);
    double res_discount_money = history_controller.get_discount_cost_of_restaurant(order.shopList, order.productList, order.resCost.discount);
    shipper_account.money = shipper_account.money + money;
    shipper_account.money = shipper_account.money + res_discount_money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    historyTransactionData data1 = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 8, content: 'Hoàn chiết khấu đơn: ' + order.id, money: res_discount_money, area: shipper_account.area);
    await order_have_dialog_controller.push_history_data(data);
    await order_have_dialog_controller.push_history_data(data1);
  }
}
