import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../FINAL/finalClass.dart';
import '../../../../GENERAL/Order/itemsendOrder.dart';
import '../../ITEM/ITEMcatch.dart';
import '../../ITEM/ITEMfood.dart';
import '../../ITEM/ITEMsend.dart';


class PAGEitemsend extends StatefulWidget {
  const PAGEitemsend({Key? key}) : super(key: key);

  @override
  State<PAGEitemsend> createState() => _PAGEhomeState();
}

class _PAGEhomeState extends State<PAGEitemsend> {
  List<itemsendOrder> orderList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/itemsendOrder").orderByChild('owner/Area').equalTo(currentAccount.Area).onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if (itemorder.status == "A") {
          orderList.add(itemorder);
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
    getData();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          child: ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20 , bottom: 20),
                child: InkWell(
                  onTap: () {

                  },
                  child: ITEMsend(order: orderList[index], width: screenWidth, height: 350),
                ),
              );
            },
          )
      ),
    );
  }
}
