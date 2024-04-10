import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';

import '../../../type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_type_one_log_line.dart';

class order_log_type_3_ingredient extends StatelessWidget {
  final catchOrderType3 orderType3;
  const order_log_type_3_ingredient({super.key, required this.orderType3});

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

            order_type_one_log_line(currentStatus: orderType3.status, lineStatus: 'A', title: 'Đợi tài xế nhận đơn', time: orderType3.S1time,),

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

            order_type_one_log_line(currentStatus: orderType3.status, lineStatus: 'B', title: 'Tài xế đang đến', time: orderType3.S2time,),

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

            order_type_one_log_line(currentStatus: orderType3.status, lineStatus: 'C', title: 'Hành trình bắt đầu', time: orderType3.S3time,),

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

            order_type_one_log_line(currentStatus: orderType3.status, lineStatus: 'D' , title: orderType3.status == 'E' ? 'Đơn bị hủy' : 'Đơn hoàn thành', time: orderType3.S4time,),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}
