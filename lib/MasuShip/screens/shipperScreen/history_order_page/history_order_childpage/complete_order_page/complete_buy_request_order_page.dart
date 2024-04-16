import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/complete_item/complete_catch_order_item/complete_catch_order_people_item.dart';

import '../../../../../Data/OrderData/catchOrder.dart';
import '../../history_order_item/complete_item/complete_buy_request_order_item.dart';

class complete_buy_request_order_page extends StatefulWidget {
  const complete_buy_request_order_page({Key? key}) : super(key: key);

  @override
  State<complete_buy_request_order_page> createState() => _complete_buy_request_order_pageState();
}

class _complete_buy_request_order_pageState extends State<complete_buy_request_order_page> {

  List<requestBuyOrder> complete_buy_request_order_list = [];

  void get_complete_catch_order_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).onValue.listen((event) {
      complete_buy_request_order_list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['status'].toString() != 'A' || value['status'].toString() != 'B' || value['status'].toString() != 'C') {
          if (value['buyLocation'] != null) {
            complete_buy_request_order_list.add(requestBuyOrder.fromJson(value));
            setState(() {
              sortbypushtime(complete_buy_request_order_list);
            });
          }
        }
      });
    });
  }

  void sortbypushtime(List<requestBuyOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.S2time.year.compareTo(a.S2time.year) != 0
          ? b.S2time.year.compareTo(a.S2time.year)
          : (b.S2time.month.compareTo(a.S2time.month) != 0
          ? b.S2time.month.compareTo(a.S2time.month)
          : (b.S2time.day.compareTo(a.S2time.day) != 0
          ? b.S2time.day.compareTo(a.S2time.day)
          : (b.S2time.hour.compareTo(a.S2time.hour) != 0
          ? b.S2time.hour.compareTo(a.S2time.hour)
          : (b.S2time.minute.compareTo(a.S2time.minute) != 0
          ? b.S2time.minute.compareTo(a.S2time.minute)
          : b.S2time.second.compareTo(a.S2time.second)))));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_complete_catch_order_list();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
      ),
      child: ListView.builder(
        itemCount: complete_buy_request_order_list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: complete_buy_request_order_item(order: complete_buy_request_order_list[index]),
          );
        },
      ),
    );
  }
}
