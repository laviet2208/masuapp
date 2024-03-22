import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Item/Item%20l%E1%BB%8Bch%20s%E1%BB%AD%20giao%20h%C3%A0ng.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/Order/itemsendOrder.dart';

class Pagelichsugiaohang extends StatefulWidget {
  const Pagelichsugiaohang({Key? key,}) : super(key: key);

  @override
  State<Pagelichsugiaohang> createState() => _PagelichsugiaohangState();
}

class _PagelichsugiaohangState extends State<Pagelichsugiaohang> {
  List<itemsendOrder> sendList = [];
  void getDatasend() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/itemsendOrder").onValue.listen((event) {
      sendList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if ((itemorder.status == 'B' || itemorder.status == 'C' || itemorder.status == 'D' || itemorder.status == 'F' || itemorder.status == 'G' || itemorder.status == 'H') && itemorder.shipper.id == currentAccount.id) {
          sendList.add(itemorder);
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
    getDatasend();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: ListView.builder(
        itemCount: sendList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ItemLichsugiaohang(order: sendList[index]),
          );
        },
      ),
    );
  }
}
