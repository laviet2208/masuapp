import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';

import '../../../../../Data/otherData/utils.dart';

class cancel_order_button extends StatefulWidget {
  final catchOrderType3 orderType3;
  const cancel_order_button({super.key, required this.orderType3});

  @override
  State<cancel_order_button> createState() => _cancel_order_buttonState();
}

class _cancel_order_buttonState extends State<cancel_order_button> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: type_one_wait_controller.check_if_can_cancel(widget.orderType3.status) ? 45 : 0,
          decoration: type_one_wait_controller.check_if_can_cancel(widget.orderType3.status) != 0 ?  BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 1.0],
            ),
          ) : null,
          child: Center(
            child: !loading ? Text(
              'Hủy đơn hàng này',
              style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ) : CircularProgressIndicator(color: Colors.black,),
          ),
        ),
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Bạn xác nhận hủy đơn không?', style: TextStyle(fontFamily: 'muli', fontSize: 16),),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await type_one_wait_controller.cancel_order(widget.orderType3.id);
                      toastMessage('Bạn đã hủy đơn thành công');
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'muli'
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Hủy',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: 'muli'
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
