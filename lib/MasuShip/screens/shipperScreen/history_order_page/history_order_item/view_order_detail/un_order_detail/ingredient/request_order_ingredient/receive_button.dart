import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_1_controller/receive_button_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/request_buy_controller.dart';

class receive_button extends StatefulWidget {
  final requestBuyOrder order;
  const receive_button({super.key, required this.order,});

  @override
  State<receive_button> createState() => _receive_buttonState();
}

class _receive_buttonState extends State<receive_button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: (widget.order.status == 'B' || widget.order.status == 'C') ? 45 : 0,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(5)
          ),
          alignment: Alignment.center,
          child: Text(
            widget.order.status == 'B' ? 'Đã mua xong hàng' : 'Đã giao cho khách',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      onTap: () async {
        if (widget.order.status == 'B') {
          request_buy_controller.B_status_event(widget.order, context,);
        } else if (widget.order.status == 'C') {
          request_buy_controller.C_status_event(widget.order, context,);
        }
      },
    );
  }
}
