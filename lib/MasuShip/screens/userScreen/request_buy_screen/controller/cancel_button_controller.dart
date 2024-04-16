import 'package:firebase_database/firebase_database.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/historyData/historyTransactionData.dart';
import '../../../../Data/otherData/Tool.dart';

class cancel_order_button_controller {
  static Future<void> cancel_order(requestBuyOrder order) async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    if (order.status == 'B') {
      shipperAccount account = await type_one_wait_controller.get_shipper_account(order.shipper.id);
      await cancel_catch_order_discount(order, account);
    }
    order.status = 'E';
    order.S4time = getCurrentTime();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  static Future<void> cancel_catch_order_discount(requestBuyOrder order, shipperAccount shipper_account) async {
    double money = order.cost * (order.costFee.discount/100);
    shipper_account.money = shipper_account.money + money;
    shipper_account.orderHaveStatus = shipper_account.orderHaveStatus - 1;
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Account').child(shipper_account.id).set(shipper_account.toJson());
    historyTransactionData data = historyTransactionData(id: generateID(30), senderId: '', receiverId: shipper_account.id, transactionTime: getCurrentTime(), type: 6, content: 'Hoàn chiết khấu đơn: ' + order.id, money: money, area: shipper_account.area);
    await order_have_dialog_controller.push_history_data(data);
  }
}