import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/itemsendOrder.dart';
import 'package:masuapp/GENERAL/Tool/Time.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20giao%20h%C3%A0ng/Itemgiaohang.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20giao%20h%C3%A0ng/Page%20chi%20ti%E1%BA%BFt%20%C4%91%C6%A1n%20giao%20h%C3%A0ng.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/Product/Voucher.dart';
import '../../../../INUSER/PAGE_HOME/Tính khoảng cách.dart';

class Pagegiaohang extends StatefulWidget {
  final double height;
  final double width;
  final Time data;
  final VoidCallback restartEvent;
  const Pagegiaohang({Key? key, required this.height, required this.width, required this.data, required this.restartEvent}) : super(key: key);

  @override
  State<Pagegiaohang> createState() => _PagegiaohangState();
}

class _PagegiaohangState extends State<Pagegiaohang> {
  List<itemsendOrder> orderList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/itemsendOrder").orderByChild('owner/Area').equalTo(currentAccount.Area).onValue.listen((event) {
      orderList.clear();
      widget.data.second = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        itemsendOrder itemorder = itemsendOrder.fromJson(value);
        if (itemorder.status == "A" && CaculateDistance.calculateDistance(itemorder.locationset.Latitude, itemorder.locationset.Longitude, currentLocatio.Latitude, currentLocatio.Longitude) <= 25) {
          orderList.add(itemorder);
          widget.data.second++;
        }
      });
      setState(() {
        sortOrdersByDistance(orderList, currentLocatio.Latitude, currentLocatio.Longitude);
        widget.restartEvent;
      });
    });
  }

  void sortOrdersByDistance(List<itemsendOrder> list, double currentLat, double currentLon) {
    list.sort((a, b) {
      double distanceA = CaculateDistance.calculateDistance(a.locationset.Latitude, a.locationset.Longitude, currentLat, currentLon);
      double distanceB = CaculateDistance.calculateDistance(b.locationset.Latitude, b.locationset.Longitude, currentLat, currentLon);
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
              child: Itemgiaohang(width: widget.width, order: orderList[index]),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) => Pagechitietdongiaohang(id: orderList[index].id, diemdon: orderList[index].locationset, diemtra: orderList[index].receiver.location, type: 1,)));
            },
          );
        }),
    );
  }
}
