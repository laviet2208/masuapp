import 'dart:math';

import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_1_controller/receive_button_controller.dart';

import '../../../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../../Data/otherData/utils.dart';

class express_order_controller {
  static Future<void> C_status_event(expressOrder order) async {
    await receive_button_controller.change_order_status('D', order.id);
    await receive_button_controller.change_order_time('S4time', order.id);
    finalData.lastOrderTime = DateTime.now().add(Duration(seconds: Random().nextInt(21) + 30));
    if (order.voucher.id != '') {
      finalData.shipper_account.money = finalData.shipper_account.money + getVoucherSale(order.voucher, order.cost);
      await receive_button_controller.change_shipper_money();
      historyTransactionData his = historyTransactionData(id: generateID(30), senderId: '', receiverId: finalData.shipper_account.id, transactionTime: getCurrentTime(), type: 7, content: order.id, money: getVoucherSale(order.voucher, order.cost), area: order.owner.area);
      await order_have_dialog_controller.push_history_data(his);
    }
    finalData.shipper_account.orderHaveStatus = 0;
    await order_have_dialog_controller.change_Have_Order_Status(0);
    toastMessage('Đã hoàn thành đơn');
  }
}