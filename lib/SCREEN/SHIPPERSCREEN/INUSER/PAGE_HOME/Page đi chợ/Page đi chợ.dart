import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91%E1%BB%93%20%C4%83n/Chi%20ti%E1%BA%BFt%20%C4%91%C6%A1n%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91%E1%BB%93%20%C4%83n/Item%20%C4%91%E1%BB%93%20%C4%83n.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91i%20ch%E1%BB%A3/Chi%20ti%E1%BA%BFt%20%C4%91%C6%A1n%20%C4%91i%20ch%E1%BB%A3.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20%C4%91i%20ch%E1%BB%A3/Item%20%C4%91i%20ch%E1%BB%A3.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/Order/foodOrder.dart';
import '../../../../../GENERAL/Tool/Time.dart';
import '../../../../INUSER/PAGE_HOME/Tính khoảng cách.dart';

class Pagedicho extends StatefulWidget {
  final double height;
  final double width;
  final Time data;
  final VoidCallback restartEvent;
  const Pagedicho({Key? key, required this.height, required this.width, required this.data, required this.restartEvent}) : super(key: key);

  @override
  State<Pagedicho> createState() => _PagedoanState();
}

class _PagedoanState extends State<Pagedicho> {
  List<foodOrder> orderList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/productOrder").onValue.listen((event) {
      orderList.clear();
      widget.data.day = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        foodOrder foodorder = foodOrder.fromJson(value);
        if (foodorder.status == "B" && CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[0], CaculateDistance.parseDoubleString(foodorder.productList[0].owner.location)[1], currentLocatio.Latitude, currentLocatio.Longitude) <= 25) {
          orderList.add(foodorder);
          widget.data.day++;
        }
      });
      setState(() {
        sortOrdersByDistance(orderList, currentLocatio.Latitude, currentLocatio.Longitude);
        widget.restartEvent;
      });
    });
  }

  void sortOrdersByDistance(List<foodOrder> list, double currentLat, double currentLon) {
    list.sort((a, b) {
      double distanceA = CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(a.productList[0].owner.location)[0], CaculateDistance.parseDoubleString(a.productList[0].owner.location)[1], currentLat, currentLon);
      double distanceB = CaculateDistance.calculateDistance(CaculateDistance.parseDoubleString(b.productList[0].owner.location)[0], CaculateDistance.parseDoubleString(b.productList[0].owner.location)[1], currentLat, currentLon);
      return distanceA.compareTo(distanceB);
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
    return Container(
      width: widget.width,
      height: widget.height,
      child: ListView.builder(
          itemCount: orderList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Itemdicho(width: widget.width, order: orderList[index]),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => Chitietdondicho(id: orderList[index].id, diemdon: orderList[index].locationSet, diemtra: orderList[index].locationGet)));
              },
            );
          }),
    );
  }
}
