import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_catch_order_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_catch_order_type_2_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_request_buy_order_item.dart';

import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

class un_complete_order_page extends StatefulWidget {
  const un_complete_order_page({Key? key}) : super(key: key);

  @override
  State<un_complete_order_page> createState() => _un_complete_order_pageState();
}

class _un_complete_order_pageState extends State<un_complete_order_page> {
  List<dynamic> un_complete_order_list = [];

  void get_un_complete_order_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('status').equalTo('B').onValue.listen((event) {
      un_complete_order_list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['shipper']['id'] == finalData.shipper_account.id) {
          un_complete_order_list.add(value);
        }
      });
      setState(() {

      });
    });
  }

  Widget getItem(int index) {
    if (un_complete_order_list[index]['productList'] == null) {
      if (double.parse(un_complete_order_list[index]['locationGet']['longitude'].toString()) == 0) {
        return un_catch_order_type_2_item(order: CatchOrder.fromJson(un_complete_order_list[index]));
      } else {
        return un_catch_order_item(order: CatchOrder.fromJson(un_complete_order_list[index]));
      }

    } else {
      return un_request_buy_order_item(order: requestBuyOrder.fromJson(un_complete_order_list[index]));
    }
    return Container(height: 0,);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_un_complete_order_list();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: un_complete_order_list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: getItem(index),
          );
        },
      ),
    );
  }
}
