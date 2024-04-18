import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/firebase_interact/firebase_interact.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/screens/userScreen/express_screen/express_wait.dart';

class start_express_order_button extends StatefulWidget {
  final expressOrder order;
  const start_express_order_button({super.key, required this.order});

  @override
  State<start_express_order_button> createState() => _start_express_order_buttonState();
}

class _start_express_order_buttonState extends State<start_express_order_button> {
  bool loading = false;

  Future<void> push_express_order_data() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Order').child(widget.order.id).set(widget.order.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: 45,
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
              'Xác nhận và đặt đơn',
              style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ) : CircularProgressIndicator(color: Colors.black,),
          ),
        ),
        onTap: () async {
          setState(() {
            loading = true;
          });
          widget.order.S1time = getCurrentTime();
          widget.order.locationSet.mainText = await fetchLocationName(widget.order.locationSet);
          widget.order.cost = getCosOfBike(await getDistance(widget.order.locationSet, widget.order.locationGet));
          await firebase_interact.pushVoucher(widget.order.voucher);
          await push_express_order_data();
          setState(() {
            loading = false;
          });
          print(widget.order.id);
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => express_wait(id: widget.order.id)));
        },
      ),
    );
  }
}
