import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/Page%20l%E1%BB%8Bch%20s%E1%BB%AD/Item/Item%20l%E1%BB%8Bch%20s%E1%BB%AD%20g%E1%BB%8Di%20xe.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/Order/catchOrder.dart';

class Pagelichsugoixe extends StatefulWidget {
  const Pagelichsugoixe({Key? key}) : super(key: key);

  @override
  State<Pagelichsugoixe> createState() => _PagelichsugoixeState();
}

class _PagelichsugoixeState extends State<Pagelichsugoixe> {
  List<catchOrder> orderList = [];

  void getDatacatch() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/catchOrder").onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        catchOrder catchorder = catchOrder.fromJson(value);
        if ((catchorder.status == 'B' || catchorder.status == 'C' || catchorder.status == 'D' || catchorder.status == 'F' || catchorder.status == 'G') && catchorder.shipper.id == currentAccount.id) {
          orderList.add(catchorder);
          setState(() {

          });
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
    getDatacatch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

      ),
      child: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Itemlichsugoixe(order: orderList[index]),
          );
        },
      ),
    );  }
}
