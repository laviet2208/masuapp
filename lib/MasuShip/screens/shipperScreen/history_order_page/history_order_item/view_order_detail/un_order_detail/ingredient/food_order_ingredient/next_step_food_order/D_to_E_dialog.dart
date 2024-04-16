import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/view_order_detail/un_order_detail/controller/food_order_un_catch_controller/food_order_un_catch_controller.dart';

class D_to_E_dialog extends StatefulWidget {
  final foodOrder order;
  const D_to_E_dialog({super.key, required this.order});

  @override
  State<D_to_E_dialog> createState() => _D_to_E_dialogState();
}

class _D_to_E_dialogState extends State<D_to_E_dialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bạn đã chắc chắn mua hết chưa?'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.order.status = 'E';
            widget.order.timeList[4] = getCurrentTime();
            await food_order_un_catch_controller.push_food_order_data(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(
                color: Colors.blueAccent
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
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
