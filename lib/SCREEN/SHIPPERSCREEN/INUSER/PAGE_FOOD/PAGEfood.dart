import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../GENERAL/Order/foodOrder.dart';
import '../../ITEM/ITEMcatch.dart';
import '../../ITEM/ITEMfood.dart';


class PAGEfood extends StatefulWidget {
  const  PAGEfood({Key? key}) : super(key: key);

  @override
  State<PAGEfood> createState() => _PAGEhomeState();
}

class _PAGEhomeState extends State<PAGEfood> {
  List<foodOrder> orderList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/foodOrder").onValue.listen((event) {
      orderList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if (foodorder.status == "B") {
          orderList.add(foodorder);
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
                  child: ITEMfood(order: orderList[index], width: screenWidth, height: 350),
                ),
              );
            },
          )
      ),
    );
  }
}
