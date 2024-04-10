import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/general/general_ingredient.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/ingredient/type_one_wait_ingredient/order_type_one_log_ingredient/order_type_one_log_line.dart';

class order_log_type_one_ingredient extends StatefulWidget {
  final Widget beforeWidget;
  final String id;
  const order_log_type_one_ingredient({super.key, required this.id, required this.beforeWidget});

  @override
  State<order_log_type_one_ingredient> createState() => _order_log_type_one_ingredientState();
}

class _order_log_type_one_ingredientState extends State<order_log_type_one_ingredient> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),

        child: StreamBuilder<CatchOrder>(
          stream: type_one_wait_controller.get_stream_order_data(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return general_ingredient.loading_container();
            }

            if (snapshot.hasError) {
              return general_ingredient.error_container();
            }

            if (!snapshot.hasData) {
              return general_ingredient.error_container();
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 30,),

                order_type_one_log_line(currentStatus: snapshot.data!.status, lineStatus: 'A', title: 'Đợi tài xế nhận đơn', time: snapshot.data!.S1time,),

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

                order_type_one_log_line(currentStatus: snapshot.data!.status, lineStatus: 'B', title: 'Tài xế ' + snapshot.data!.shipper.name + ' đang đến', time: snapshot.data!.S2time,),

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

                order_type_one_log_line(currentStatus: snapshot.data!.status, lineStatus: 'C', title: 'Hành trình bắt đầu', time: snapshot.data!.S3time,),

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

                order_type_one_log_line(currentStatus: snapshot.data!.status, lineStatus: 'D' , title: snapshot.data!.status == 'E' ? 'Đơn bị hủy' : 'Đơn hoàn thành', time: snapshot.data!.S4time,),

                Container(height: 20,),
              ],
            );
          },
        ),
      ),
    );
  }
}
