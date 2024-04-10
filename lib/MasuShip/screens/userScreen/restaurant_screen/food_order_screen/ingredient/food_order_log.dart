import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';

import '../../../bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_type_one_log_line.dart';

class food_order_log extends StatelessWidget {
  final foodOrder order;
  const food_order_log({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 30,),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'A', title: 'Đợi tài xế nhận đơn', time: order.timeList[0],),

            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 1,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'B', title: 'Đợi tài xế xác nhận', time: order.timeList[1],),

            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 1,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'C', title: 'Đợi nhà hàng xác nhận', time: order.timeList[2],),

            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 1,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'D', title: 'Tài xế mua thành công', time: order.timeList[3],),

            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 1,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'E', title: 'Tài xế đang giao hàng', time: order.timeList[4],),

            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25, top: 4, bottom: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 1,
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                ),
              ),
            ),

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'F' , title: (order.status == 'G2') ? 'Đơn bị hủy' : 'Đơn hoàn thành', time: order.timeList[5],),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}

