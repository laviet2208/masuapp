import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/firebase_interact/firebase_interact.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/food_order_un_catch_controller/food_order_un_catch_controller.dart';

class C_to_D_dialog extends StatefulWidget {
  final foodOrder order;
  const C_to_D_dialog({super.key, required this.order});

  @override
  State<C_to_D_dialog> createState() => _C_to_D_dialogState();
}

class _C_to_D_dialogState extends State<C_to_D_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Quán có xác nhận không?'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.order.status = 'D';
            widget.order.timeList[3] = getCurrentTime();
            await food_order_un_catch_controller.push_food_order_data(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Đã xác nhận',
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
            widget.order.status = 'G';
            widget.order.timeList[5] = getCurrentTime();
            await firebase_interact.cancel_food_order_discount(widget.order);
            await food_order_un_catch_controller.push_food_order_data(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Không xác nhận',
            style: TextStyle(
                color: Colors.red
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
