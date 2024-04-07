import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/catch_type_2_controller/receive_button_controller.dart';
import '../../../../../../../../Data/OrderData/catchOrder.dart';
import '../../../../../../../../Data/historyData/historyTransactionData.dart';

class receive_button extends StatefulWidget {
  final CatchOrder order;
  const receive_button({super.key, required this.order});

  @override
  State<receive_button> createState() => _receive_buttonState();
}

class _receive_buttonState extends State<receive_button> {
  bool loading = false;
  String status_text_button = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status == 'B') {
      status_text_button = 'Đã đón khách';
    }
    if (widget.order.status == 'C') {
      status_text_button = 'Đã hoàn thành';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.yellow.shade600,
              borderRadius: BorderRadius.circular(5)
          ),
          alignment: Alignment.center,
          child: Text(
            status_text_button,
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
          receive_button_controller.B_status_event(widget.order, context);
          setState(() {
            if (widget.order.status == 'B') {
              status_text_button = 'Đã đón khách';
            }
            if (widget.order.status == 'C') {
              status_text_button = 'Đã hoàn thành';
            }
          });
        } else if (widget.order.status == 'C') {
          receive_button_controller.C_status_event(widget.order, context);
          setState(() {
            if (widget.order.status == 'B') {
              status_text_button = 'Đã đón khách';
            }
            if (widget.order.status == 'C') {
              status_text_button = 'Đã hoàn thành';
            }
          });
        }
    },
    );
  }
}
