import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/screens/userScreen/bike_screen/type_one_bike_screen/controller/type_one_wait_controller.dart';

import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../../Data/otherData/utils.dart';

class cancel_button extends StatefulWidget {
  final requestBuyOrder order;
  const cancel_button({super.key, required this.order});

  @override
  State<cancel_button> createState() => _cancel_buttonState();
}

class _cancel_buttonState extends State<cancel_button> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: widget.order.status == 'A' ? 45 : 0,
          decoration: widget.order.status == 'A' ?  BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // màu của shadow
                spreadRadius: 2, // bán kính của shadow
                blurRadius: 7, // độ mờ của shadow
                offset: Offset(0, 3), // vị trí của shadow
              ),
            ],
            gradient: LinearGradient(
              colors: [Colors.white, Colors.yellow],
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
                    await type_one_wait_controller.cancel_order(widget.order.id);
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
    );
  }
}

