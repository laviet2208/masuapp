import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/complete_item/complete_catch_order_item/complete_catch_order_bike_item.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/complete_item/complete_catch_order_item/complete_catch_order_people_item.dart';

import '../../../../../Data/OrderData/catchOrder.dart';

class complete_catch_order_page extends StatefulWidget {
  const complete_catch_order_page({Key? key}) : super(key: key);

  @override
  State<complete_catch_order_page> createState() => _complete_catch_order_pageState();
}

class _complete_catch_order_pageState extends State<complete_catch_order_page> {
  List<CatchOrder> orderList = [];
  List<CatchOrder> chosenList = [];

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        if (value['buyLocation'] == null && value['timeList'] == null && value['weightType'] == null && value['orderList'] == null) {
          if (value['motherOrder'] != null) {
            catchOrderType3 catchOrder = catchOrderType3.fromJson(value);
            if (catchOrder.status != 'A' || catchOrder.status != 'B' || catchOrder.status != 'C') {
              orderList.add(catchOrder);
              chosenList.add(catchOrder);
            }
          } else {
            CatchOrder catchOrder = CatchOrder.fromJson(value);
            if (catchOrder.status != 'A' || catchOrder.status != 'B' || catchOrder.status != 'C') {
              orderList.add(catchOrder);
              chosenList.add(catchOrder);
            }
          }
          setState(() {sortbypushtime(chosenList);});
        }
      });

    });
  }

  void sortbypushtime(List<CatchOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.S1time.year.compareTo(a.S1time.year) != 0
          ? b.S1time.year.compareTo(a.S1time.year)
          : (b.S1time.month.compareTo(a.S1time.month) != 0
          ? b.S1time.month.compareTo(a.S1time.month)
          : (b.S1time.day.compareTo(a.S1time.day) != 0
          ? b.S1time.day.compareTo(a.S1time.day)
          : (b.S1time.hour.compareTo(a.S1time.hour) != 0
          ? b.S1time.hour.compareTo(a.S1time.hour)
          : (b.S1time.minute.compareTo(a.S1time.minute) != 0
          ? b.S1time.minute.compareTo(a.S1time.minute)
          : b.S1time.second.compareTo(a.S1time.second)))));
    });
  }

  Widget get_catch_order_item(CatchOrder order) {
    if (order.toJson()['motherOrder'] == null) {
      return complete_catch_order_people_item(order: order);
    }
    return complete_catch_order_bike_item(order: catchOrderType3.fromJson(order.toJson()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: ListView.builder(
          itemCount: chosenList.length,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: get_catch_order_item(chosenList[index]),
            );
          },
        ),
      ),
    );
  }
}
