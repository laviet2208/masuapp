import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/accountData/shopData/shopAccount.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/Data/firebase_interact/firebase_interact.dart';
import 'package:masuapp/MasuShip/Data/locationData/Location.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/restaurant_screen/food_order_screen/food_order_wait.dart';

import '../../../../../Data/otherData/Tool.dart';

class start_food_order_button extends StatefulWidget {
  final foodOrder order;
  const start_food_order_button({super.key, required this.order});

  @override
  State<start_food_order_button> createState() => _start_food_order_buttonState();
}

class _start_food_order_buttonState extends State<start_food_order_button> {
  bool loading = false;

  static Future<void> push_food_order_data(foodOrder order) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child('Order').child(order.id).set(order.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
            child: !loading ? Text(
              'Xác nhận đặt đơn',
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
        if (widget.order.locationGet.longitude != 0 && widget.order.locationGet.latitude != 0) {
          setState(() {
            loading = true;
          });
          widget.order.timeList[0] = getCurrentTime();
          await firebase_interact.pushVoucher(widget.order.voucher);
          await push_food_order_data(widget.order);
          setState(() {
            loading = false;
          });
          finalData.cartList.clear();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => food_order_wait(id: widget.order.id),),);
        } else {
          toastMessage('Vui lòng chọn điểm nhận');
        }
      },
    );
  }
}
