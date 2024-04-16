import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catchOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:masuapp/MasuShip/Data/OrderData/foodOrder/foodOrder.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_catch_order_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_catch_order_type_2_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_catch_order_type_3_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_express_order_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/uncomplete_item/un_food_order_item.dart';
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
    reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).onValue.listen((event) {
      un_complete_order_list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (value['shipper']['id'] == finalData.shipper_account.id) {
          if (value['timeList'] == null) {
            if (value['status'].toString() == 'B' || value['status'].toString() == 'C') {
              un_complete_order_list.add(value);
            }
          } else {
            if (value['status'].toString() == 'B' || value['status'].toString() == 'D' || value['status'].toString() == 'E') {
              un_complete_order_list.add(value);
            }
          }

        }
      });
      setState(() {

      });
    });
  }

  Widget getItem(int index) {
    if (un_complete_order_list[index]['resCost'] != null) {
      //item đơn mua đồ ăn
      return un_food_order_item(order: foodOrder.fromJson(un_complete_order_list[index]));
    } else if (un_complete_order_list[index]['receiver'] != null) {
      //item đơn express
      return un_express_order_item(order: expressOrder.fromJson(un_complete_order_list[index]));
    } else if (un_complete_order_list[index]['motherOrder'] != null) {
      //item đơn lái xe hộ
      return un_catch_order_type_3_item(order: catchOrderType3.fromJson(un_complete_order_list[index]));
    } else if (un_complete_order_list[index]['buyLocation'] != null) {
      //item đơn mua hộ
      return un_request_buy_order_item(order: requestBuyOrder.fromJson(un_complete_order_list[index]));
    } else if (double.parse(un_complete_order_list[index]['locationGet']['longitude'].toString()) == 0) {
      //đơn chỉ đường
      return un_catch_order_type_2_item(order: CatchOrder.fromJson(un_complete_order_list[index]));
    } else {
      return un_catch_order_item(order: CatchOrder.fromJson(un_complete_order_list[index]));
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
      alignment: Alignment.center,
      child: un_complete_order_list.length != 0 ? ListView.builder(
        itemCount: un_complete_order_list.length,
        padding: EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: getItem(index),
          );
        },
      ) : Text('Hiện không có đơn nào'),
    );
  }
}
