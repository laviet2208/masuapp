import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_1_controller/receive_button_controller.dart';
import '../../../../../../../Data/historyData/historyTransactionData.dart';
import '../../../../../../../Data/otherData/Tool.dart';
import '../../../../../../../Data/otherData/utils.dart';

class request_buy_controller {
  static Future<void> B_status_event(requestBuyOrder order, BuildContext context,) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Mua thành công'),
          content: Container(
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Chúc mừng, bạn đã mua xong',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                    )
                ),

                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Hãy đi giao ngay nhé',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                GestureDetector(
                  child: Container(
                    height: 45,
                    child: Center(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 30)/2,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Xác nhận',
                            style: TextStyle(
                                fontSize: 100,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),

                Container(height: 20,),
              ],
            ),
          ),
        );
      },
    );

    await receive_button_controller.change_order_time('S3time', order.id);
    await receive_button_controller.change_order_status('C', order.id);
  }

  static Future<void> C_status_event(requestBuyOrder order, BuildContext context,) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text('Giao hàng thành công'),
          content: Container(
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Chúc mừng, bạn đã giao',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 50,
                      ),
                    )
                ),

                Container(height: 20,),

                Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Hãy nhận thanh toán nhé',
                    style: TextStyle(
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Container(height: 20,),

                GestureDetector(
                  child: Container(
                    height: 45,
                    child: Center(
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 30)/2,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: AutoSizeText(
                            'Xác nhận',
                            style: TextStyle(
                                fontSize: 100,
                                fontFamily: 'roboto',
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),

                Container(height: 20,),
              ],
            ),
          ),
        );
      },
    );
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