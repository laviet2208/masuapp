import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masuapp/GENERAL/Order/catchOrder.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20g%E1%BB%8Di%20xe/Chi%20ti%E1%BA%BFt%20%C4%91%C6%A1n%20g%E1%BB%8Di%20xe.dart';
import 'package:masuapp/SCREEN/SHIPPERSCREEN/INUSER/PAGE_HOME/Page%20g%E1%BB%8Di%20xe/Item%20g%E1%BB%8Di%20xe.dart';

import '../../../../../FINAL/finalClass.dart';
import '../../../../../GENERAL/Tool/Time.dart';
import '../../../../INUSER/PAGE_HOME/Tính khoảng cách.dart';

class Pagegoixe extends StatefulWidget {
  final double height;
  final double width;
  final Time data;
  final VoidCallback restartEvent;
  const Pagegoixe({Key? key, required this.height, required this.width, required this.data, required this.restartEvent}) : super(key: key);

  @override
  State<Pagegoixe> createState() => _PagegoixeState();
}

class _PagegoixeState extends State<Pagegoixe> {
  List<catchOrder> orderList = [];


  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Order/catchOrder").orderByChild('owner/Area').equalTo(currentAccount.Area).onValue.listen((event) {
      orderList.clear();
      widget.data.hour = 0;
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        catchOrder catchorder = catchOrder.fromJson(value);
        print(catchorder.toJson().toString());
        if (catchorder.status == "A" && catchorder.owner.Area == currentAccount.Area) {
          if ((currentAccount.type % 2 == 0 && catchorder.type % 2 != 0)) {
            orderList.add(catchorder);
            widget.data.hour++;
          }

          if ((currentAccount.type % 2 != 0 && catchorder.type % 2 == 0)) {
            orderList.add(catchorder);
            widget.data.hour++;
          }
        }
      });
      setState(() {
        sortOrdersByDistance(orderList, currentLocatio.Latitude, currentLocatio.Longitude);
      });
    });
  }

  void sortOrdersByDistance(List<catchOrder> list, double currentLat, double currentLon) {
    list.sort((a, b) {
      double distanceA = CaculateDistance.calculateDistance(a.locationSet.Latitude, a.locationGet.Longitude, currentLat, currentLon);
      double distanceB = CaculateDistance.calculateDistance(b.locationSet.Latitude, b.locationGet.Longitude, currentLat, currentLon);
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
                child: Itemgoixe(width: widget.width, order: orderList[index]),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => Chitietdongoixe(id: orderList[index].id, diemdon: orderList[index].locationSet, diemtra: orderList[index].locationGet)));
              },
            );
          }),
    );  }
}
