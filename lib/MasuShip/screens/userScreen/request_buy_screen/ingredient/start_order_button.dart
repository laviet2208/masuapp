import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/firebase_interact/firebase_interact.dart';
import 'package:masuapp/MasuShip/Data/otherData/Tool.dart';
import 'package:masuapp/MasuShip/Data/otherData/utils.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/controller/start_order_button_controller.dart';
import 'package:masuapp/MasuShip/screens/userScreen/request_buy_screen/request_buy_wait.dart';

class start_order_button extends StatefulWidget {
  final requestBuyOrder order;
  const start_order_button({super.key, required this.order});

  @override
  State<start_order_button> createState() => _start_order_buttonState();
}

class _start_order_buttonState extends State<start_order_button> {
  bool loading = false;
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
        if (start_order_request_buy_button_controller.check_if_order_can_push(widget.order)) {
          setState(() {
            loading = true;
          });
          widget.order.locationGet.mainText = await fetchLocationName(widget.order.locationGet);
          widget.order.cost = await start_order_request_buy_button_controller.getMaxCost(widget.order.buyLocation, widget.order.locationGet);
          widget.order.S1time = getCurrentTime();
          await firebase_interact.pushVoucher(widget.order.voucher);
          await start_order_request_buy_button_controller.push_buy_request_order_data(widget.order);
          setState(() {
            loading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => request_buy_wait(id: widget.order.id),),);
        } else {
          toastMessage('Bạn cần hoàn thiện thông tin');
        }
      },
    );
  }
}
