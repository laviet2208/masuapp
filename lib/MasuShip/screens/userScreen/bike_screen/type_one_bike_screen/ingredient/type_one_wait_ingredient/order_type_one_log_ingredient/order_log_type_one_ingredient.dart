import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/general/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_type_one_log_line.dart';

class order_log_type_one_ingredient extends StatelessWidget {
  final CatchOrder order;
  const order_log_type_one_ingredient({super.key, required this.order});

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

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'A', title: 'Đợi tài xế nhận đơn', time: order.S1time,),

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

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'B', title: 'Tài xế ' + order.shipper.name + ' đang đến', time: order.S2time,),

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

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'C', title: 'Hành trình bắt đầu', time: order.S3time,),

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

            order_type_one_log_line(currentStatus: order.status, lineStatus: 'D' , title: order.status == 'E' ? 'Đơn bị hủy' : 'Đơn hoàn thành', time: order.S4time,),

            Container(height: 20,),
          ],
        ),
      ),
    );
  }
}
