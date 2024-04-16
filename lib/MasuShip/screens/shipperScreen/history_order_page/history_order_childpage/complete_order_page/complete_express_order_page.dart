import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/MasuShip/Data/finalData/finalData.dart';

import '../../../../../Data/OrderData/expressOrder/expressOrder.dart';
import '../../history_order_item/complete_item/complete_express_order_item.dart';

class complete_express_order_page extends StatefulWidget {
  const complete_express_order_page({super.key});

  @override
  State<complete_express_order_page> createState() => _complete_express_order_pageState();
}

class _complete_express_order_pageState extends State<complete_express_order_page> {
  List<expressOrder> orderList = [];
  List<expressOrder> chosenList = [];
  // final searchController = TextEditingController();

  void get_order_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order").orderByChild('shipper/id').equalTo(finalData.shipper_account.id).onValue.listen((event) {
      orderList.clear();
      chosenList.clear();
      final dynamic restaurant = event.snapshot.value;
      restaurant.forEach((key, value) {
        if (value['item'] != null) {
          if (value['status'].toString() != 'A' || value['status'].toString() != 'B' || value['status'].toString() != 'C') {
            expressOrder order = expressOrder.fromJson(value);
            orderList.add(order);
            chosenList.add(order);
            setState(() {sortbypushtime(chosenList);});
          }
        }
      });

    });
  }

  void sortbypushtime(List<expressOrder> chosenList) {
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

  // void onSearchTextChanged(String value) {
  //   setState(() {
  //     chosenList = orderList
  //         .where((account) =>
  //     account.id.toLowerCase().contains(value.toLowerCase()) ||
  //         account.locationSet.mainText.toLowerCase().contains(value.toLowerCase()) ||
  //         account.locationSet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
  //         account.locationGet.mainText.toLowerCase().contains(value.toLowerCase()) ||
  //         account.locationGet.secondaryText.toLowerCase().contains(value.toLowerCase()) ||
  //         account.owner.name.toLowerCase().contains(value.toLowerCase()) ||
  //         account.owner.phone.toLowerCase().contains(value.toLowerCase()) ||
  //         account.shipper.name.toLowerCase().contains(value.toLowerCase()) ||
  //         account.shipper.phone.toLowerCase().contains(value.toLowerCase()) ||
  //         account.id.toString().toLowerCase().contains(value.toLowerCase()) ||
  //         account.item.toString().toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

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
            child: complete_express_order_item(order: chosenList[index]),
          );
        },
      ),
    );  }
}
