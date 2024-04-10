import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_2_controller/receive_button_controller.dart';
import '../../../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../../../Data/historyData/historyTransactionData.dart';

class receive_button extends StatefulWidget {
  final CatchOrder order;
  const receive_button({super.key, required this.order,});

  @override
  State<receive_button> createState() => _receive_buttonState();
}

class _receive_buttonState extends State<receive_button> {
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            widget.order.status == 'B' ? 'Đã đón được khách' : 'Khách đã tới nơi',
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
          receive_button_controller.B_status_event(widget.order, context,);
        } else if (widget.order.status == 'C') {
          receive_button_controller.C_status_event(widget.order, context,);
        }
    },
    );
  }
}
