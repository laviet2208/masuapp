import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Item/Item%20l%E1%BB%8Bch%20s%E1%BB%AD%20%C4%91%E1%BB%93%20%C4%83n.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/Order/foodOrder.dart';

class Pagelichsudoan extends StatefulWidget {
  const Pagelichsudoan({Key? key}) : super(key: key);

  @override
  State<Pagelichsudoan> createState() => _PagelichsudoanState();
}

class _PagelichsudoanState extends State<Pagelichsudoan> {
  List<foodOrder> foodList = [];
  String status = '';

  void getDatafood() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/foodOrder").onValue.listen((event) {
      foodList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if ((foodorder.status == 'C' || foodorder.status == 'D' || foodorder.status == 'D1' || foodorder.status == 'H' || foodorder.status == 'I' || foodorder.status == 'J') && foodorder.shipper.id == currentAccount.id) {
          foodList.add(foodorder);
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
    getDatafood();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ItemLichsudoan(order: foodList[index]),
          );
        },
      ),
    );  }
}
