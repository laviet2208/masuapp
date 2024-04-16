import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/next_step_food_order/B_to_C_dialog.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/next_step_food_order/C_to_D_dialog.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/next_step_food_order/D_to_E_dialog.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/ingredient/food_order_ingredient/next_step_food_order/E_to_F_dialog.dart';

class next_step_food_button extends StatelessWidget {
  final foodOrder order;
  const next_step_food_button({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    String status = '';
    if (order.status == 'B') {
      status = 'Xác nhận với khách';
    }

    if (order.status == 'C') {
      status = 'Xác nhận với quán';
    }

    if (order.status == 'D') {
      status = 'Đã mua được đủ món';
    }

    if (order.status == 'E') {
      status = 'Hoàn thành đơn';
    }

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: (order.status == 'F' || order.status == 'G' || order.status == 'G1' || order.status == 'G2' || order.status == 'G3' || order.status == 'G4') ? 0 : 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.yellow , Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
          ),
          child: Center(
            child: Text(
              status,
              style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        if (order.status == 'B') {
          showDialog(
            context: context,
            builder: (context) {
              return B_to_C_dialog(order: order);
            },
          );
        }

        if (order.status == 'C') {
          showDialog(
            context: context,
            builder: (context) {
              return C_to_D_dialog(order: order);
            },
          );
        }

        if (order.status == 'D') {
          showDialog(
            context: context,
            builder: (context) {
              return D_to_E_dialog(order: order);
            },
          );
        }

        if (order.status == 'E') {
          showDialog(
            context: context,
            builder: (context) {
              return E_to_F_dialog(order: order);
            },
          );
        }
      },
    );
  }
}
