import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';
import 'package:masuapp/MasuShip/screens/shipperScreen/history_order_page/history_order_item/complete_item/complete_food_order_item.dart';

import '../../../../../Data/OrderData/foodOrder/foodOrder.dart';

class complete_food_order_page extends StatefulWidget {
  const complete_food_order_page({super.key});

  @override
  State<complete_food_order_page> createState() => _complete_food_order_pageState();
}

class _complete_food_order_pageState extends State<complete_food_order_page> {
  List<foodOrder> orderList = [];
  List<foodOrder> chosenList = [];
  final searchController = TextEditingController();

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        if (value['timeList'] != null) {
          if (value['status'].toString() != 'A' || value['status'].toString() != 'B' || value['status'].toString() != 'C' || value['status'].toString() != 'D' || value['status'].toString() != 'E') {

          }
          foodOrder order = foodOrder.fromJson(value);
          orderList.add(order);
          chosenList.add(order);
          setState(() {sortbypushtime(chosenList);});
        }
      });

    });
  }

  void sortbypushtime(List<foodOrder> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.timeList[1].year.compareTo(a.timeList[1].year) != 0
          ? b.timeList[1].year.compareTo(a.timeList[1].year)
          : (b.timeList[1].month.compareTo(a.timeList[1].month) != 0
          ? b.timeList[1].month.compareTo(a.timeList[1].month)
          : (b.timeList[1].day.compareTo(a.timeList[1].day) != 0
          ? b.timeList[1].day.compareTo(a.timeList[1].day)
          : (b.timeList[1].hour.compareTo(a.timeList[1].hour) != 0
          ? b.timeList[1].hour.compareTo(a.timeList[1].hour)
          : (b.timeList[1].minute.compareTo(a.timeList[1].minute) != 0
          ? b.timeList[1].minute.compareTo(a.timeList[1].minute)
          : b.timeList[1].second.compareTo(a.timeList[1].second)))));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order_data();
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
        itemCount: chosenList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: complete_food_order_item(order: chosenList[index]),
          );
        },
      ),
    );
  }
}
