import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/utils/utils.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';

import '../../../../main_screen/user_main_screen.dart';

class cancel_order_button extends StatelessWidget {
  final CatchOrder order;
  const cancel_order_button({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: type_one_wait_controller.check_if_can_cancel(order.status) ? 45 : 0,
          decoration: type_one_wait_controller.check_if_can_cancel(order.status) != 0 ?  BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4), // màu của shadow
                spreadRadius: 2, // bán kính của shadow
                blurRadius: 7, // độ mờ của shadow
                offset: Offset(0, 3), // vị trí của shadow
              ),
            ],
          ) : null,
          child: Center(
            child: Text(
              'Hủy đơn hàng',
              style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () async {
          await type_one_wait_controller.cancel_order(order);
          toastMessage('Bạn đã hủy đơn thành công');
        },
      ),
    );
  }
}
