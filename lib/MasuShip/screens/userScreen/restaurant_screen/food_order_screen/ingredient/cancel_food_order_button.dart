import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';

import '../../../../../Data/otherData/utils.dart';

class cancel_food_order_button extends StatefulWidget {
  final foodOrder order;
  const cancel_food_order_button({super.key, required this.order});

  @override
  State<cancel_food_order_button> createState() => _cancel_food_order_buttonState();
}

class _cancel_food_order_buttonState extends State<cancel_food_order_button> {
  bool loading = false;

  Future<void> cancel_order() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(widget.order.id).child('status').set('G2');
    reference = FirebaseDatabase.instance.reference();
    widget.order.timeList[5] = getCurrentTime();
    await reference.child('Order').child(widget.order.id).child('timeList').set(widget.order.timeList.map((e) => e.toJson()).toList());
  }


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
                color: Colors.grey.withOpacity(0.4), // màu của shadow
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
              'Hủy đơn hàng',
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
                !loading ? TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await cancel_order();
                    toastMessage('Bạn đã hủy đơn thành công');
                    setState(() {
                      loading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'muli'
                    ),
                  ),
                ) : CircularProgressIndicator(color: Colors.redAccent,),

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
