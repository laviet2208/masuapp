import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/divide_order_for_driver/controller/order_have_dialog_controller.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/food_order_un_catch_controller/food_order_un_catch_controller.dart';

class E_to_F_dialog extends StatefulWidget {
  final foodOrder order;
  const E_to_F_dialog({super.key, required this.order});

  @override
  State<E_to_F_dialog> createState() => _E_to_F_dialogState();
}

class _E_to_F_dialogState extends State<E_to_F_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hoàn thành đơn?'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.order.status = 'F';
            widget.order.timeList[5] = getCurrentTime();
            await food_order_un_catch_controller.push_food_order_data(widget.order);
            finalData.shipper_account.orderHaveStatus = 0;
            await order_have_dialog_controller.change_Have_Order_Status(0);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Đã hoàn thành',
            style: TextStyle(
                color: Colors.blueAccent
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.order.status = 'G4';
            widget.order.timeList[5] = getCurrentTime();
            await food_order_un_catch_controller.push_food_order_data(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Khách boom hàng',
            style: TextStyle(
                color: Colors.red
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
