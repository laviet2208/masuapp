import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/complete_item/complete_catch_order_item.dart';

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
        print(value['status'].toString());
        if (value['status'].toString() == 'D' || value['status'].toString() != 'E' || value['status'].toString() != 'E1' || value['status'].toString() != 'E2') {
          if (value['productList'] != null) {
            complete_buy_request_order_list.add(requestBuyOrder.fromJson(value));
          }
        }
      });
      setState(() {

      });
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
      child: ListView.builder(
        itemCount: complete_buy_request_order_list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: complete_buy_request_order_item(order: complete_buy_request_order_list[index]),
          );
        },
      ),
    );
  }
}
